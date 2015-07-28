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
  boolean secondPassed;
  int durationMod;
  int durationCounter = 0;
  int maxDuration;
  int last = 0;
  int millis;
  int seconds;
  int[] secondArray = new int[2]; // place to compair seconds values

  //Constructor
  Cir(int iPosX, int iPosY, int iSize, int iBright) {
    posX = iPosX;
    posY = iPosY;
    maxSize = iSize;
    bright = iBright;
  }

  void drawCir() {

    //Initialise counters
    millis = millis() - last;
    seconds = round(millis/1000);

    //Move last value down the array
    secondArray[1] = secondArray[0];
    secondArray[0] = seconds;

    //Determine whether a second has passed
    if (secondArray[0] > secondArray[1]) {
      secondPassed = true;
    } else if (secondArray[0] <= secondArray [1]) {
      secondPassed = false;
    }

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
    if (size == maxSize && DONE != true) { //Once circle has reached maxSize, DONE
      DONE = true;
      print("\n DONE");
    } else if (DONE != true && secondPassed == true) { //If its maximum size is not reached, increase size
      size++;
    } else if (DONE == true && size != 0){
      size = abs(size-1);
    }

    //Check if ready for the next value in the array
    if (size == 0 && DONE == true) {//Once circle has shurnk, get the next value
      NEXT = true;
      DONE = false;
      //print("\n NEXT");
    } else {
      NEXT = false;
    }

    //Duration counter
    //    if(DONE == false && durationCounter <= maxDuration){
    //      durationCounter++;
    //    } else if (DONE == true){
    //     durationCounter--;
    //    } else if (NEXT == true){
    //      durationCounter = 0;
    //    }

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

    //Reset the counter
    if (seconds == maxSize) {
      last = millis();
    }
    
    println("DONE: " + DONE + " - Seconds: " + seconds + " - maxSize: " + maxSize + " - Size: " + size);
    
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

