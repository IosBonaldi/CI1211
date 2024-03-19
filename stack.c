#include "stack.h"

#include <stdio.h>
#include <stdlib.h>

Stack *stackCreate(int capacity) {
    Stack *stack = (Stack *)malloc(sizeof(Stack));
    stack->data = (void **)malloc(sizeof(void *) * capacity);
    stack->size = 0;
    stack->capacity = capacity;
    return stack;
}

void stackPush(Stack *stack, void *value) {
    if (stack->size == stack->capacity) {
        stack->capacity *= 2;
        stack->data = (void **)realloc(stack->data, sizeof(void *) * stack->capacity);
    }
    stack->data[stack->size++] = value;
}

void *stackPop(Stack *stack) {
    if (stack->size == 0) {
        return NULL;
    }
    return stack->data[--stack->size];
}

void *stackTop(Stack *stack) {
    if (stack->size == 0) {
        return NULL;
    }
    return stack->data[stack->size - 1];
}

int stackIsEmpty(Stack *stack) { return stack->size == 0; }

void stackFree(Stack *stack) {
    free(stack->data);
    free(stack);
}

void stackPrint(Stack *stack) {
    for (int i = 0; i < stack->size; i++) {
        printf("%d ", *(int *)stack->data[i]);
    }
    printf("\n");
}