//Text file reader
class textFileReader {
  String[] text;
  String file; 
  int [][] singerInfo;
  int[] secondArray = new int[2]; // place to compare seconds values
  int x = 0;
  int z = 0;
  int seconds;
  boolean secondPassed;
  boolean NEXT;
  int retPitch;
  int retDuration;

  int[] maxDurationArray = new int[2];
  int[] minDurationArray = new int[2];
  int[] maxPitchArray = new int [2];
  int[] minPitchArray = new int [2];

  int maxPitch;
  int maxDuration;
  int minPitch;
  int minDuration;

  //Constructor
  textFileReader(String iFile) {
    file = iFile;
  }

  void read() {
    text = loadStrings(file); 
    println("text: ", text.length);
    singerInfo = new int[3][text.length]; //1.Start time 2.Frequency 3.Note duration ms

    for (int i=0; i< (text.length/3); i++) {
      for (int j=0; j<3; j++) {
        singerInfo[j][i] = int(text[x]);
        x++;
      }
    }
  }


  //Measure time passed and send new values from the arrays
  void timer() {
    if (z < text.length - 1) {
      println("Length: ", text.length);
      println("Millis: "+millis()+" Next Millis: " + singerInfo[0][z+1] + " SecondPasses: " + secondPassed);
      //Initialise counters
      //      millis = millis() - last;

      seconds = round(millis()/1000);

      //Move last value down the array
      secondArray[1] = secondArray[0];
      secondArray[0] = seconds;

      //Determine whether a second has passed
      if (secondArray[0] > secondArray[1]) {
        secondPassed = true;
      } else if (secondArray[0] <= secondArray [1]) {
        secondPassed = false;
      }

      if (millis() >= singerInfo[0][z+1]) {
        NEXT = true;
        //last = millis();
        z++; // Increase array address
      } else {
        NEXT = false;
      }
    } else {
      println("END OF FILE");
    }
  }

  void rangeCalc() { //Calculates the maximum & minimum pitch and duration within the text file
    //Max Pitch
    for (int i=0; i<text.length; i++) {
      maxPitchArray[1] = maxPitchArray[0];
      maxPitchArray[0] = singerInfo[1][i];
      if (maxPitchArray[0] > maxPitchArray[1]) {
        maxPitch = maxPitchArray[0];
      }
    }

    //Min Pitch
    for (int i=0; i<text.length; i++) {
      minPitchArray[1] = minPitchArray[0];
      minPitchArray[0] = singerInfo[1][i];
      if (maxPitchArray[0] < maxPitchArray[1]) {
        minPitch = minPitchArray[0];
      }
    }

    //Max Duration
    for (int i=0; i<text.length; i++) {
      maxDurationArray[1] = maxDurationArray[0];
      maxDurationArray[0] = singerInfo[2][i];
      if (maxDurationArray[0] > maxDurationArray[1]) {
        maxDuration = maxDurationArray[0];
      }
    }

    //Min Duration
    for (int i=0; i<text.length; i++) {
      minDurationArray[1] = minDurationArray[0];
      minDurationArray[0] = singerInfo[2][i];
      if (minDurationArray[0] < minDurationArray[1]) {
        minDuration = minDurationArray[0];
      }
    }
  }

  //Returns the current value under 'Pitch' in the CSV file
  int getPitch() {    
    if (NEXT == true) {      
      retPitch = int(map(singerInfo[1][z], minPitch, maxPitch, 0, 12));
    }
    return retPitch;
  }

  //Returns the current value under 'Duration' in the CSV file
  int getDuration() {
    if (NEXT == true) {
      retDuration = int(map(singerInfo[2][z], minDuration, maxDuration, 0, 10));
      println("retDuration: "+retDuration+" minDuration: " + minDuration + " maxDuration: "+maxDuration);
    }
    return retDuration;
  }

  boolean getSecondPassed() {
    return secondPassed;
  }

  void printFile(String iPart) {
    String part = iPart;
    for (int i=0; i< (text.length/3); i++) {
      println(" " + part+ " " + singerInfo[0][i] + "  " + singerInfo[1][i] + "  " + singerInfo[2][i]);
    }
    println("x: ", x);
  }
}

