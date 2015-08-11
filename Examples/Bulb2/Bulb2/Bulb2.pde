int canX = 900;
int canY = 600;
boolean glow;

bulbClass bulb1;
bulbClass bulb2;

void setup(){
  size(canX,canY);
  bulb1 = new bulbClass(canX/4, 0);
  bulb2 = new bulbClass(canX*3/4, canY/2);
}

void draw(){

  background(-1);
  bulb1.swing();
  bulb1.glow();
 // bulb2.swing();

}

void mousePressed(){
  glow = true;
}

void mouseReleased(){
  glow = false;
}
