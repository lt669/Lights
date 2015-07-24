
int canX = 600;
int canY = 400;
//int x = canX/2;
//int y = canY/2;
int check;

int nPoints = 10;

float newX = canX/2;
float newY = canY/2;

int input;
boolean pressed;

squigleClass sq1;
squigleClass sq2;
squigleClass sq3;
squigleClass sq4;

void setup() {
  noLoop();
  size(canX, canY);
  background(-1);

  sq1 = new squigleClass(newX, newY, nPoints);
  sq2 = new squigleClass(canX*3/4, canY*3/4, 5);
  sq3 = new squigleClass(canX*3/4, canY/4, 10);
  sq4 = new squigleClass(canX/4, canY*3/4, 30);
}


void draw() {
  pointsCalc();
  background(-1);



  //  sq1.calcShape(nPoints);
  //  sq1.edgeCheck();
  //  sq1.drawShape();
  //  newX = sq1.getPosX();
  //  newY = sq1.getPosY();

  sq2.calcShape(nPoints);
  sq2.drawShape();
  sq2.edgeCheck();
//    sq3.calcShape(nPoints);
//    sq3.drawShape();
//    sq3.edgeCheck();
  //  sq4.calcShape();
  //  sq4.drawShape();
  //  sq4.edgeCheck();
}

void mousePressed() {
  check = 1;
  redraw();
 // nPoints = -1;
}

void mouseReleased() {
  check = 0;
  //nPoints = 0;
}

void keyPressed() {
 pressed = true;
  redraw();
}

void keyReleased(){
 pressed = false; 
}

void pointsCalc(){
 
  if(pressed == true){
    nPoints = Character.digit(key,10);
    print("\nnPoints:",nPoints);
  }
  else if(pressed == false){
    nPoints = 0;
  }
}

//  
//  if (key == 'w') {
//    check = 1;
//  } else if (key == 's') {
//    check = 0;
//  } else if (key == 'i'){
//   nPoints = +1;
//  }

//  print("\n Points:", nPoints);


