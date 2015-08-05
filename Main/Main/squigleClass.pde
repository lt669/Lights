class squigleClass {

  float posX;
  float posY;
  int points;
  int count = 0;

  float[] xArray;
  float[] yArray;
  float[] newXArray;
  float[] newYArray;
  float xDirection;
  float yDirection;
  float randMove;
  int curve = 20;
  int divide = 16;
  int randomDiameter;
  int lowerD;

  boolean m;
  boolean n;
  boolean b;

  //Check whether the number of points received is greater or larger than the last value
  int[] pointsCheck;

  //Variables to signify which array was last edited
  boolean largerUsed;
  boolean smallerUsed;

  //Constructor
  squigleClass(float iPosX, float iPosY, int iPoints) {
    posX = iPosX;
    posY = iPosY;
    points = iPoints;

    //Initialise arrays
    xArray = new float[points+1];
    yArray = new float[points+1];
    newXArray = new float[points +1];
    newYArray = new float[points +1];
    pointsCheck = new int[2];

    xDirection = posX; 
    yDirection = posY;
  }

  void calcShape(char morePoints) {

    pointsCheck[0] = morePoints;
    points = pointsCheck[0];
    if (pointsCheck[0] > pointsCheck[1]) {
      morePoints = 'p'; //Change this eventually
    } else if (pointsCheck[0] < pointsCheck[1]) {
      morePoints = 'o';
    }

    //Shift value of 'points' down the array
    pointsCheck[1] = pointsCheck[0];


    //After ever 10 counts, randomise movement
    if (count == 1) {
      //Each object is given a random direction
      randMove = round(random(0, 3));
      divide = round(random(2, 16));
      curve = round(random(2, 20));
      randomDiameter =  round(random(10, 20));
      lowerD = randomDiameter - 2;
    }

    //Calculate the direction the 'head' will be moving in
    if (check == 0) {
      //Random number to slightly move the hovering circle
      float p = random(lowerD, randomDiameter);
      xDirection += cos(TWO_PI*count/10)*p; 
      yDirection += sin(TWO_PI*count/10)*p;
    } else if (check == 1) {

      //Assign random variable
      move = randMove;

      if (move ==0) {
        float p = random(-5, 5);
        //      xDirection += sin(TWO_PI*count/10)*count + p;
        //      yDirection += 2;
        xDirection += cos((TWO_PI/divide)*count/10)*curve; 
        yDirection += sin((TWO_PI/divide)*count/10)*curve;
      } else if (move ==1) {
        float p = random(-5, 5);
        //      xDirection += sin(TWO_PI*count/10)*count + p;
        //      yDirection -= 2;  
        xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
        yDirection += sin((TWO_PI/divide)*count/10)*curve;
      } else if (move ==2) {
        float p = random(-5, 5);
        //      xDirection += 2;
        //      yDirection += sin(TWO_PI*count/10)*count + p;
        xDirection += cos((TWO_PI/divide)*count/10)*curve; 
        yDirection -= sin((TWO_PI/divide)*count/10)*curve;
      } else if (move ==3) {
        float p = random(-5, 5);
        //      xDirection -= 2;
        //      yDirection += sin(TWO_PI*count/10)*count + p;
        xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
        yDirection -= sin((TWO_PI/divide)*count/10)*curve;
      }
    }
    //Depending on input calculate next squigle positions
    if (morePoints == 'p') {
      largerArray();
    } else if (morePoints == 'o') {
      smallerArray();
    } else {
      if (largerUsed == true) {
        standardLargeArray();
      } else if (smallerUsed == true) {
        standardSmallArray();
      } else {
        standardLargeArray();
      }
    }
    //Restart counter after 10
    if (count == 100) {
      count = 1;
    } else {
      count++;
    }
  }

  //Function that increases the size of the array and stores values
  void largerArray() {

    //Increase number of points in array
    //points += 1; 

    //If the last array used was the smaller one, copy data to new array
    if (smallerUsed == true) {
      xArray = new float[points]; 
      yArray = new float[points]; 
      //Copy data from smaller array into new larger ones
      arrayCopy(newXArray, 0, xArray, 0, points); 
      arrayCopy(newYArray, 0, yArray, 0, points);
    }

    //Add an element to the end of the 'Growing' array
    xArray = append(xArray, 0); 
    yArray = append(yArray, 0); 

    //Save the previous positions of the 'head' along the array
    for (int i = 0; i<points; i++) {
      xArray[points-i] = xArray[points-(i+1)];
      yArray[points-i] = yArray[points-(i+1)];
    }
    //Calculate new 'Head' position
    xArray[0] = xDirection; 
    yArray[0] = yDirection; 

    //State which array was last used
    largerUsed = true; 
    smallerUsed = false;
  }

  //Function that shrinks the array and stores new values
  void smallerArray() {

    //Decrease number of points & ensure it doesnt go below 0
    points -= 1; 
    if (points <= 1) {
      points = 1;
    }

    //If last array used was the larger one copy old data to new array
    if (largerUsed == true) {
      //Create new arrays with new 'points value'
      newXArray = new float[points +1]; 
      newYArray = new float[points +1]; 

      //Fill with almost all data from old array
      arrayCopy(xArray, 0, newXArray, 0, points); 
      arrayCopy(yArray, 0, newYArray, 0, points);
    } else {  
      //Create two buffer arrays used to temporarly store data
      float[] bufferXArray = new float[points+1]; 
      float[] bufferYArray = new float[points+1]; 
      //Copy the 'newArray' to a 'bufferArray'
      for (int i=0; i<points; i++) {
        bufferXArray[i] = newXArray[i]; 
        bufferYArray[i] = newYArray[i];
      }
      //Format 'newArray' with less elements
      newXArray = new float[points +1]; 
      newYArray = new float[points +1]; 

      //Copy old data into the formatted array but with 1 less element
      arrayCopy(bufferXArray, 0, newXArray, 0, points); 
      arrayCopy(bufferYArray, 0, newYArray, 0, points);
    }

    //Save the previous positions of the 'head' along the array
    for (int i = 0; i< points; i++) {
      newXArray[points-i] = newXArray[points-(i+1)]; 
      newYArray[points-i] = newYArray[points-(i+1)];
    }

    //Calculate 'Head' position
    newXArray[0] = xDirection; 
    newYArray[0] = yDirection;

    //State which array was last used
    smallerUsed = true; 
    largerUsed = false;
  }

  //Function that updates the array ones it has grown
  void standardLargeArray() {
    for (int i = 0; i<points; i++) {
      xArray[points-i] = xArray[points-(i+1)]; 
      yArray[points-i] = yArray[points-(i+1)];
    }
    //Calculate 'Head' position
    xArray[0] = xDirection; 
    yArray[0] = yDirection;
  }

  //Function that updates the array ones it has shrunk
  void standardSmallArray() {
    for (int i = 0; i<points; i++) {
      newXArray[points-i] = newXArray[points-(i+1)]; 
      newYArray[points-i] = newYArray[points-(i+1)];
    }
    //Calculate 'Head' position
    newXArray[0] = xDirection; 
    newYArray[0] = yDirection;
  }

  //THIS ONES PRETTY SICK BRO with black background
  void drawShape() {

    if (squigleKey == 'k') {
      m = false;
      n= false;
      b = false;
    }

    if (squigleKey == 'm' || m ==true) {
      //      map(xDirection, 0, canX, 0, 360);
      //      map(yDirection, 0, canX, 0, 360);
      colorMode(HSB, 360);
      stroke(xDirection, yDirection, 100); 
      strokeWeight(2);
      fill(xDirection, yDirection, 100);
      beginShape(); 
      if (largerUsed == true) {
        for (int i=0; i<xArray.length; i++) {
          curveVertex(xArray[i], yArray[i]);
        }
      } else if (smallerUsed == true) {
        for (int x=0; x<newXArray.length; x++) {
          curveVertex(newXArray[x], newYArray[x]);
        }
      } else {
        for (int i=0; i<xArray.length; i++) {
          curveVertex(xArray[i], yArray[i]);
        }
      }
      endShape();
      m = true;
      n = false;
      b = false;
    } else if (squigleKey == 'n' || n == true) {
      //    map(xDirection, 0, canX, 0 ,360);
      //    map(yDirection, 0, canX, 0, 360);
      colorMode(HSB, 360);
      stroke(xDirection, yDirection, 100); 
      strokeWeight(2);
      beginShape(TRIANGLES); 
      if (largerUsed == true) {
        for (int i=0; i<xArray.length; i++) {
          vertex(xArray[i], yArray[i]);
        }
      } else if (smallerUsed == true) {
        for (int x=0; x<newXArray.length; x++) {
          vertex(newXArray[x], newYArray[x]);
        }
      } else {
        for (int i=0; i<xArray.length; i++) {
          vertex(xArray[i], yArray[i]);
        }
      }
      endShape();
      m = false;
      n = true;
      b = false;
    } else if (squigleKey == 'b' || b == true) {
      backCount = 0;
      BGCol = 360;
      int xColour = round(map(xDirection, 0, canX, 0, 360));
      //yColor = map(yDirection, 0, canY, 0, 360);
      colorMode(HSB, 360);
      stroke(xColour, xColour, 100); 
      strokeWeight(2);
      // fill(xDirection,yDirection,100);
      beginShape(); 
      if (largerUsed == true) {
        for (int i=0; i<xArray.length; i++) {
          curveVertex(xArray[i], yArray[i]);
        }
      } else if (smallerUsed == true) {
        for (int x=0; x<newXArray.length; x++) {
          curveVertex(newXArray[x], newYArray[x]);
        }
      } else {
        for (int i=0; i<xArray.length; i++) {
          curveVertex(xArray[i], yArray[i]);
        }
      }
      endShape();
      m = false;
      n = false;
      b = true;
    }
  }

  /*These are currently not being used */
  float getPosX() {
    return xArray[0];
  }

  float getPosY() {
    return yArray[0];
  }

  //Receive number of points (duration)
  // int setPoints(int setPOINTS){
  //   pointsCheck[0] = setPOINTS;
  //   points = pointsCheck[0];
  //   if(pointsCheck[0] > pointsCheck[1]){
  //    morePoints = 'p'; //Change this eventually
  //   } else if (pointsCheck[0] < pointsCheck[1]){
  //    morePoints = 'o'; 
  //   }
  //   
  //   //Shift value of 'points' down the array
  //   pointsCheck[1] = pointsCheck[0];
  //   
  // }

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
