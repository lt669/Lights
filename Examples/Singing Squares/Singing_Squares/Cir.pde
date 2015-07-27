//Class for drawing a randomly moving, size changing circle

class Cir {
  int posX;
  int posY;
  int maxSize;
  int size = 0;
  int bright;
  boolean DONE;
  boolean NEXT;
  boolean durationTime;
  int durationMod;
  int durationCounter = 0;
  int maxDuration;

  //Constructor
  Cir(int iPosX, int iPosY, int iSize, int iBright) {
    posX = iPosX;
    posY = iPosY;
    maxSize = iSize;
    bright = iBright;
  }

  void drawCir() {

    //Get duration in seconds (60 fps)
    maxDuration = maxSize * 60;    
    
    //Random movement variables
    float incX = random(-size, size);
    float incY = random(-size, size);

    //Update position
    posX += incX;
    posY += incY;
    
    //Wrap around canvas
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
    if (durationCounter == maxDuration && DONE != true) {
      DONE = true;
      //print("\n DONE");
    } else if (DONE != true && bright != 255*12 && durationTime == true) {
      size++;
    } else {
      size = abs(size-1);
    }
    
    //Currently fucking this bit up
    if(durationMod == 1){
     durationTime = true;
     duration
  }
    durationMod = durationCounter % maxSize;

    //Check if ready for the next value in the array
    if (durationCounter == 0 && DONE == true) {
      NEXT = true;
      DONE = false;
      //print("\n NEXT");
    } else {
      NEXT = false;
    }
    
    //Duration counter
    if(DONE == false && durationCounter <= maxDuration){
      durationCounter++;
    } else if (DONE == true){
     durationCounter--;
    } else if (NEXT == true){
      durationCounter = 0;
    }
    
//    println("D",durationCounter);
//    println("MAX",maxSize);

    //Draw Line
//  stroke(250,250,250);
//  line(canX/2,canY/2,posX,posY);

    // Draw ellipse
    bright = 255 * 12/(bright+1);

//        stroke(255);
//        fill(255);
//        ellipse(posX, posY, size, size);
//        filter(BLUR, 1);

//  if(bright == 255*12){
//    size = 0;
//  }
  
    stroke(bright, bright, bright);
    fill(bright, 0, 0, bright);
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

  void keyPressed() {

    if (key == 'w') {
      maxSize += 1;
    }
  }
}


