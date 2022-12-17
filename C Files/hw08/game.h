#ifndef GAME_H
#define GAME_H

#define OBJ_WIDTH 5
#define LEFT_BOUNDARY 0
#define RIGHT_BOUNDARY (WIDTH - OBJ_WIDTH)
#define TOP_BOUNDARY 20
#define BOTTOM_BOUNDARY (HEIGHT - OBJ_WIDTH)

typedef struct runner
{
    int x;
    int y;
    int lives;
    int score;
} Runner;

typedef struct blocker
{
    int x;
    int y;
} Blocker;

#endif
