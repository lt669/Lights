//Class for drawing a randomly moving size changing circle

class Cir {
  int posX;
  int posY;
  int maxSize;
  int size = 0;
  int bright;
  boolean DONE;

  //Constructor
  Cir(int iPosX, int iPosY, int iSize, int iBright) {
    posX = iPosX;
    posY = iPosY;
    maxSize = iSize;
    bright = iBright;
  }

  void drawCir() {
    //Random movement variables
    float incX =  random(-15, 15);
    float incY =  random(-15, 15);

    //Update position
    posX += incX;
    posY += incY;

    //Alter circle size
    if (size == maxSize && DONE != true) {
      DONE = true;
    } else if (DONE != true) {
      size++;
    } else {
      size = abs(size-1);
    }

    //    if(DONE == true){
    //     
    //    }

    //Draw ellipse
    bright = 255/bright;
    fill(bright, bright, bright );
    ellipse(posX, posY, size, size);
    print("\n Size:", size);
  }
}

