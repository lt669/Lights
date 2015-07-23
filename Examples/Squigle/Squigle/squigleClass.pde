class squigleClass {

  float posX;
  float posY;

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


  squigleClass(float iPosX, float iPosY, int iPoints) {
    posX = iPosX;
    posY = iPosY;
    points = iPoints;

    xArray = new float[points+1];
    yArray = new float[points+1];
    
    List<Integer> xArray = new ArrayLisy<>();
    List<Integer> yArray = new ArrayLisy<>();

    xDirection = posX;
    yDirection = posY;
  }  


  void calcShape(int morePoints) {

    if(morePoints == 1){
    xArray = append(xArray,0);
    yArray = append(yArray,0);
    points += 1;
    }
    else if(morePoints == -1){
    for ( int p = 0; p<xArray.length; p++){
      xArray[p-1] = xArray[p];
      yArray[p-1] = yArray[p];
     points -= 1; 
    }
  }
    
    //Check if mouse has been pressed
    if (check == 0) {
      xDirection += cos(TWO_PI*count/10)*10;
      yDirection += sin(TWO_PI*count/10)*10;
    } else if (check == 1) {
      xDirection += random(-50, 50);
      yDirection += random(-50, 50);
    }

    //Calculate 'Head' position
    xArray[0] = xDirection;// + posX;
    yArray[0] = yDirection;// + posY;
    
    //NEW ARRAY LIST
    xArray.add(

    //Shift previous value o...
    for (int i = 0; i<points; i++) {
      xArray[points-i] = xArray[points-(i+1)];
      yArray[points-i] = yArray[points-(i+1)];
    }
    count++;
  }


  void drawShape() {

    stroke(0);
    strokeWeight(2);
    beginShape();
    for (int i=0; i<xArray.length; i++) {
      curveVertex(xArray[i], yArray[i]);
    } 
    endShape();
  }

float getPosX(){
 return xArray[0]; 
}

float getPosY(){
 return yArray[0]; 
}

  //    void drawShape() {
  //
  //      stroke(0);
  //      strokeWeight(10);
  //      beginShape(POINTS);
  //      for (int i=0; i<points; i++) {
  //        vertex(xArray[i], yArray[i]);
  //      } 
  //      endShape();
  //    }

  void printArray() {
    for (int i=0; i<points; i++) {
      print("\n xARRAY:", xArray[i]);
    }
  }



  //    void edgeCheck() {
  //      if (xDirection <= 0) {
  //        xDirection +=canX;
  //      } else if (yDirection <= 0) {
  //        yDirection += canY;
  //      } else if ( xDirection >= canX)
  //      {
  //        xDirection -= canX;
  //      } else if (yDirection >= canY) {
  //        yDirection -=canY;
  //      }
  //    }

  void edgeCheck() {
    if (xDirection <= 0) {
      xDirection = 0;
    } else if (yDirection <= 0) {
      yDirection = 0;
    } else if ( xDirection >= canX)
    {
      xDirection = canX;
    } else if (yDirection >= canY) {
      yDirection = canY;
    }
  }
}

