//Text file reader
class textFileReader {
  String[] text;
  String file; 
  float [][] singerInfo;
  int x = 0;

  //Constructor
  textFileReader(String iFile) {
    file = iFile;
  }

  void read() {
    text = loadStrings(file); 
    println("text: ",text.length);
    singerInfo = new float[3][text.length];

    for (int i=0; i< (text.length/3); i++) {
      for (int j=0; j<3; j++) {
        singerInfo[j][i] = int(text[x]);
        x++;
      }
    }
  }

  void printFile(String iPart) {
    String part = iPart;
    for (int i=0; i< (text.length/3); i++) {
      println(" " + part+ " " + singerInfo[0][i] + "  " + singerInfo[1][i] + "  " + singerInfo[2][i]);
    }
    println("x: ",x);
  }
}

