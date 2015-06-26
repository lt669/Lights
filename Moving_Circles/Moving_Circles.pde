int i = 0;
int j = 0;
int k = 0;
int a = 0;

int canX = 510;
int canY = 510;

int x;
int y;
int newX;
int newY;
//int moveX;
//int moveY;


//Create number of objects bassed on the Circle class

Circle ball1;
Circle ball2;

void setup() {
  size(canX, canY);
  ball1 = new Circle(100, 100, 5,0 , 50, 500);
  ball2 = new Circle(50, 50, 10, 0, 50, 50);
}

void draw() {
  background(102);
  ball1.move();
  ball1.display();
  ball2.move();
  ball1.collision();
  ball2.display();
  ball2.collision();
 // print("X:",ball1.x);
  
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
  int x1;
  int x2;
  int y1;
  int y2;

  
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
    
    //CIRCLE CIRCUMFRENCE
//    edgeXLeft = x - xLen;
//    edgeXRight = x + xLen;
//    edgeYTop = y - yLen;
//    edgeYBot = y + yLen;
    
  }
  
  void collision() {
  
   x1 = x - moveX;
   x2 = x + moveX;
   y1 = y - moveY;
   y2 = y + moveY;
  
  //Collision range
  
  
// if ((ball1.x == ball2.x) && (ball1.y == ball2.y || ball1.y == ball2.y1 || ball1.y == ball2.y)){
//  print("FUCK");
// }
 
 if (abs(ball1.y - ball2.y) <= ball1.moveY){
  c = 0;
 }
 
} 
  
}

//class colVal {
//  int edgeXLeft;
//  int edgeXRight;
//  int edgeYTop;
//  int edgeYBot;
//  
//  colCal(int edgeXLeft, int edgeXRight, int edgeYTop, int edgeYBot){
//    this.edgeXLeft = edgeXLeft;
//    this.edgeXRight = edgeXRight;
//    this.edgeYTop = edgeYTop;
//    this. edgeYBot = edgeYBot;
//  }
//}




//void glowRecMouse() {
//
//  stroke(255);
//  fill(mouseX/2, mouseY/2, mouseX/2);
//  ellipse(mouseX, mouseY, 100, 100);
//}
//
//void glowRec() {
//
//  stroke(255);
//  fill(i, j, k);
//  rect(100, 100, 250, 100); 
//
//
//  if (i == 255) {
//    a = 1;
//  } else if (i == 0) {
//    a = 0;
//  } else {
//    // Fuck all
//  }
//
//  if (a == 1 ) {
//    i--;
//    j--;
//    k--;
//  }
//
//  if (a == 0) {
//    i = i + 5;
//    j = j + 3;
//    k = k = 1;
//  }
//}

