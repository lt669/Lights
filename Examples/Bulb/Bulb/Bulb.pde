PImage img;
int x = 300;
int y = 200;
void setup() {
  size(900, 600);

  imageMode(CENTER);
  img = loadImage("/Users/Lewis/Developer/Lights_Project/Lights/Examples/Bulb/Bulb/Bulb_cut.png");
  //Dimensions 2448 x 3264
}

void draw() {
  float i = 0.2;

  smooth();
  noStroke();
  fill(255, 0, 0);
  ellipse(x, y, 95, 95);
  filter( BLUR, 6 );
  stroke(0);
  fill(255, 255, 0);
  ellipse(x, y, 90, 90);

  image(img, x, y, 2448*i, 3264*i);
}

