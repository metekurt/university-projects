
#ifndef ROUND_ROBIN_H
#define ROUND_ROBIN_H


typedef int bool;
#define true 1
#define false 0

struct Process
{
    char name[4];
    int arrivalTime;
    bool added_Q;
    int ins_no;
    int total_ins;
    int instr[50];
    char instr_c[50][10];
};

struct Node
{
    struct Process job;
    struct Node* next;
};

struct LinkedList
{
    struct Node* front;
    struct Node* back;
};


void enqueue(struct Process record, struct LinkedList *queue);
struct Node *dequeue(struct LinkedList *queue);
void readFiles(struct Process record[], int * processes);
void fprint_queue(struct LinkedList* queue, FILE * fileptr);
bool isEmpty(struct LinkedList *queue);

#endif 

