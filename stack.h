#ifndef STACK_H
#define STACK_H

#include <stdlib.h>

typedef struct Stack {
    void **data;
    int size;
    int capacity;
} Stack;

Stack *stackCreate(int capacity);

void stackPush(Stack *stack, void *value);

void *stackPop(Stack *stack);

void *stackTop(Stack *stack);

int stackIsEmpty(Stack *stack);

void stackFree(Stack *stack);

void stackPrint(Stack *stack);

#endif  // STACK_H