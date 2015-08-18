import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Main extends PApplet {

//Shared Variables
int canX = 1200;
int canY = 600;
boolean first, second;
int backCount = 0;
int BGCol;

//Cicles Variables
Table table;
int dur = 0;
int pit = 0;
PImage img;
char circleKey;
char squigleKey;
int choice = 0;
//char choice;

//Squigle Variables
float check = 0;
char nPoints;
//int nPoints = 1;
float newX = canX/2;
float newY = canY/2;
int input;
boolean pressed;
float move;

//Set up classes
squigleClass sq1;
squigleClass sq2;
squigleClass sq3;
squigleClass sq4;

Cir singer1;
Cir singer2;
Cir singer3;
Cir singer4;

Singer s1;
Singer s2;
Singer s3;
Singer s4;

public void setup() {
  size(canX, canY);
  background(-1);
  //Initialise new objects
  s1 = new Singer(1);
  s2 = new Singer(2);
  s3 = new Singer(3);
  s4 = new Singer(4);

  //Count number of elements for each singer
  s1.count();
  s2.count();
  s3.count();
  s4.count();

  //Circle Objects
  singer1 = new Cir(canX/4, canY/4, 0, 0);
  singer2 = new Cir(canX*3/4, canY/4, 0, 0);
  singer3 = new Cir(canX/4, canY*3/4, 0, 0);
  singer4 = new Cir(canX*3/4, canY*3/4, 0, 0);

  //Squigle Objects
  sq1 = new squigleClass(newX, newY);
  sq2 = new squigleClass(canX*3/4, canY*3/4);
  sq3 = new squigleClass(canX*3/4, canY/4);
  sq4 = new squigleClass(canX/4, canY*3/4);
}

public void draw() {

  //  if (backCount == 0) {
  //    colorMode(HSB, 360, 100, 100);
  //    background(360);
  //    // println("BG: ", BGCol);
  //  }
  //  backCount++;

  if (pressed == true) {
    background(-1);
  }

  if (choice < 4 || choice == 6) {
    //Fades out parts of the screen
    noStroke();
    colorMode(HSB,360,100,100);
    fill(360, 20);
    rect(random(canX), random(canY), canX/4, canY/4);
  } else if (choice == 7){
    noStroke();
    fill(360, 5);
    rect(0, 0, canX, canY);
  } else {
    background(-1);
  }
  s1.timer();
  s2.timer();
  s3.timer();
  s4.timer();

  //Depending on which key is pressed, select an object
  runCircleClass();
  runSquigleClass();
}

public void mousePressed() {
  check = 1;
}

public void mouseReleased() {
  check = 0;
}

public void keyPressed() {
  int select = Character.digit(key, 10);
  if (select == 1) {
    choice++;
  } else if (select == 2) {
    choice--;
  }
  pressed = true;
  println("Select", select);
  println("Choice: ", choice);
}

public void keyReleased() {
  pressed = false;
}

public void runCircleClass() {

  // background(-1);

  singer1.setBright(s1.getPitch());
  singer1.setSize(s1.getDuration());
  singer1.setSecondPassed(s1.getSecondPassed());
  singer1.drawCir();
  //  s1.printInfo();

  singer2.setBright(s2.getPitch());
  singer2.setSize(s2.getDuration());
  singer2.setSecondPassed(s2.getSecondPassed());
  singer2.drawCir();

  singer3.setBright(s3.getPitch());
  singer3.setSize(s3.getDuration());
  singer3.setSecondPassed(s3.getSecondPassed());
  singer3.drawCir();

  singer4.setBright(s4.getPitch());
  singer4.setSize(s4.getDuration());
  singer4.setSecondPassed(s4.getSecondPassed());
  singer4.drawCir();

//  float imgX = random(-5, 5);
//  float imgY = random(-5, 5);
}

public void runSquigleClass() {

  sq1.calcShape(s1.getDuration());
  sq1.edgeCheck();
  sq1.drawShape();

  sq2.calcShape(s2.getDuration());
  sq2.drawShape();
  sq2.edgeCheck();

  sq3.calcShape(s3.getDuration());
  sq3.drawShape();
  sq3.edgeCheck();

  sq4.calcShape(s4.getDuration());
  sq4.drawShape();
  sq4.edgeCheck();
}

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
  float Saturation;
  float Brightness;
  
  int movement = 1;
  
  boolean w;

  //Constructor
  Cir(int iPosX, int iPosY, int iSize, int iBright) {
    posX = iPosX;
    posY = iPosY;
    maxSize = iSize;
    bright = iBright;
  }

  public void drawCir() {

    //Random movement variables
    float incX = random(-size*movement, size*movement);
    float incY = random(-size*movement, size*movement);

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
//      print("\n DONE");
    } else if (DONE != true && secondPassed == true) { //If its maximum size is not reached, increase size
      size++;
    } else if (DONE == true && size != 0) {
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

    //Draw Line
    //  stroke(250,250,250);
    //  line(canX/2,canY/2,posX,posY);

    // Draw ellipse
  //  bright = 360 * 12/(bright+1);

    //        stroke(255);
    //        fill(255);
    //        ellipse(posX, posY, size, size);
    //        filter(BLUR, 1);

    //  if(bright == 255*12){
    //    size = 0;
    //  }

    if (choice == 1) {
      
      colorMode(HSB, 360, 100, 100);
      
//      println("bright: " + bright + " - Saturation: " + Saturation + " - Brightness: " + Brightness);

      // stroke(bright,Saturation, Brightness);
      noStroke();
      fill(bright, Saturation, Brightness, bright/2);
      ellipse(posX, posY, size*5, size*5);
    } else if (choice == 2) {
      
      colorMode(HSB, 360, 100, 100);
      float invert = 100 - Brightness;
      stroke(0, 0, bright);
      fill(0, bright, bright, invert);
      ellipse(posX, posY, size*5, size*5);
   
//      bright = round(map(bright, 0, 360, 0, 255));
//      println("bight: ",bright);
//      colorMode(RGB,255,255,255);
//      stroke(bright, bright, bright);
//     // stroke((255 - bright),(255 - bright), (255 - bright), (255 - bright));
//      fill(bright, 0, 0, bright);
//      ellipse(posX, posY, size*5, size*5);
    } else if (choice == 3){
      colorMode(HSB, 360, 100, 100);
      map(bright, 0, 12, 0, 360);
      stroke(bright, Saturation, Brightness, bright);
      fill(0, 0, 100, 0); //Setting last value to 0 makes the circles centres transparent 
      ellipse(posX, posY, size*5, size*5);
    }

    //  println("DONE: " + DONE + " - Seconds: " + seconds + " - maxSize: " + maxSize + " - Size: " + size + " - Bright: " + bright + " - Saturation: " + Saturation + " - Key: " + pressedKey);
  }

  public boolean getNext() {
    return NEXT;
  }

  public void setSize(int SIZE) {
    maxSize = SIZE;
  }

  public void setBright(int BRIGHT) {
  //  bright = BRIGHT;
    bright = round(map(BRIGHT, 0, 12, 0, 360)); 
    Saturation = round(map(BRIGHT, 0, 12, 0, 100));
    Brightness = round(map(BRIGHT, 0, 12, 0, 70));
  }
  
  public void setSecondPassed(boolean second){
    secondPassed = second;
  }
  
}

