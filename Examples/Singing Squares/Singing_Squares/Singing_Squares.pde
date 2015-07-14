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
      singer1 = new Cir(canX/2, canY/2, dur, pit);
    } else if (row.getInt("Singer") == 2) {
      dur = row.getInt("Duration");
      pit = row.getInt("Pitch");
      singer2 = new Cir(canX/2, canY/2, dur, pit);
    } else if (row.getInt("Singer") == 3) {
      dur = row.getInt("Duration");
      pit = row.getInt("Pitch");
      singer3 = new Cir(canX/2, canY/2, dur, pit);
    } else if (row.getInt("Singer") == 4) {
      dur = row.getInt("Duration");
      pit = row.getInt("Pitch");
      singer4 = new Cir(canX/2, canY/2, dur, pit);
    }
  }
}

void draw() {
  singer1.drawCir();
  singer2.drawCir();
  singer3.drawCir();
  singer4.drawCir();
}
