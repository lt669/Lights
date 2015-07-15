//Class for drawing a randomly moving, size changing circle

class Cir {
  int posX;
  int posY;
  int maxSize;
  int size = 0;
  int bright;
  boolean DONE;
  boolean NEXT;

  //Constructor
  Cir(int iPosX, int iPosY, int iSize, int iBright) {
    posX = iPosX;
    posY = iPosY;
    maxSize = iSize;
    bright = iBright;
  }

  void drawCir() {

    //Random movement variables
    float incX = random(-15, 15);
    float incY = random(-15, 15);

    //Update position
    posX += incX;
    posY += incY;

    if (posX <= 0) {
      posX += canX;
    } else if (posX == canX) {
      posX -= canX;
    }

    if (posY <= 0) {
      posY += canY;
    } else if (posY >= canY) {
      posY -= canY;
    }

    //Alter circle size
    if (size == maxSize && DONE != true) {
      DONE = true;
      //print("\n DONE");
    } else if (DONE != true) {
      size++;
    } else {
      size = abs(size-1);
    }

    //Check if ready for the next value in the array
    if (size == 0 && DONE == true) {
      NEXT = true;
      DONE = false;
      //print("\n NEXT");
    } else {
      NEXT = false;
    }

    //Draw Line
//    stroke(250,250,250);
//    line(canX/2,canY/2,posX,posY);

    // Draw ellipse
    bright = 255 * 12/(bright+1);

//    stroke(255);
//    fill(255);
//    ellipse(posX, posY, size, size);
//    filter(BLUR, 1);

    stroke(bright, bright, bright);
    fill(0, 0, 0, bright);
    ellipse(posX, posY, size, size);
    if (size == maxSize && DONE != true) {
      //  print("\n Size:" + size + "Bright" + bright);
    }
  }

  boolean getNext() {
    return NEXT;
  }

  void setSize(int SIZE) {
    maxSize = SIZE;
  }

  void setBright(int BRIGHT) {
    bright = BRIGHT;
  }
}

