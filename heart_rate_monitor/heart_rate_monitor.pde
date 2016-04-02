import processing.serial.*;
Serial myPort;
int xPos = 1;
float oldHeartrateHeight = 0;
float heartrateHeight;
void setup () {
  // set the window size:
  size(1000, 400);
  frameRate(30);

  // List available serial ports.
  println(Serial.list());

  // Setup which serial port to use.
  // This line might change for different computers.
  myPort = new Serial(this, Serial.list()[0], 9600);

  // set inital background:
  background(0);
  for (int i = 0; i < width; i = i+40) {
    strokeWeight(1);
    stroke(0, 200, 0, 150);
    line(i, 0, i, height);
    for (int j = 0; j< height; j= j +40) {
      strokeWeight(1);
      stroke(0, 200, 0, 150);
      line(0, j, width, j);
    }
  }
}
 void draw () {

  strokeWeight(4);
  stroke(255, 0, 0);
  line(xPos - 1, height- oldHeartrateHeight, xPos+1, height - heartrateHeight);
  oldHeartrateHeight = heartrateHeight;
  // at the edge of the screen, go back to the beginning:
  if (xPos >= width) {
    xPos = 0;
    background(0);

  for (int i = 0; i < width; i = i+40) {
    strokeWeight(1);
    stroke(0, 200, 0, 150);
    line(i, 0, i, height);
    for (int j = 0; j< height; j= j +40) {
      strokeWeight(1);
      stroke(0, 200, 0, 150);
      line(0, j, width, j);
    }
  }
  } else {
    // increment the horizontal position:
    xPos++;
  }
}

void serialEvent (Serial myPort) {
  // read the string from the serial port.
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int

    int currentHeartrate = int(inString);
    println(currentHeartrate);
    // draw the Heartrate BPM Graph.
    heartrateHeight = map(currentHeartrate, 1010, 1023, 0, height/2);
  }
}