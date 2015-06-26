//Added text

int i = 0;
int j = 0;
int k = 0;
int a = 0;
int b = 0;
int c = 0;

int canX = 510;
int canY = 510;

//int x = canX/2;
//int y = canY/2;
int x;
int y;
int newX;

void setup() {
  size(canX, canY);
}

void draw() {

  background(102);

  stroke(255);
  fill(0, 0, 0);
  ellipse(mouseX, mouseY, 50, 50);

  //glowRecMouse();
  x = newPos(newX);
  move(100, 100, 5, 1, x, 50);

  move(50, 50, 2, 2, x, 100);
} 

void move(int xLen, int yLen, int moveX, int moveY, int x, int y) {
  print("\n X:", x);
  print("\n moveX:", moveX);

  stroke(255);
  fill(x, y, x);
  ellipse(x, y, xLen, yLen); 

  //If circle reaches edge of canvas
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

newPos(newX);

}

int newPos (int newX){
  
  if (b == 1) {
    x = x + moveX;
    print("\n New X:", x);
  } else if (b == 0) {
    x = x - moveX;
  }

  if (c == 1) {
    y = y + moveY;
  } else if (c == 0) {
    y = y - moveY;
  }
  print("\n Returned X:", x);
  
  newX = x;
  
  return newX;
}

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