class Singer {

  //Initialise Arrays to store elements for each singer
  int[] pitch = new int[0];
  int[] duration = new int[0];
  int singerNo;
  int z = 0;
  int x = 0;
  int k;
  int retPitch;
  int retDuration;
  float millis;
  //Timer variables
  int last;
  int seconds;
  int[] secondArray = new int[2]; // place to compair seconds values
  boolean secondPassed;
  boolean NEXT;

  //Load CSV file
  Table table = loadTable("CSV.csv", "header");
  TableRow row;
  int rowNo = table.getRowCount();

  //Constructor
  Singer(int iSingerNo) {
    singerNo = iSingerNo;
  } 

  //Count the number of elements in the CSV file for each singer
  public void count() {
    for (TableRow row : table.rows ()) {
      if (row.getInt("Singer") == singerNo) {
        pitch = append(pitch, /*2 **/ row.getInt("Pitch"));
        duration = append(duration, /*2 **/ row.getInt("Duration"));
      }
    }
  }

  //Measure time passed and send new values from the arrays
  public void timer() {
    if (z < duration.length - 1) {
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

      if (seconds == duration[z]) {//If the duration of the note has been reached, send new data
        NEXT = true;
        last = millis();
        z++; // Increase array address
      } else {
        NEXT = false;
      }
    } else {
      println("END OF FILE");
    }
  }

