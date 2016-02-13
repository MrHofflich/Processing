/*
  Etch-A-Sketch
  
  Basado en el código de Etch a Sketch de Manuel Orduño.
  
  Alexander Höfflich
 */
 
 import processing.serial.*;
 
 Serial serialPort;
 PImage frame;
 
 // X and Y limits of the drawing area
 float minWidth = 105;
 float maxWidth = 695;
 float minHeight = 80;
 float maxHeight = 515;

 float pencilX;
 float pencilY;
 float pencilSize = 10;

 int receivedData;
 int xValue;
 int yValue;
 int shaking;
 int[] coordenadas;
 
 void setup() {
   size(800, 600);      // match the size of the image
   background(250, 250, 250);
   
   noStroke();
   fill(0, 128);
   
   frame = loadImage("etch-a-sketch.png");
   image(frame, 0, 0);
   
   println(Serial.list());
   serialPort = new Serial(this, "COM20", 9600);

 }
 
 void draw() {
   
     String estado = serialPort.readStringUntil('\n');
   
   if(estado != null) {
     
   coordenadas = int(split(estado, ","));
   println(coordenadas);
   
   // convert serial values to coordinates in the screen
   pencilX = map(coordenadas[0], 0, 1023, minWidth, maxWidth);
   pencilY = map(coordenadas[1], 0, 1023, maxHeight, minHeight);
 
   
   if(coordenadas[2] >= 2) {          // "erase" using low alpha
     fill(250, 250, 250, 20);
     rect(0, 0, width, height);
   } else if(coordenadas[2] <= 1) {                      // play with low alpha values
     fill(0, 128);               // to simulate stroke weights             
     ellipse(pencilX, pencilY, pencilSize, pencilSize);
   }
   }
 
   image(frame, 0, 0);
 
 }
 
 // press the 's' key to save the current frame
 void keyReleased() {
   if(key == 's' || key == 'S') {
     save("sketch.png");
     println("Image saved.");
   }
 }