/**
 * @file main.c
 * @author YOUR NAME HERE
 * @brief testing and debugging functions written in my_string.c and hw7.c
 * @date 2021-06-xx
 */

// You may add and remove includes as necessary to help facilitate your testing
#include <stdio.h>
#include "hw7.h"
#include "my_string.h"


void test(char *s) {
  printf(s);
}

/** main
 *
 * @brief used for testing and debugging functions written in my_string.c and hw7.c
 *
 * @param void
 * @return 0 on success
 */
int main(void)
{
  char *s = "Hello World!";
  test(s);
  return 0;
}
