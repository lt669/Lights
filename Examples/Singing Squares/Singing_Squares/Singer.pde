class Singer {

  int[] pitch = new int[0];
  int[] duration = new int[0];

  //Use ArrayList to continuously add elements
  //  ArrayList<Pitch> pitch = new ArrayList<Pitch>();
  //  ArrayList<Duration> duration = new ArrayList<Duration>(); 
  int singerNo;


  //Constructor
  Singer(int iSingerNo) {
    singerNo = iSingerNo;
  } 

  //Count the number of elements in the CSV file for each singer
  void count() {
    table = loadTable("CSV.csv", "header");
    for (TableRow row : table.rows ()) {
      if (row.getInt("Singer") == singerNo) {
        pitch = append(pitch, row.getInt("Pitch"));
        duration = append(duration, row.getInt("Duration"));

        //        pitch.add(new Pitch(row.getInt("Pitch")));
        //        duration.add(new Duration(row.getInt("Duration")));
      }
    }
  }

  void printResult() {
    for (int i=0; i < table.rows() ; i++) {
      //      Pitch pit = pitch.get(i);
      //      Duration dur = duration.get(i);

      pit = pitch[i];
      dur = duration[i];
      print("\n Singer: " + singerNo + "Pitch: " + pit + "Duration: " + dur);
    }
  }
}

