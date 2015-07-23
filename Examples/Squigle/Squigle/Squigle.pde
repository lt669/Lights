
int canX = 600;
int canY = 400;
int x = canX/2;
int y = canY/2;
int prevX = canX/2 - 25;
int prevY = canY/2 - 25;
int check;
int a = 10;
int count = 0;

float[] xArray = new float[11];
float[] yArray = new float[11];

 float xDirection;
 float yDirection;

void setup() {
  size(canX, canY);
  background(-1);
  //noLoop();
}


void draw() {

  background(-1);

  //if (check == 0) {
  calcShape();
  drawShape();
  edgeCheck();
  //printArray();
  // }
}


void calcShape() {

  if (check == 0) {
     xDirection = cos(TWO_PI*count/10)*10;
     yDirection = sin(TWO_PI*count/10)*10;
  } else if (check == 1) {

    xDirection = random(-5, 5);
    yDirection = random(-5, 5);
  }
  print("\n x:", xDirection);
  print("\n count:", count);

  //Calculate 'Head' position
  xArray[0] = xDirection + canX/2;
  yArray[0] = yDirection + canY/2;

  //Shift previous value o...
  for (int i = 0; i<a; i++) {
    xArray[a-i] = xArray[a-(i+1)];
    yArray[a-i] = yArray[a-(i+1)];
  }
  count++;
}

void drawShape() {

  stroke(0);
  beginShape();
  for (int i=0; i<a; i++) {
    curveVertex(xArray[i], yArray[i]);
  } 
  endShape();
}

void printArray() {

  for (int i=0; i<a; i++) {
    print("\n xARRAY:", xArray[i]);
  }
}

void mousePressed() {
  check = 1;
  // redraw();
}

void mouseReleased() {
  check = 0;
}

void edgeCheck() {

  if (x <= 0) {
    x +=canX;
  } else if ( y <= 0) {
    y += canY;
  } else if ( x>= canX)
  {
    x -= canX;
  } else if (y>= canY) {
    y -=canY;
  }
}

