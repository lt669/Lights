//Shared Variables
int canX = 900;
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
int choice;
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

void setup() {
  size(canX, canY);

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
  sq1 = new squigleClass(newX, newY, 10);
  sq2 = new squigleClass(canX*3/4, canY*3/4, 5);
  sq3 = new squigleClass(canX*3/4, canY/4, 10);
  sq4 = new squigleClass(canX/4, canY*3/4, 30);
}

void draw() {

//  if (backCount == 0) {
//    background(360);
//    println("BG: ",BGCol);
//  }
//  backCount++;
  
  
  background(360);

  //Depending on which key is pressed, select an object
  if (first == true) {// c = Circles
    runCircleClass();
  } else if (second == true) {//v = Squigles
    runSquigleClass();
  }
  println("BG END: ",BGCol);
}

void mousePressed() {
  check = 1;
}

void mouseReleased() {
  check = 0;
}

void keyPressed() {  

  choice = Character.digit(key, 10);
  pressed = true;

  if (choice == 1 || (choice == -1 && first == true)) {
    backCount = 0;
    first = true; 
    second = false;
    BGCol = 360;
    circleKey = key;
  } else if (choice == 2 || (choice == -1 && second == true)) {
    backCount = 0;
    //BGCol = 360;
    second = true; 
    first = false;
    squigleKey = key;
  }
}


void keyReleased() {
  pressed = false;
}

void pointsCalc() {
  if (pressed == true) {
    // nPoints = Character.digit(key, 10);
    nPoints = squigleKey;
    // println("\nnPoints:",nPoints);
  } else if (pressed == false) {
    nPoints = 0;
  } else {
    nPoints = nPoints;
  }
}

void runCircleClass() {

  // background(-1);

  //Fades out parts of the screen
  noStroke();
  fill(360, 20);
  rect(random(canX), random(canY), canX/4, canY/4);

  if (singer1.getNext() == true) {
    singer1.setBright(s1.getPitch());
    singer1.setSize(s1.getDuration());
  }
  singer1.drawCir();

  if (singer2.getNext() == true) {
    singer2.setBright(s2.getPitch());
    singer2.setSize(s2.getDuration());
  }
  singer2.drawCir();

  if (singer3.getNext() == true) {
    singer3.setBright(s3.getPitch());
    singer3.setSize(s3.getDuration());
  }
  singer3.drawCir();

  if (singer4.getNext() == true) {
    singer4.setBright(s4.getPitch());
    singer4.setSize(s4.getDuration());
  }
  singer4.drawCir();

  float imgX = random(-5, 5);
  float imgY = random(-5, 5);
}

void runSquigleClass() {
  pointsCalc();
  background(0);

  sq1.calcShape(nPoints);
  sq1.edgeCheck();
  sq1.drawShape();

  sq2.calcShape(nPoints);
  sq2.drawShape();
  sq2.edgeCheck();

//  sq3.calcShape(nPoints);
//  sq3.drawShape();
//  sq3.edgeCheck();
//
//  sq4.calcShape(nPoints);
//  sq4.drawShape();
//  sq4.edgeCheck();
//  println("nPoints: ", nPoints);
}

