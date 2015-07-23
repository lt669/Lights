class squigleClass {

  int posX;
  int posY;

  int prevX = canX/2 - 25;
  int prevY = canY/2 - 25;
//  int check;
  int points;
  int count = 0;

  float[] xArray;
  float[] yArray;

  float xDirection;
  float yDirection;

  //Constructor


  squigleClass(int iPosX, int iPosY, int iPoints) {
    posX = iPosX;
    posY = iPosY;
    points = iPoints;

    xArray = new float[points+1];
    yArray = new float[points+1];
  }  


  void calcShape() {

    //Check if mouse has been pressed
    if (check == 0) {
      xDirection += cos(TWO_PI*count/10)*10;
      yDirection += sin(TWO_PI*count/10)*10;
    } else if (check == 1) {
      xDirection += random(-50, 50);
      yDirection += random(-50, 50);
    }
    //    print("\n x:", xDirection);
    //    print("\n count:", count);

    //Calculate 'Head' position
    xArray[0] = xDirection + posX;
    yArray[0] = yDirection + posY;

    //Shift previous value o...
    for (int i = 0; i<points; i++) {
      xArray[points-i] = xArray[points-(i+1)];
      yArray[points-i] = yArray[points-(i+1)];
    }
    count++;
    
  }


    void drawShape() {

      stroke(0);
      beginShape();
      for (int i=0; i<points; i++) {
        curveVertex(xArray[i], yArray[i]);
      } 
      endShape();
    }

    void printArray() {

      for (int i=0; i<points; i++) {
        print("\n xARRAY:", xArray[i]);
      }
    }



    void edgeCheck() {
      if (xArray[0] <= 0) {
        xArray[0] +=canX;
      } else if ( yArray[0] <= 0) {
        yArray[0] += canY;
      } else if ( xArray[0] >= canX)
      {
        xArray[0] -= canX;
      } else if (yArray[0] >= canY) {
        yArray[0] -=canY;
      }
    }
  }

