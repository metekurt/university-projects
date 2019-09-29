#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Round_Robin.h"


// This function will add data to the queue. Its parameters includes the record
// which is being added to the queue and the queue itself. Because it should
// not return anything, it is a void function.
void enqueue(struct Process record, struct LinkedList *queue)
{
    struct Node* temp = (struct Node*)malloc(sizeof(struct Node));

    int i;
    for(i = 0; i < 4; i++)
    {
       temp->job.name[i] = record.name[i];
    }

    temp->job.arrivalTime = record.arrivalTime;


    for (i = 0; i < 50; i++)
    {
        temp->job.instr[i] = record.instr[i];
        
        int j = 0;
        for(;j<10;j++){
        	temp->job.instr_c[i][j] = record.instr_c[i][j];
        	
        }

    }
    temp->job.ins_no = record.ins_no;
    temp->job.total_ins = record.total_ins;
    temp->job.added_Q = false;

    temp->next = NULL;


    // If empty queue...
    if((queue->front == NULL) && (queue->back == NULL))
    {
        queue->front = temp;
        queue->back = temp;
    }

    else
    {
        queue->back->next = temp;
        queue->back = temp;
    }

}


// This function will delete an element from the queue. Its parameters include
// the queue in which a job will be deleted.
struct Node *dequeue(struct LinkedList *queue)
{
    struct Node* temp = queue->front;
    struct Node* recordInfo = temp;

    if((queue->front == NULL)&& (queue->back == NULL))
    {
        //printf("Queue is Empty\n");
    }

    // If there is only one element in queue
    else if(queue->front == queue->back)
    {
        queue->front = NULL;
        queue->back = NULL;
    }

    else
    {
        queue->front = queue->front->next;
    }

    return recordInfo;

}


// This function will read input from files. Its parameters include the record
// array which the input will be stored into and processed that tells the total number of processes.
void readFiles(struct Process record[], int * processes)
{
    char fileName[20];
    FILE *filePtr;
    FILE *instructions;
  
    filePtr = fopen("definition.txt", "r");


    if(filePtr == NULL)
    {
        printf("Could not open file 'definition.txt'. \n");
    }


    else
    {
        // Storing items from file into an array of jobs.
        int i = 0;

        while(fscanf(filePtr, "%s %s %d", &record[i].name,
                    fileName, &record[i].arrivalTime) != EOF)
        {
            //Executed instructions are zero on start
            record[i].ins_no = 0;

            //Storing instructions from corresponding instruction file
            instructions = fopen(fileName, "r");
            if(filePtr == NULL)
            {
                printf("Could not open file 'definition.txt'. \n");
            }
            else {
                int j = 0;
                char ins[10];
                while (fscanf(instructions, "%s %d",&record[i].instr_c[j], &record[i].instr[j]) != EOF)
                {
                	
                    j++;
                }
                record[i].total_ins = j;

                record[i].added_Q = false;

                fclose(instructions);
            }

            i++;
        }
        *processes = i;
    }

    fclose(filePtr);
}


// This function will tell whether the queue is empty or not. Its parameters
// include the queue. It will return a false if it is not empty or true if it
// is empty.
bool isEmpty(struct LinkedList *queue)
{
    if ((queue->front == NULL) && (queue->back == NULL))
    {
        return true;
    }

    else
    {
        return false;
    }
}


// This function will write the queue into output file. Its parameters include the queue which
// needs to be written and output file pointer
void fprint_queue(struct LinkedList* queue, FILE * fileptr)
{
    struct Node *ptr = queue->front;
    fprintf(fileptr, "HEAD-");
    if(ptr == NULL)
        fprintf(fileptr,"-");
    while(ptr != NULL)
    {
        fprintf(fileptr,"%s", ptr->job.name);
        fprintf(fileptr,"-");
        ptr = ptr->next;
    }
    fprintf(fileptr,"TAIL\n");
    return;
}


