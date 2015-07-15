Table table;
int canX = 500;
int canY = 500;
int dur;
int pit;

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

  //Load CSV file


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
  s2.printResult();
  s3.printResult(); 
  s4.printResult();

  singer1 = new Cir(canX/2, canY/2, dur, pit);
}

void draw() {
   singer1.drawCir();
   
   if(singer1.getNext() == true){
    s1.getPitch(); 
    s1.getDuration();
   }
   
  //  singer2.drawCir();
  //  singer3.drawCir();
  //  singer4.drawCir();
}



