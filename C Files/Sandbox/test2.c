#include<stdio.h>
struct test {
    int a;
    int b;
    long c;
    int d;
};
// struct test2 {
//     struct test t;
// };

int dp(struct test *p) {
    p->a = 5;
}
// int x = 5;
// void func(int a, int *b, int *c) {
//     a++;
//     c=b;
//     *b=a+7;
//     (*c)++;
// }
int main(void)
{
    struct test t;
    t.a = 1;
    dp(&t);
    printf("%d %d %d %d\n", t.a, t.b, t.c, t.d);

}