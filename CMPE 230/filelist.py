#!/usr/bin/env python
import os, sys, argparse, datetime, re, ntpath, hashlib, zipfile
from dateutil.parser import parse

# ntpath works well for different OSes
def main():
    filedb = []    # filedb list will hold all file names to be listed based on options specified
    flag = 0       # flag is used to determine if a file is to be added to filedb or not
    # used for before and after date time file searching if -after/-before is specified
    after_dtstamp = ''
    before_dtstamp = ''
    # used for getting file related statistics
    tot_files_visited = 0
    tot_fbytes_listed = 0
    tot_fbytes_visited = 0


    # add all the optional and positional arguments
    # use action='store_true' if the option doesn't take any value like -duplcont/-duplname
    parser = argparse.ArgumentParser()
    parser.add_argument("-before", help="Files last modfied before a date")
    parser.add_argument("-after", help="Files last modified after a date")
    parser.add_argument("-match", help="Filenames matching a Python a regular expression")
    parser.add_argument("-bigger", help="Files having size greater than or equal to <int>")
    parser.add_argument("-smaller", help="Files having size less than or equal to <int>")
    parser.add_argument("-delete", action="store_true", help="Delete files")
    parser.add_argument("-zip", help="Package files in a zipfile")
    parser.add_argument("-duplcont", action="store_true", help="List files with same contents")
    parser.add_argument("-duplname", action="store_true", help="List files with same names")
    parser.add_argument("-stats", action="store_true", help="Print traversal statistics")
    parser.add_argument("-nofilelist", action="store_true", help="No file listing will be printed")
    parser.add_argument('dir', nargs='*', default=[os.getcwd()])

    # parse all the arguments given at script execution time
    args = parser.parse_args()

    # Verify that only one of -duplcont or -duplname given
    if args.duplcont and args.duplname:
        print 'Only one of -duplicont or -duplname can be given'
        exit(1)

    # Validate before date time if given - Test
    if args.before:
        parse(args.before)
        if 'T' in args.before:
            before_dtstamp = datetime.datetime.strptime(args.before, '%Y%m%dT%H%M%S')
        else:
            before_dtstamp = datetime.datetime.strptime(args.before, '%Y%m%d')

    # Validate after date time if given - Test
    if args.after:
        parse(args.after)
        if 'T' in args.after:
            after_dtstamp = datetime.datetime.strptime(args.after, '%Y%m%dT%H%M%S')
        else:
            after_dtstamp = datetime.datetime.strptime(args.after, '%Y%m%d')

    # args.dir will hold all the paths specified at script execution time
    # if no path is specified, then traverse the current directory and it's contents only
    for pth in args.dir:
        for root, dirs, files in os.walk(pth):
            # skip directories starting with a dot - hidden directories
            dirs[:] = [d for d in dirs if not d[0] == '.']

            # loop over all the files found in current directory
            for f in files:
                flag = 0     # will determine if a file is to be added or not

                # skip files starting with .
                if f[0] == '.':
                    continue

                # check if file's modified datetime is before the given date[time]
                if args.before and flag == 0:
                    # get the last modified datetime of file
                    dtstamp = datetime.datetime.fromtimestamp(int(os.path.getmtime(f)))
                    # if it is not then set the flag to 1 - file doesn't hold the requirement
                    if dtstamp > before_dtstamp:
                        flag = 1

                # check if file's modified datetime is after the desired datetime
                if args.after and flag == 0:
                    # get the last modified datetime of file
                    dtstamp = datetime.datetime.fromtimestamp(int(os.path.getmtime(f)))
                    # if it is not then set the flag to 1 - file doesn't hold the requirement
                    if dtstamp < after_dtstamp:
                        flag = 1

                # check if file is pattern match with the specified pattern using -match option
                if args.match and flag == 0:
                    # if pattern is not matched set the flag to 1
                    if re.match(args.match, f) == None:
                        flag = 1

                # check if file's size is bigger than the specified size using -bigger
                if args.bigger and flag == 0:
                    size = os.path.getsize(os.path.join(root, f))
                    # set the flag to 1 if size is smaller
                    if size < int(args.bigger):
                        flag = 1

                # check if file's size is smaller than the specified size using -smaller
                if args.smaller and flag == 0:
                    size = os.path.getsize(os.path.join(root, f))
                    # set the flag to 1 if size is bigger
                    if size > int(args.smaller):
                        flag = 1

                tot_files_visited += 1
                tot_fbytes_visited += int(os.path.getsize(os.path.join(root, f)))

                # if flag is 0 till this point means that file hold all the requirements
                # add the filename to filedb list
                if flag == 0:
                    filedb.append(os.path.join(root, f))
                    tot_fbytes_listed += int(os.path.getsize(os.path.join(root, f)))

    # find files from filedb which have duplicate name / duplicate contens
    # using simple name matching
    filedb_dup = []     # holds filenames - duplicate names / duplicate contents

    if args.duplname:
        for fpath in filedb:
            fname = ntpath.basename(fpath)
            for gpath in filedb:
                gname = ntpath.basename(gpath)
                if fname == gname:
                    if fpath != gpath and gpath not in filedb_dup:
                        filedb_dup.append(gpath)
        # Print files with duplicate names
        print filedb_dup
    # find files with duplicate contents by reading file contents and hashing it
    elif args.duplcont:
        for fpath in filedb:
            for gpath in filedb:
                if fpath == gpath: continue
                if check_duplcont(fpath, gpath):
                    if fpath != gpath and gpath not in filedb_dup:
                        filedb_dup.append(gpath)

    # zip files if -zip option is specified
    if args.zip:
        # zip files in filedb_dup if -duplname or -duplcont is given
        # else zip files in filedb
        if args.duplname or args.duplcont:
            # Create a zipfile for writing
            Zipfile = zipfile.ZipFile(args.zip, "w")

            # Write files to Zipfile
            for file in filedb_dup:
                Zipfile.write(file, compress_type=zipfile.ZIP_DEFLATED)
        else:
            # Create a zipfile for writing
            Zipfile = zipfile.ZipFile(args.zip, "w")

            # Write files to Zipfile
            for file in filedb:
                Zipfile.write(file, compress_type=zipfile.ZIP_DEFLATED)

    # delete files if -delete option is specified
    if args.delete:
        # delete files in filedb_dup if -duplname or -duplcont is given
        # else delete files in filedb
        if args.duplname or args.duplcont:
            for file in filedb_dup:
                os.remove(file)
        else:
            for file in filedb:
                os.remove(file)

    if not args.nofilelist:
        if args.duplname or args.duplcont:
            # list files with duplicate contents/names
            print filedb_dup
        else:
            # list all files matching the requirements
            print filedb

        # print statistics about visited files and listed files if -stats option specified
        if args.stats:
            print 'total number of files visited: {}\ntotal size of files ' \
                  'visited in bytes {}\ntotal number of files listed {}' \
                  '\ntotal size of files listed in bytes {}'.\
                format(tot_files_visited, tot_fbytes_visited,len(filedb), tot_fbytes_listed)



def chunk_reader(fobj, chunk_size=1024):
    #Generator that reads a file in chunks of bytes
    while True:
        chunk = fobj.read(chunk_size)
        if not chunk:
            return
        yield chunk

# check if the contents of fpath and gpath are same or not using hashing
def check_duplcont(fpath, gpath, hash=hashlib.sha1):
    hashobj = hash()

    for chunk in chunk_reader(open(fpath, 'rb')):
        hashobj.update(chunk)
    id1 = (hashobj.digest(), os.path.getsize(fpath))

    hashobj = hash()
    for chunk in chunk_reader(open(gpath, 'rb')):
        hashobj.update(chunk)
    id2 = (hashobj.digest(), os.path.getsize(gpath))

    # if contents are same then return 1 else return 0
    if id1 == id2:
        return 1
    else:
        return 0

# Program main entry point
if __name__ == '__main__':
    main()