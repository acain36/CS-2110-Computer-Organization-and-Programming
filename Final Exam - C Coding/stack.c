/**
 * CS 2110 - Spring 2022
 * Final Exam - Implement Stack
 *
 * Name:
 */

/**
 * The following my_stack struct is defined in stack.h. You will need to use this to store your stack's data:
 *
 * struct my_stack {
 *   struct data_t *elements;   // pointer to the element at index 0 of the stack
 *   int numElements; // the number of elements currently in the stack
 *   int capacity;    // the current allocated size of the elements array
 * };
 *
 * struct data_t {
 *   int length; // length of the string this array element points to
 *   char *data; // the string itself, allocated on the heap
 * };
 */

// DO NOT MODIFY THE INCLUDE(s) LIST
#include "stack.h"

/** push
 *
 * Pushes the value data onto the top of the stack.
 *
 * If the stack doesn't have the capacity to hold the new element, you should return FAILURE.
 * If dynamic memory allocation fails at any point, you should return FAILURE.
 *
 * If dynamic memory allocation fails at any point, you should return FAILURE.
 *
 * Remember that the bottom of the stack should be at index 0 and the top of the stack should be
 * at the highest (used) index.
 *
 * @param stack A pointer to the stack struct.
 * @param data The string to be pushed onto the stack.
 * @return FAILURE if the stack or its element array or data is NULL or memory allocation fails, otherwise SUCCESS.
 */
int push(struct my_stack *stack, char *data)
{
  if(stack == NULL || (*stack).elements == NULL) {
    return FAILURE;
  }
  if(data == NULL) {
    return FAILURE;
  }
  if((*stack).numElements == (*stack).capacity) {
    return FAILURE;
  }

  //Finding the length of the string that data points to

  int length = 0;
  char *current = data;
  while(*(current) != '\0') {
    length++;
    current = current + 1;
  }

  //Creating a deep copy of the string onto the heap

  char *data_p = (char *) malloc(length + 1);

  //If malloc fails
  if(data_p == NULL) {
    return FAILURE;
  }

  //Copying contents of data into the allocated memory location
  int counter = 0;
  while(*(data + counter) != '\0' && counter <= length) {
    *(data_p + counter) = *(data + counter);
    counter ++;
  }
  *(data_p + counter) = '\0';

  //Putting the data at the end of the elements array
  (*stack).elements[(*stack).numElements].data = data_p;
  (*stack).elements[(*stack).numElements].length = length;
  (*stack).numElements = (*stack).numElements + 1;

  return SUCCESS;
}