  //Returns the current value under 'Pitch' in the CSV file
  public int getPitch() {
    if (/*z < rowNo/4 && */NEXT == true) {// 4 = number of singers at the moment
      retPitch = pitch[z];
    }
    //     print("\n Singer " + singerNo + " PITCH: ", retPitch);
    return retPitch;
  }

  //Returns the current value under 'Duration' in the CSV file
  public int getDuration() {
    if (/*z < rowNo/4 &&*/ NEXT == true) {
      retDuration = duration[z];
    }
    //      print(" DURATION: ", retDuration);
    return retDuration;
  }

  public boolean getSecondPassed() {
    return secondPassed;
  }

  public void printInfo() {
    if (NEXT == true) {
      println("\n Singer " + singerNo + " PITCH: " + retPitch + " DURATION: " + retDuration);
    }
  }
}

class squigleClass {

  float posX;
  float posY;
  int iPoints = 1;
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
  int[] numberOfPoints;

  //Variables to signify which array was last edited
  boolean largerUsed;
  boolean smallerUsed;

  //Constructor
  squigleClass(float iPosX, float iPosY) {
    posX = iPosX;
    posY = iPosY;

    //Initialise arrays
    xArray = new float[iPoints +1];
    yArray = new float[iPoints +1];
    newXArray = new float[iPoints +1];
    newYArray = new float[iPoints +1];
    numberOfPoints = new int[2];

    xDirection = posX; 
    yDirection = posY;
  }

