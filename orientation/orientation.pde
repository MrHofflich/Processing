import processing.serial.*;

float roll  = 0.0F;
float pitch = 0.0F;
float yaw   = 0.0F;
float x,y,xSpeed,ySpeed;
// Serial port state.
Serial       port;
String       buffer = "";

boolean      printSerial = false;


void setup() {
  
  size(600,600);
  
  String[] availablePorts = Serial.list();
  if (availablePorts == null) {
    println("ERROR: No serial ports available!");
    exit();
  }
  
    if (port != null) {
    port.stop();
  }
  try {
    // Open port.
    port = new Serial(this, "COM5", 115200);
    port.bufferUntil('\n');
    // Persist port in configuration.

  }
  catch (RuntimeException ex) {
    // Swallow error if port can't be opened, keep port closed.
    port = null; 
  }
  
  x = width/2;
  y = height/2;
  
}


void draw()
{
  background(255);
  fill(0);
  ellipse( x + xSpeed, y + ySpeed, 30,30);
  
  if(roll > 5 && roll < 35) {
  xSpeed = xSpeed +1;
  }else if(roll > 36 && roll < 50){
   xSpeed = xSpeed +1;
  }else if(roll > 50){
   xSpeed = xSpeed +1;
  }
  
  if(roll < -10 && roll > -35) {
  xSpeed = xSpeed -1;
  }else if(roll > -36 && roll < -50){
   xSpeed = xSpeed -1;
  }else if(roll < -50 ){
   xSpeed = xSpeed -1;
  }
  
    if(pitch > 5 && pitch < 35) {
  ySpeed = ySpeed +1;
  }else if(pitch > 36 && pitch < 50){
   ySpeed = ySpeed +1;
  }else if(pitch > 50){
   ySpeed = ySpeed +1;
  }
  
  if(pitch < -10 && pitch > -35) {
  ySpeed = ySpeed -1;
  }else if(pitch > -36 && pitch < -50){
   ySpeed = ySpeed -1;
  }else if(pitch< -50 ){
   ySpeed = ySpeed -1;
  }
  
  if(x < 0 || x> width-30){
    x = width-30;
  }
  if (y < 0 || y> height-30) {
     y = height-30;
  }
}


void serialEvent(Serial p) 
{
  String incoming = p.readString();
  if (printSerial) {
    println(incoming);
  }
  
    if ((incoming.length() > 8))
  {
    String[] list = split(incoming, " ");
    if ( (list.length > 0) && (list[0].equals("Orientation:")) ) 
    {
      roll  = float(list[1]);
      pitch = float(list[2]);
      yaw   = float(list[3]);
      buffer = incoming;
      println(pitch);
    }
  }
  
  
}