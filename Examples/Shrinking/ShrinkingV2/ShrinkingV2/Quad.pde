class Quad {

  int xPos, yPos;
  int xSize, ySize;
  int chooseStart = 0; //Start at 2 to keep starting square in place
  int elements = 1;
  int[][] shapesArray = new int[elements][8];
  int i = 0;
  int e = 0;

  int right = 0;
  int down = 1;
  int left = 2;
  int up = 3;

  int movement = right;
  boolean reChoose = false;


  //Array addresses
  int xPosition = 0;
  int yPosition = 1;
  int sizeX = 2;
  int sizeY = 3;
  int Hue = 4;
  int Saturation = 5;
  int Brightness = 6;
  int Choose = 7;


  //Constructor
  Quad(int iXPos, int iYPos, int iSize) {
    xPos = iXPos;
    yPos = iYPos;
    xSize = ySize = iSize;

    //Set initial conditions in array
    shapesArray[e][xPosition] = xPos;
    shapesArray[e][yPosition] = yPos;
    shapesArray[e][sizeX] = xSize;
    shapesArray[e][sizeY] = ySize;
  }

  void doQuad() {
    //Set randomised colours
    colorMode(HSB, 360, 100, 100, 100);
    int hue = round(random(0, 360));
    int sat = round(random(0, 100));
    int bri = round(random(0, 100));
    int alpha = 100; //round(random(0, 100));

    //Store varying elements into array
    shapesArray[e][Hue] = hue;
    shapesArray[e][Saturation] = sat;
    shapesArray[e][Brightness] = bri;

    drawQuad(); //Draw all previously calculated shapes
    extendArray(); // Add an extra element to the array
    //    println("\nStart Movement", movement);
    calcSize(); //Calculate the size of all the shapes
    chooseDirection(); // Calculate how the next shape will be drawn
    calcPosition(); //Test to see whether the shape can be drawn in this direction
    //    print("\nreChoose: ", reChoose);
    if (reChoose == true) {
      chooseDirection(); //Draw new shape in same as previous direction
    }
    shapesArray[e+1][Choose] = movement-1;
    if(shapesArray[e+1][Choose] == -1){
      shapesArray[e+1][Choose] = 3;
    }
    //    print(" - End Movement ", movement);
    e++; //Increment number of elements in array

    for (i=0; i<shapesArray.length; i++) {
      // println("i: "+i+" xPos: "+shapesArray[i][xPosition]+" yPos: "+shapesArray[i][yPosition]+" xSize: "+shapesArray[i][sizeX]+" ySize: "+shapesArray[i][sizeY]+" Choose: "+ shapesArray[i][Choose]);
    }
  }


  void drawQuad() {
    //Loop through array and draw all new shapes
    for (int x=0; x<shapesArray.length; x++) { 
      noStroke();
      fill(shapesArray[x][Hue], shapesArray[x][Saturation], shapesArray[x][Brightness]);
      rect(shapesArray[x][xPosition], shapesArray[x][yPosition], shapesArray[x][sizeX], shapesArray[x][sizeY]);
    }
    //Draw red mark at starting point
    stroke(0);
    fill(360, 100, 100);
    rect(shapesArray[e][xPosition], shapesArray[e][yPosition], 5, 5);
  }

  void extendArray() {
    //Create buffer array
    int[][] bufferArray = new int[shapesArray.length][8];

    //Copy stuff into the buffer array
    for (int x=0; x<shapesArray.length; x++) {
      for (int i=0; i<8; i++) {
        bufferArray[x][i] = shapesArray[x][i];
      }
    }

    //Reformat the shapesArray and add an element
    shapesArray = new int[e+2][8]; // +2 as we need 1 extra element, and array adresses start at 0, but declaring the size starts at 1

    //Copy elements back into shapesArray
    for (int x=0; x<bufferArray.length; x++) {
      for (int i=0; i<8; i++) {
        shapesArray[x][i] = bufferArray[x][i];
      }
    }
  }

  void calcSize() {
    //Calculate new size of the previously drawn shapes
    printArray();
    for (i=0; i<shapesArray.length - 1; i++) { 
      //Alter size in X direction
      if (shapesArray[i][sizeX] == 0) {
        //Do nothing, eventually delete the information from the array
      } else if (shapesArray[i][Choose] == left) {//This is due to the size of the shape being inverted
        shapesArray[i][sizeX] += 1;
      } else {
        shapesArray[i][sizeX] -= 1;
      }
      //Alter size in Y direction
      if (shapesArray[i][sizeY] == 0) {
        //Do nothing
      } else if (shapesArray[i][Choose] == up) {//This is due to the size of the shape being inverted
        shapesArray[i][sizeY] += 1;
      } else {
        shapesArray[i][sizeY] -= 1;
      }
    }

    //Random size varioables
    xSize = round(random(20, 50));
    ySize = round(random(20, 50));

    //Calculate size of the NEW shape
    shapesArray[e+1][sizeX] = xSize;
    shapesArray[e+1][sizeY] = ySize;

    //Calculate where the pervious shapes will be drawn
    for (i=0; i<shapesArray.length-1; i++) {
      //Calculae new xPosition
      if (shapesArray[i][xPosition] > canX/2) {
        shapesArray[i][xPosition] -= 1;
      } else if (shapesArray[i][xPosition] < canX/2) {
        shapesArray[i][xPosition] += 1;
      }

      //Calculae new yPosition
      if (shapesArray[i][yPosition] > canY/2) {
        shapesArray[i][yPosition] -= 1;
      } else if (shapesArray[i][yPosition] < canY/2) {
        shapesArray[i][yPosition] += 1;
      }
    }
  }

  void chooseDirection() {
    //Decide where the starting point of the shape will be based on whether it will fit
    if (movement == right) {
      Right();
    } else if (movement == down) {
      Down();
    } else if (movement == left) {
      Left();
    } else if (movement == up) {
      Up();
    }
  }

  void calcPosition() {
    reChoose = false;
    //Loop through all shapes and check for any overlap 
    for (int i=0; i<shapesArray.length - 1; i++) {  //Dont check against itself
      //check for any collisions in the X direction
      if (shapesArray[e+1][xPosition] + shapesArray[e+1][sizeX] >= shapesArray[i][xPosition] && shapesArray[e+1][xPosition] + shapesArray[e+1][sizeX] <= shapesArray[i][xPosition] + shapesArray[i][sizeX] && shapesArray[e+1][yPosition] + shapesArray[e+1][sizeY] >= shapesArray[i][yPosition] && shapesArray[e+1][yPosition] + shapesArray[e+1][sizeY] <= shapesArray[i][yPosition] + shapesArray[i][sizeY]) {
        movement -= 1; //Draw in the same direction again
        reChoose = true;
        // println("X collision");
        println("["+i+"/"+e+"]: "+ shapesArray[i][xPosition] +"," +shapesArray[i][yPosition] + "->" + (shapesArray[i][xPosition]+shapesArray[i][sizeX]) +"," + (shapesArray[i][yPosition]+shapesArray[i][sizeY]) + " - " + shapesArray[e][xPosition] + "," + shapesArray[e][yPosition] + "->" + (shapesArray[e][xPosition]+shapesArray[e][sizeX]) + "," + (shapesArray[e][yPosition]+shapesArray[e][sizeY]));
      }
      //
      //      if (shapesArray[e+1][yPosition] + shapesArray[e+1][sizeY] >= shapesArray[i][yPosition] && shapesArray[e+1][yPosition] + shapesArray[e+1][sizeY] <= shapesArray[i][yPosition] + shapesArray[i][sizeY]) { 
      //        movement -= 1; //Draw in the same direction again
      //        println("Y collision");
      //      }
    }
    if (movement <= -1) {
      movement = up;
    } else {
      movement += 1;
    }
    if (movement == 4) {
      //Start from the begining
      movement = right;
    }
  }

  void printArray() {
    println("");
    for (int i=0; i<shapesArray.length-1; i++) {//Might need to +1
      println(""+i+" x: "+shapesArray[i][xPosition]+" y: " +shapesArray[i][yPosition]+" xEnd: " +(shapesArray[i][xPosition]+shapesArray[i][sizeX])+" yEnd: "+(shapesArray[i][yPosition]+shapesArray[i][sizeY] + " Choose: "+ shapesArray[i][Choose]));
    }
  }


  void Right() {
    if (movement == right) {
      shapesArray[e+1][xPosition] = shapesArray[e][xPosition] + shapesArray[e][sizeX];
      shapesArray[e+1][yPosition] = shapesArray[e][yPosition];
    } else if (shapesArray[e][Choose] == up) {
      shapesArray[e+1][xPosition] = shapesArray[e][xPosition];
      shapesArray[e+1][yPosition] = shapesArray[e][yPosition] + shapesArray[e][sizeY];
    }
  }

  void Down() {
    shapesArray[e+1][xPosition] = shapesArray[e][xPosition];
    shapesArray[e+1][yPosition] = shapesArray[e][yPosition] + shapesArray[e][sizeY];
  }

  void Left() {
    //If the previous movement was also left
    if(shapesArray[e][Choose] == 2){
       shapesArray[e+1][xPosition] = shapesArray[e][xPosition] + shapesArray[e+1][sizeX] ;
       shapesArray[e+1][yPosition] = shapesArray[e][yPosition];
    }
    shapesArray[e+1][xPosition] = shapesArray[e][xPosition];
    shapesArray[e+1][yPosition] = shapesArray[e][yPosition];
    //    shapesArray[e+1][sizeX] = -(shapesArray[e][sizeX]); //THIS MAY NOT BE CORRECT
    //    shapesArray[e+1][sizeY] = -(shapesArray[e][sizeY]);

    shapesArray[e+1][sizeX] = shapesArray[e+1][sizeX] - (shapesArray[e+1][sizeX])*2;
    shapesArray[e+1][sizeY] = shapesArray[e+1][sizeY];// - (shapesArray[e+1][sizeY])*2;
  }

  void Up() {
    shapesArray[e+1][xPosition] = shapesArray[e][xPosition] + shapesArray[e][sizeX];
    shapesArray[e+1][yPosition] = shapesArray[e][yPosition];// + shapesArray[e][sizeY]; // THIS SIGN MIGHT NEED CHANGING
    shapesArray[e+1][sizeX] = shapesArray[e+1][sizeX];// - (shapesArray[e+1][sizeX])*2;
    shapesArray[e+1][sizeY] = shapesArray[e+1][sizeY] - (shapesArray[e+1][sizeY])*2;
  }
}

