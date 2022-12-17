#include "list.c"

#include <stdio.h>

int main(void) {
    struct user_list *list = create_list();
    char *name = "Teetu";
    static struct user *user = create_user(name, STUDENT, (union user_data) {.student = {3, (double[]){59.9, 60.1, 100}}});
    int res = push_front(list, name, STUDENT, (union user_data) {.student = {3, (double[]){59.9, 60.1, 100}}}) == SUCCESS;
    printf("%d\n", res);
}
