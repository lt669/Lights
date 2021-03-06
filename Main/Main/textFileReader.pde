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

  int maxPitch;
  int maxDuration;
  int minPitch = 10000; //Large valuses to compare to
  int minDuration = 10000;

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
      //      println("Length: ", text.length);
      //      println("Millis: "+millis()+" Next Millis: " + singerInfo[0][z+1] + " SecondPasses: " + secondPassed);
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
      if (singerInfo[1][i] > maxPitch) {
        maxPitch = singerInfo[1][i];
      }
      //Min Pitch
      if (singerInfo[1][i] < minPitch) {
        minPitch = singerInfo[1][i];
      }
      //Max Duration
      if (singerInfo[2][i] > maxDuration) {
        maxDuration = singerInfo[2][i];
      }
      //Min Duration
      if (singerInfo[2][i] < minDuration)
       {
        minDuration = singerInfo[2][i];
      }
    }  
//    println("(File) maxPitch: "+ maxPitch + " maxDuration: "+maxDuration);
  }
  
  int getMinPitch() {
    return minPitch;
  }

  int getMaxPitch() {
    return maxPitch;
  }

  int getMinDuration() {
    return minDuration;
  }

  int getMaxDuration() {
    return maxDuration;
  }

  //Returns the current value under 'Pitch' in the CSV file
  int getPitch() {    
    if (NEXT == true) {      
      retPitch = singerInfo[1][z];
    }
    return retPitch;
  }

  //Returns the current value under 'Duration' in the CSV file
  int getDuration() {
    if (NEXT == true) {
      retDuration = singerInfo[2][z];
      //      println("retDuration: "+retDuration+" minDuration: " + minDuration + " maxDuration: "+maxDuration);
    }
    return retDuration;
  }
  
  int getNextStartTime(){
   return singerInfo[0][z+1]; 
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

