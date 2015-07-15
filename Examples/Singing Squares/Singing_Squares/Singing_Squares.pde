Table table;
int canX = 500;
int canY = 500;
int dur = 0;
int pit = 0;

Cir singer1;
Cir singer2;
Cir singer3;
Cir singer4;

Singer s1;
Singer s2;
Singer s3;
Singer s4;

void setup() {

  //Setup screen
  background(-1);
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



  //Print results
  s1.printResult();
  //  s2.printResult();
  //  s3.printResult(); 
  //  s4.printResult();

  singer1 = new Cir(canX/2, canY/2, 0, 0);
  singer2 = new Cir(canX/2, canY/2, 0, 0);
  noLoop();
}

void draw() {

  //  if(s1.finish() == true){
  //   print("DONE"); 
  //  }
  //  else{



  if (singer1.getNext() == true) {
    singer1.setBright(s1.getPitch());
    singer1.setSize(s1.getDuration());
  }
  singer1.drawCir();
  
  //  singer2.drawCir();
  //  
  //  if (singer2.getNext() == true) {
  //    singer2.setSize(s2.getDuration());
  //    singer2.setBright(s2.getPitch());
  //    print("\n Pitch: " + s2.getPitch() + " Duration: " + s2.getDuration());
  //  }


  //  singer3.drawCir();
  //  singer4.drawCir();
  //}
}

void keyPressed() {
  if (key == 'w') {
    redraw();
  }
}

