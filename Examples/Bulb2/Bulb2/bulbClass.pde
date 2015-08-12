//bulbClass

class bulbClass {

  int offSet = 25;
  float xMovement;
  float yMovement;
  float xPos;
  float yPos;
  int centerX;
  int centerY;
  float size = 0.05;
  float theta = 0.0;
  int swing = 20;
  float rotation;
  int topX = 10;
  int topY = 75;

  PImage bulb;


  //Physics variables
  float g = -0.001;
  float a;
  float angle = HALF_PI/4;
  float v;
  int armLength;
  int m; //Mass

  float l = 50;
  float w = sqrt(g/l);

  //Constructor
  bulbClass(int iPosX, int iPosY) {
    xPos = iPosX;
    yPos = iPosY;
    centerX = iPosX;
    centerY = iPosY;

    imageMode(CENTER);
//    bulb = loadImage("/Users/Lewis/Developer/Lights_Project/Lights/Examples/Bulb/Bulb/Bulb_cutV2.png");
      dataPath("images/Bulb_cutV2.png");
    bulb = loadImage(dataPath("images/Bulb_cutV2.png"));
    //Dimensions 2448 x 3264
  }

  void swing(int armLength, int m) {
   this.m = m; 
   this.armLength = armLength;     
    
    //Calculate acceleration
    a = (g/m) * sin(angle);

    //Increment Velocity
    v += a;

    //Increment Angle
    angle += v;

    //Calculate Positions
    xPos = armLength * sin(angle) + centerX;
    yPos = armLength * cos(angle) + centerY;

    stroke(0);
    line(centerX, centerY, xPos, yPos);
    
    pushMatrix();
    translate(xPos, yPos);
    rotate(-(angle));
    image(bulb, topX, topY, 2448*size, 3264*size);
    popMatrix();
    println("xPos", xPos);


    // image(bulb, xPos+topX, yPos+topY, 2448*size, 3264*size);

    stroke(0);
    fill(255, 0, 0);
    rect(xPos, yPos, 5, 5);
  }

  void glow() {
    if (glow == true) {
      smooth();
      noStroke();
      fill(255, 50, 0);
      ellipse(xPos+topX, yPos+offSet+topY, 120, 120);
      filter( BLUR, 3 );
    }
    if (glow == false) {
      noStroke();
      rectMode(CORNER);
      fill(255, 255, 255, 5);
      rect(0, 0, canX, canY);
    }
  }
}