  public void calcShape(int inputPoints) {
    println("inputPoints: ",inputPoints);
    points = inputPoints*5; //Make the chain longer
    numberOfPoints[1] = numberOfPoints[0];
    numberOfPoints[0] = points;
    //After ever 100 counts, randomise movement
    if (count == 1) {
      //Each object is given a random direction
      randMove = round(random(0, 3));
      divide = round(random(2, 16));
      curve = round(random(2, 10));
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

      if (randMove ==0) {
        float p = random(-5, 5);
        //      xDirection += sin(TWO_PI*count/10)*count + p;
        //      yDirection += 2;
        xDirection += cos((TWO_PI/divide)*count/10)*curve; 
        yDirection += sin((TWO_PI/divide)*count/10)*curve;
      } else if (randMove ==1) {
        float p = random(-5, 5);
        //      xDirection += sin(TWO_PI*count/10)*count + p;
        //      yDirection -= 2;  
        xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
        yDirection += sin((TWO_PI/divide)*count/10)*curve;
      } else if (randMove ==2) {
        float p = random(-5, 5);
        //      xDirection += 2;
        //      yDirection += sin(TWO_PI*count/10)*count + p;
        xDirection += cos((TWO_PI/divide)*count/10)*curve; 
        yDirection -= sin((TWO_PI/divide)*count/10)*curve;
      } else if (randMove ==3) {
        float p = random(-5, 5);
        //      xDirection -= 2;
        //      yDirection += sin(TWO_PI*count/10)*count + p;
        xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
        yDirection -= sin((TWO_PI/divide)*count/10)*curve;
      }
    }

    //Determine whether the array needs extending or shrinking
    if (numberOfPoints[0] > numberOfPoints[1]) {
      largerArray();
    } else if (numberOfPoints[0] < numberOfPoints[1]) {
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
  public void largerArray() {

    println("LARGE");
    //Increase number of points in array

    //If the last array used was the smaller one, copy data to new array
    if (smallerUsed == true) {
      xArray = new float[points +1]; 
      yArray = new float[points +1]; 
      //Copy data from smaller array into new larger ones
      arrayCopy(newXArray, 0, xArray, 0, numberOfPoints[1]); 
      arrayCopy(newYArray, 0, yArray, 0, numberOfPoints[1]);

      //If a load of new points have been added, make them equal to the last point with a value thats not 0
      for (int i=numberOfPoints[1]; i<points; i++) {
        if (numberOfPoints[1]>0) {
          xArray[i] = xArray[(numberOfPoints[1]-1)];
          yArray[i] = yArray[(numberOfPoints[1]-1)];
        } else {
          xArray[i] = xArray[numberOfPoints[1]];
          yArray[i] = yArray[numberOfPoints[1]];
        }
      }
    } else {
      //Create two buffer arrays used to temporarly store data
      float[] bufferXArray = new float[numberOfPoints[1]]; //Size of the previous number of points
      float[] bufferYArray = new float[numberOfPoints[1]]; 

      //Copy the 'newArray' to a 'bufferArray'
      for (int i=0; i<numberOfPoints[1]; i++) {
        bufferXArray[i] = xArray[i]; 
        bufferYArray[i] = yArray[i];
      }

      //Format 'newArray' with less elements
      xArray = new float[points +1]; 
      yArray = new float[points +1]; 

      //Copy old data into the formatted array but with 1 less element
      arrayCopy(bufferXArray, 0, xArray, 0, numberOfPoints[1]); 
      arrayCopy(bufferYArray, 0, yArray, 0, numberOfPoints[1]);

      //If a load of new points have been added, make them equal to the last point with a value thats not 0
      for (int i=numberOfPoints[1]; i<points; i++) {
        if (numberOfPoints[1] > 0) {
          xArray[i] = xArray[(numberOfPoints[1]-1)];
          yArray[i] = yArray[(numberOfPoints[1]-1)];
        } else {
          xArray[i] = xArray[numberOfPoints[1]];
          yArray[i] = yArray[numberOfPoints[1]];
        }
      }
    }

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
  public void smallerArray() {
    println("SMALL");
    println("Points: ", points);
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
  public void standardLargeArray() {
    for (int i = 0; i<points; i++) {
      xArray[points-i] = xArray[points-(i+1)]; 
      yArray[points-i] = yArray[points-(i+1)];
    }
    //Calculate 'Head' position
    xArray[0] = xDirection; 
    yArray[0] = yDirection;
  }

  //Function that updates the array ones it has shrunk
  public void standardSmallArray() {
    for (int i = 0; i<points; i++) {
      newXArray[points-i] = newXArray[points-(i+1)]; 
      newYArray[points-i] = newYArray[points-(i+1)];
    }
    //Calculate 'Head' position
    newXArray[0] = xDirection; 
    newYArray[0] = yDirection;
  }

  //THIS ONES PRETTY SICK BRO with black background
  public void drawShape() {
    if (choice == 4) {
      //      map(xDirection, 0, canX, 0, 360);
      //      map(yDirection, 0, canX, 0, 360);
      colorMode(HSB, 360);
      stroke(xDirection, yDirection, 100);
      strokeWeight(2);
      // fill(xDirection, yDirection, 100);
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
    } else if (choice == 5) {
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
    } else if (choice == 6) {
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
    }else if (choice == 7) {
      backCount = 0;
      BGCol = 360;
      int xColour = round(map(xDirection, 0, canX, 0, 360));
      //yColor = map(yDirection, 0, canY, 0, 360);
      colorMode(HSB, 360);
      noStroke();
      //stroke(xColour, xColour, 100); 
      //strokeWeight(2);
      fill(xColour,100,100,50);
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
    }
  }

  /*These are currently not being used */
  public float getPosX() {
    return xArray[0];
  }

  public float getPosY() {
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

  public void edgeCheck() {
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

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
