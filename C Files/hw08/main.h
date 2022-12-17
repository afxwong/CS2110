#ifndef MAIN_H
#define MAIN_H

#include "gba.h"
#include "game.h"

void drawPlayer(Runner *player);
void drawEnemy(Blocker *enemy);
void drawEndZone(void);
int handleInput(unsigned int prevButtons, unsigned int currButtons);
int checkCollision(Runner *player, Blocker *enemy[15]);
void movePlayer(Runner *player, int direction);    

#endif
