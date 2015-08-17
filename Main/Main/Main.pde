//Shared Variables
int canX = 1650;
int canY = 600;
boolean first, second;
int backCount = 0;
int BGhue = 0;
int BGsat = 0;
int BGbri = 100;
int colorBright; //graphics brightness variable

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

//Singer s1;
//Singer s2;
//Singer s3;
//Singer s4;

textFileReader PART1;
textFileReader PART2;
textFileReader PART3;
textFileReader PART4;
textFileReader PART5;
textFileReader PART6;

void setup() {

  //Load .txt files to singer classes
  PART1 = new textFileReader("Part1.txt");
  PART2 = new textFileReader("Part2.txt");
  PART3 = new textFileReader("Part3.txt");
  PART4 = new textFileReader("Part4.txt");
  PART5 = new textFileReader("Part5.txt");
  PART6 = new textFileReader("Part6.txt");

  //Read Data from .txt files
  PART1.read();
  PART2.read();
  PART3.read();
  PART4.read();
  PART5.read();
  PART6.read();
  
  PART1.rangeCalc();

  //Initialise new objects
  //  s1 = new Singer(1);
  //  s2 = new Singer(2);
  //  s3 = new Singer(3);
  //  s4 = new Singer(4);

  //Count number of elements for each singer
//  s1.count();
//  s2.count();
//  s3.count();
//  s4.count();

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

  size(canX, canY);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
  
  //noLoop();
}

void draw() {
  colorMode(HSB, 360, 100, 100);

  //  if (backCount == 0) {
  //    colorMode(HSB, 360, 100, 100);
  //    background(360);
  //    // println("BG: ", BGCol);
  //  }
  //  backCount++;

  if (pressed == true) {
    background(BGhue, BGsat, BGbri);
  }

  if (choice < 4 || choice == 6) {
    //Fades out parts of the screen
    noStroke();
    fill(BGhue, BGsat, BGbri, 20);
    rect(random(canX), random(canY), canX/4, canY/4);
  } else if (choice == 7) {
    noStroke();
    fill(BGhue, BGsat, BGbri, 10);
    rect(0, 0, canX, canY);
  } else {
    background(BGhue, BGsat, BGbri);
  }
  //  s1.timer();
  //  s2.timer();
  //  s3.timer();
  //  s4.timer();

  PART1.timer();
//  PART2.timer();
//  PART3.timer();
//  PART4.timer();
//  PART5.timer();
//  PART6.timer();

  //Depending on which key is pressed, select an object
  runCircleClass();
  runSquigleClass();
}

void mousePressed() {
  check = 1;
  redraw();
}

void mouseReleased() {
  check = 0;
}

void keyPressed() {
  int select = Character.digit(key, 10);
  if (select == 1) {
    choice++;
  } else if (select == 2) {
    choice--;
  } else if (select == 3) { //Black BG, flat colours
    BGhue = 0;
    BGsat = 0;
    BGbri = 0;
    colorBright = 1;
  } else if (select == 4) { //Black BG, bright colours
    BGhue = 0;
    BGsat = 0;
    BGbri = 0;
    colorBright = 2;
  } else if (select == 5) { //White BG, flat colours
    BGhue = 0;
    BGsat = 0;
    BGbri = 100;
    colorBright = 1;
  } else if (select == 6) { //White BG, bright colours
    BGhue = 0;
    BGsat = 0;
    BGbri = 100;
    colorBright = 2;
  }
  pressed = true;
  println("Select", select);
  println("Choice: ", choice);
}

void keyReleased() {
  pressed = false;
}

void runCircleClass() {

  // background(-1);

  singer1.setBright(PART1.getPitch());
  singer1.setSize(PART1.getDuration());
  singer1.setSecondPassed(PART1.getSecondPassed());
  singer1.drawCir();
  //  s1.printInfo();

//  singer2.setBright(PART2.getPitch());
//  singer2.setSize(PART2.getDuration());
//  singer2.setSecondPassed(PART2.getSecondPassed());
//  singer2.drawCir();

//  singer3.setBright(s3.getPitch());
//  singer3.setSize(s3.getDuration());
//  singer3.setSecondPassed(s3.getSecondPassed());
//  singer3.drawCir();
//
//  singer4.setBright(s4.getPitch());
//  singer4.setSize(s4.getDuration());
//  singer4.setSecondPassed(s4.getSecondPassed());
//  singer4.drawCir();

  //  float imgX = random(-5, 5);
  //  float imgY = random(-5, 5);
}

void runSquigleClass() {

  sq1.calcShape(PART1.getDuration());
  sq1.edgeCheck();
  sq1.drawShape();

//  sq2.calcShape(PART2.getDuration());
//  sq2.drawShape();
//  sq2.edgeCheck();

//  sq3.calcShape(s3.getDuration());
//  sq3.drawShape();
//  sq3.edgeCheck();
//
//  sq4.calcShape(s4.getDuration());
//  sq4.drawShape();
//  sq4.edgeCheck();
}

