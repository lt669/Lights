//Pointless line

int i = 0;
int j = 0;
int k = 0;
int a = 0;

int canX = 510;
int canY = 510;

//int x = canX/2;
//int y = canY/2;
int x;
int y;
int newX;
int newY;
int moveX;
int moveY;
//int initX;
//int initY;

//Create number of objects bassed on the Circle class

Circle ball1;
Circle ball2;

void setup() {
  size(canX, canY);
  ball1 = new Circle(100, 100, 15, 5, 500, 500);
  ball2 = new Circle(50, 50, 10, 16, 50, 50);
}

void draw() {
  background(102);
  ball1.move();
  ball1.display();
  ball2.move();
  ball2.display();
  
}

class Circle{
 // Local Variables to this class
  int xLen;
  int yLen;
  int moveX;
  int moveY;
  int x;
  int y;
  int b = 0;
  int c = 0;
  
  //Constructor
  Circle(int initXLen, int initYLen, int initMoveY, int initMoveX, int initX, int initY){
   xLen = initXLen;
   yLen = initYLen;
   moveX = initMoveX;
   moveY = initMoveY;
   x = initX;
   y = initY; 
  }
  
  void display() {
    stroke(255);
    fill(x, y, x);
    ellipse(x, y, xLen, yLen); 
  }
  
  void move(){
      
    if (x <= 0) {
      b = 1;
    } else if (x >= canX) {
      b = 0;
    }
    
    if (y <= 0) {
      c = 1;
    } else if (y >= canY) {
      c = 0;
    }
    
    if (b == 1) {
      x = x + moveX;
    } else if (b == 0) {
      x = x - moveX;
    }
    
     if (c == 1) {
      y = y + moveY;
    } else if (c == 0) {
      y = y - moveY;
    }
    
  }

}


//void move(int xLen, int yLen, int moveX, int moveY, int x, int y) {
//  print("\n X:", x);
//  print("\n moveX:", moveX);
//
//  stroke(255);
//  fill(x, y, x);
//  ellipse(x, y, xLen, yLen); 
//
//  //If circle reaches edge of canvas
//  if (x <= 0) {
//    b = 1;
//  } else if (x >= canX) {
//    b = 0;
//  }
//  
//  if (y <= 0) {
//    c = 1;
//  } else if (y >= canY) {
//    c = 0;
//  }
//
//  newXPos(moveX);
//  newYPos(moveY);
//}

//int newXPos (int moveX){
//  
//  if (b == 1) {
//    x = x + moveX;
//    print("\n New X:", x);
//  } else if (b == 0) {
//    x = x - moveX;
//  }
//
//  print("\n Returned X:", x);
//  newX = x;
//  return newX;
//}
//
//int newYPos (int moveY){
//  
//   if (c == 1) {
//    y = y + moveY;
//  } else if (c == 0) {
//    y = y - moveY;
//  }
//    newY = y;
//    return newY;
//}

void glowRecMouse() {

  stroke(255);
  fill(mouseX/2, mouseY/2, mouseX/2);
  ellipse(mouseX, mouseY, 100, 100);
}

void glowRec() {

  stroke(255);
  fill(i, j, k);
  rect(100, 100, 250, 100); 


  if (i == 255) {
    a = 1;
  } else if (i == 0) {
    a = 0;
  } else {
    // Fuck all
  }

  if (a == 1 ) {
    i--;
    j--;
    k--;
  }

  if (a == 0) {
    i = i + 5;
    j = j + 3;
    k = k = 1;
  }
}

