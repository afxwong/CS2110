#include "title.h"
#include "gba.h"
#include "images/startscreen.h"

void drawTitleScreen(void)
{
    drawFullScreenImageDMA(startscreen);
    drawString(150, 60, "Get Past The Defense", BLACK);
}

int handleTitleTransition(unsigned int prevButtons, unsigned int currButtons)
{
    if (KEY_JUST_PRESSED(BUTTON_START, currButtons, prevButtons))
    {
        return 1;
    }
    return 0;
}