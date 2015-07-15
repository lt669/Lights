class Singer {

  //Initialise Arrays to store elements for each singer
  int[] pitch = new int[0];
  int[] duration = new int[0];
  int singerNo;
  int z = -1;

  //Load CSV file
  Table table = loadTable("CSV.csv", "header");
  TableRow row;
  int rowNo = table.getRowCount();

  //Constructor
  Singer(int iSingerNo) {
    singerNo = iSingerNo;
  } 

  //Count the number of elements in the CSV file for each singer
  void count() {
    for (TableRow row : table.rows ()) {
      if (row.getInt("Singer") == singerNo) {
        pitch = append(pitch, row.getInt("Pitch"));
        duration = append(duration, row.getInt("Duration"));
      }
    }
  }

  void printResult() {
    for (int i=0; i < rowNo/4; i++) {
      pit = pitch[i];
      dur = duration[i];
      print("\n Singer:" + singerNo + " Pitch:" + pit + " Duration:" + dur);
    }
  }
  
  int getPitch(){
    z++;
    return pitch[z];
  }
}

