#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Round_Robin.h"

const int SIZE = 20;

int main(int argc, char** argv)
{

	int test = 0;
  // Initializing clock variables.
  bool cpuOccupied = false; // Whether or not a job is in progress
  int  clockTime = 0; // Clock counter
  int  timeQuantum = 100;

  bool semaphore_w[10];
	int j = 0;
	for (;j < 10; j++)
	{
		semaphore_w[j] = false;
	}

  // Blocking out space for waiting queue, current job.
  struct Node* currentJob;
  memset(&currentJob, '\0', sizeof(currentJob));
  struct LinkedList readyQueue;
  memset(&readyQueue, '\0', sizeof(readyQueue));
  readyQueue.front = NULL;
  readyQueue.back = NULL;

  struct LinkedList waitQ[10];
    for(j = 0; j < 10; j++ )
    {
        memset(&waitQ[j], '\0', sizeof(waitQ[j]));
        waitQ[j].front = NULL;
        waitQ[j].back = NULL;
    }


  struct Process record[SIZE];
  memset(&record, '\0', sizeof(record));

  //Obtaining Processes Data
  int elements = 0;
  readFiles(record, &elements);

  for(j=0;j<4;j++){
	  int k=0;
	  for(;k<30;k++){
		  printf("%s\n",record[j].instr_c[k]);
	  }
  }
  //To output on the file during processing
    FILE *fileptr;
    fileptr = fopen("output.txt", "w");

    FILE *wQfile_ptr[10];
    char * filenames[10]={"output_0.txt\0", "output_1.txt\0", "output_2.txt\0","output_3.txt\0","output_4.txt\0","output_5.txt\0","output_6.txt\0","output_7.txt\0",
    		"output_8.txt\0","output_9.txt\0"};

	j=0;
	for (; j<10; j++)
	{
		wQfile_ptr[j] = NULL;

	}

  // Big clock loop
  do {

	  printf("%s", "Do loop\n");

        int remaining_time = timeQuantum;

        //Adding arrived processes to Queue
      int i = 0;
      for(; i < SIZE; i++)
      {

          if(record[i].total_ins > 0 && !record[i].added_Q && clockTime >= record[i].arrivalTime)
          {
        	  printf("%s","Adding arrived process\n");
              enqueue(record[i], &readyQueue);
              record[i].added_Q = true;
          }
      }

      //Adding previous process if it still has not exit and is not in wait Q
      if (currentJob!=NULL &&  (currentJob->job.ins_no < currentJob->job.total_ins) && currentJob->job.instr[currentJob->job.ins_no] != 0)
      {
    	  printf("%s","Adding prev process\n");
          enqueue(currentJob->job, &readyQueue);
      }


      //Output current condition of queue before running
      		  fprintf(fileptr,"%d",clockTime);
      		  fprintf(fileptr,"::");
      		  fprint_queue(&readyQueue, fileptr);

        //If no job is running get some process from queue
      if((cpuOccupied == false) && (!isEmpty(&readyQueue)))
      {
          currentJob = dequeue(&readyQueue);

          cpuOccupied = true;
      }

      //Run the process
      if (cpuOccupied == true && currentJob!=NULL)
      {
            //Execute atomic instructions if time remains
    	  	  //The second check for waitS n signS instruction at the end of cycle
            while(remaining_time > 0  || currentJob->job.instr[currentJob->job.ins_no] == 0)
            {

            	clockTime += currentJob->job.instr[currentJob->job.ins_no];
                remaining_time -= currentJob->job.instr[currentJob->job.ins_no];


                char s[10];
				for(j=0; j < 10; j++){
					s[j] = currentJob->job.instr_c[currentJob->job.ins_no][j];
				}

				char* token = strtok(s, "_");
				printf("***%s \n",currentJob->job.instr_c[currentJob->job.ins_no]);

				//WAIT S Operation
				if(strcmp(token,"waitS") == 0)
				{
					token = strtok(NULL," ");
					int wait_i = atoi(token);

					if(semaphore_w[wait_i]) //Some process has already used Semaphore
					{
						//Put in Q
						enqueue(currentJob->job, &waitQ[wait_i]);

						//Print in wait FIle

						if(wQfile_ptr[wait_i] == NULL){
							wQfile_ptr[wait_i] = fopen( filenames[wait_i], "w");
						}
						fprintf(wQfile_ptr[wait_i],"%d",clockTime);
						fprintf(wQfile_ptr[wait_i],"::");
						fprint_queue(&waitQ[wait_i], wQfile_ptr[wait_i]);


						//Terminate process
						remaining_time = 0;
						break;
					}
					if(!semaphore_w[wait_i]){ //Semaphore is not being used
						//Block it
						semaphore_w[wait_i] = true;

						//Continue your operation
					}
				}
				else if (strcmp(token,"signS") == 0) //Implement SignS logic
				{

					token = strtok(NULL," ");
					int wait_i = atoi(token);
					semaphore_w[wait_i] = false;
					  //Adding arrived processes to Queue
					  int in = 0;
					  for(; in < SIZE; in++)
					  {

						  if(record[in].total_ins > 0 && !record[in].added_Q && clockTime >= record[in].arrivalTime)
						  {
							  printf("%s","Adding arrived process\n");
							  enqueue(record[in], &readyQueue);
							  record[in].added_Q = true;
						  }
					  }

					//Add waiting semaphore to ready Q
					if (!isEmpty(&waitQ[wait_i])){
						struct Node* temp;
						memset(&temp, '\0', sizeof(temp));
						temp = dequeue(&waitQ[wait_i]);

						enqueue(temp->job, &readyQueue);

						//Print current condition on file
						fprintf(fileptr,"%d",clockTime);
						fprintf(fileptr,"::");
						fprint_queue(&readyQueue, fileptr);
					}

					//Print on waiting Q file
					fprintf(wQfile_ptr[wait_i],"%d",clockTime);
					fprintf(wQfile_ptr[wait_i],"::");
					fprint_queue(&waitQ[wait_i], wQfile_ptr[wait_i]);



					//Continue your tasks


				}



                currentJob->job.ins_no++;

                //All instructions executed
                if (currentJob->job.ins_no == currentJob->job.total_ins )
                {
                    remaining_time = 0;
                    //JOB Done
                    elements--;
                    break;
                }

            }


      }
      //If for some reasons there's some idle time
        else
            clockTime++;
      cpuOccupied = false;

  } while ((!isEmpty(&readyQueue))|| (elements > 0));


  //After all processes are executed
    fprintf(fileptr,"%d",clockTime);
    fprintf(fileptr,"::");
    fprint_queue(&readyQueue, fileptr);

    fclose(fileptr);

    for(j=0; j < 10;j++){
    	fclose(wQfile_ptr[j]);
    }

    printf("See output in output.txt");
  return (EXIT_SUCCESS);
}
