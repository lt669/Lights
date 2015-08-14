int[] part1Split;
float [][] part1;
int x=0;
void setup() {
  String[] text = loadStrings("Part1.txt");
  println(text.length);

  //  part1Split = int(split(text, ' '));

  part1 = new float[3][text.length];

  for (int i=0; i< (text.length/3); i++) {
    for (int j=0; j<3; j++) {
      part1[j][i] = int(text[x]);
      x++;
    }
     println("Part1: "+ part1[0][i] + "  " + part1[1][i] + "  " + part1[2][i]);
  }
}


void draw() {
}

