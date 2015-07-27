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
  int curve = 10;
  int divide = 8;

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

    xDirection = posX; 
    yDirection = posY;
    
    
  }  

  void calcShape(int morePoints) {

    //Calculate the direction the 'head' will be moving in
    if (check == 0) {
      //Each object is given a random direction
      randMove = round(random(0,3));
      
      //Random number to slightly move the hovering circle
      float p = random(19,20);
      xDirection += cos(TWO_PI*count/10)*p; 
      yDirection += sin(TWO_PI*count/10)*p;
    } else if (check == 1) {
      
      move = randMove;
      
      if(move ==0){
      float p = random(-5,5);
//      xDirection += sin(TWO_PI*count/10)*count + p;
//      yDirection += 2;
      xDirection += cos((TWO_PI/divide)*count/10)*curve; 
      yDirection += sin((TWO_PI/divide)*count/10)*curve;
      } else if (move ==1){
      float p = random(-5,5);
//      xDirection += sin(TWO_PI*count/10)*count + p;
//      yDirection -= 2;
      
      xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
      yDirection += sin((TWO_PI/divide)*count/10)*curve;
      
      } else if (move ==2){
      float p = random(-5,5);
//      xDirection += 2;
//      yDirection += sin(TWO_PI*count/10)*count + p;
      
      xDirection += cos((TWO_PI/divide)*count/10)*curve; 
      yDirection -= sin((TWO_PI/divide)*count/10)*curve;
      
      } else if (move ==3){
      float p = random(-5,5);
//      xDirection -= 2;
//      yDirection += sin(TWO_PI*count/10)*count + p;
      
      xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
      yDirection -= sin((TWO_PI/divide)*count/10)*curve;
    
      }
      

    }

    if (morePoints == 1) {
      largerArray();
    } else if (morePoints == 2) {
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

    if (count == 10) {
      count = 1;
    } else {
      count++;
    }
  }

  //Function that increases the size of the array and stores values
  void largerArray() {
    //Increase number of points
    points += 1; 

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
    //Calculate 'Head' position
    xArray[0] = xDirection; 
    yArray[0] = yDirection; 
    largerUsed = true; 
    smallerUsed = false;
  }

  //Function that shrinks the array and stores new values
  void smallerArray() {
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
    for (int i = 0; i< points; i++) {
    }
    //Calculate 'Head' position
    newXArray[0] = xDirection; 
    newYArray[0] = yDirection;

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


  void drawShape() {
    stroke(0); 
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
        curveVertex(xArray[0], yArray[0]); 
        curveVertex(xArray[i], yArray[i]);
      }
    }

    endShape();
  }


  /*These are currently not being used */
  float getPosX() {
    return xArray[0];
  }

  float getPosY() {
    return yArray[0];
  }

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

