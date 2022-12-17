#include "topbar.h"
#include "gba.h"
#include "images/heart.h"
#include <stdio.h>

void drawHearts(int hearts) {
    if (hearts == 3)
    {
        drawImageDMA(10, WIDTH - 10, HEART_WIDTH, HEART_HEIGHT, heart);
        drawImageDMA(10, WIDTH - 30, HEART_WIDTH, HEART_HEIGHT, heart);
        drawImageDMA(10, WIDTH - 50, HEART_WIDTH, HEART_HEIGHT, heart);
    }
    if (hearts == 2)
    {
        drawImageDMA(10, WIDTH - 50, HEART_WIDTH, HEART_HEIGHT, heart);
        drawImageDMA(10, WIDTH - 30, HEART_WIDTH, HEART_HEIGHT, heart);
        drawRectDMA(10, WIDTH - 10, HEART_WIDTH, HEART_HEIGHT, BLACK);
    }
    if (hearts == 1)
    {
        drawImageDMA(10, WIDTH - 50, HEART_WIDTH, HEART_HEIGHT, heart);
        drawRectDMA(10, WIDTH - 10, HEART_WIDTH, HEART_HEIGHT, BLACK);
        drawRectDMA(10, WIDTH - 30, HEART_WIDTH, HEART_HEIGHT, BLACK);
    }
}

void drawTimer(int score) {
    char buffer[10];
    sprintf(buffer, "%d", score);
    drawString(10, 0, "Score: ", WHITE);
    drawRectDMA(10, 40, 40, 40, BLACK);
    drawString(10, 40, buffer, WHITE);
}