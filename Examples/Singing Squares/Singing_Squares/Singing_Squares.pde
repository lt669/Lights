//import java.util.*; 

Table table;
int canX = 500;
int canY = 500;
int dur;
int pit;

Cir singer1;
Cir singer2;
Cir singer3;
Cir singer4;

void setup() {
  background(-1);
  size(canX, canY);
  //  singer1 = new Cir();
  //  singer2 = new Cir();
  //  singer3 = new Cir();
  //  singer4 = new Cir();

  table = loadTable("CSV.csv", "header");

  for (TableRow row : table.rows ()) {
    if (row.getInt("Singer") == 1) {
      dur = row.getInt("Duration");
      pit = row.getInt("Pitch");
    } else if (row.getInt("Singer") == 2) {
    } else if (row.getInt("Singer") == 3) {
    } else if (row.getInt("Singer") == 4) {
    }
  }

  singer1 = new Cir(canX/2, canY/2, dur, pit);
}

void draw() {
  float incX =  random(-15, 15);
  float incY =  random(-15, 15);

  singer1.drawCir(incX, incY);
}

class Cir {

  int posX;
  int posY;
  int size;
  int bright;
  //  float incX;
  //  float incY;

  //Constructor
  Cir(int iPosX, int iPosY, int iSize, int iBright) {
    posX = iPosX;
    posY = iPosY;
    size = iSize;
    bright = iBright;
  }

  void drawCir(float incX, float incY) {
    //Random movement variables


    //Update position
    posX += incX;
    posY += incY;

    //Draw ellipse
    bright = 255/bright;
    fill(bright, bright, bright );
    ellipse(posX, posY, size, size);
  }
}

