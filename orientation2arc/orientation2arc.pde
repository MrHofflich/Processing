import processing.serial.*;

float roll  = 0.0F;
float pitch = 0.0F;
float yaw   = 0.0F;
float x,y,xSpeed,ySpeed;
float inclinacion;
float R,G,B,A;
float musculo;
// Serial port state.
Serial       port;
String       buffer = "";
PShape brazo;

boolean      printSerial = false;


void setup() {
  
  size(600,600,P3D);
  smooth();
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
  
  x = 0;
  y = 0;
  R = 150;
  G = 150;
  B = 150;
  A = 50;
  brazo = loadShape("hand-and-arm.svg");
}


void draw()
{
  background(255);
  fill(0);
  textSize(20);
  text("Detectar en que punto el músculo empieza a esforzarse", 30,30);
  float grados = map (inclinacion, 270,90,0,180);
  text("Inclinacion: " +  grados + "°" , 30 , 80);

  pushMatrix();
  float angle = map (pitch, -85,80,3*PI/2,PI/2);
  translate(width/2,height/2);
  rotateZ(-angle);
  inclinacion = degrees(angle);

  

  strokeWeight(3);
  fill(0);
  line(x,y, x + 200, y);
  rect(x,y, x+200,50);
  //shape(brazo,x,y-700);
  fill(R,G,B,A);
  arc(x, y , 200, -200,0,3*PI/2 - radians(inclinacion));
  
  if(musculo < 120){
      R = 50;
      G = 255;
      B = 50;
  }
  if(musculo > 120 && musculo < 290){
      R = 150;
      G = 200;
      B = 50;
  }
  if(musculo > 290 && musculo < 450){
      R = 200;
      G = 120;
      B = 50;
  }
  if(musculo > 450){
      R = 255;
      G = 0;
      B = 0;
  }
  /*
  if(R <=150) {
    R=150;
  }
  if(G <= 150) {
    G = 150;
  }
  
  if (inclinacion >=230 && inclinacion <= 270) {
   G = G + 3;
   R = R - 3;
   if(B <=150){
     B=B+3;
   } else if(B>=150){
     B=B-3;
   }
  }
  if (inclinacion >= 180 && inclinacion <= 229){
   G = G+3;
   R = R +3;
  }
  if ( inclinacion<= 180 && inclinacion >= 90){
    G = G-3;
    B = B-3;
    A = A+3;
    if(G<=0){
      G = 0;
    }
    if (B <=0){
      B=0;
    }
    if(A >=255){
      A=255;
    }
  }
  */
  popMatrix();

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
      musculo = float(list[4]);
      buffer = incoming;
      println(musculo);
    }
  }
  
  
}