import processing.serial.*; //<>//

neoPixel[][] np;
Serial myPort; 
int rows = 8;
int columns = 5;
int ancho = 40;
int alto = 40;
boolean encendido = false;
int i,j;
int R=255;
int G=255;
int B=255;

void setup() {
  size(600,600);
  np = new neoPixel[columns][rows];
  

  printArray(Serial.list());
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
  
  for (int i =0; i< rows; i++) {
    for (int j = 0; j<columns; j++) {
      np[j][i] = new neoPixel(i*ancho,j*alto,ancho,alto,R,G,B);
    }  
  }  
}

void draw() {
  
  background(0);
  for (i =0; i< rows; i++) {
    for (j = 0; j< columns; j++) {
      np[j][i].display(); //<>//
    }         
  }
}
 
void mousePressed() {
  for (i =0; i< rows; i++) {
    for (j = 0; j< columns; j++) {
      if(mouseX >= np[j][i].posicionX && mouseX <= np[j][i].posicionX+np[j][i].ancho && mouseY>=np[j][i].posicionY && mouseY<=np[j][i].posicionY+np[j][i].alto) {
        encendido = !encendido;
        if(encendido){
          np[j][i].turnOn();
          R=255;
          G=0;
          B=0;
          myPort.write(j+","+i+","+R+","+G+","+B+"\n");
          println(j+","+i+","+R+","+G+","+B+"\n");
        }else{
          np[j][i].turnOff();
          R = 0;
          G = 0;
          B = 0;
          myPort.write(j+","+i+","+R+","+G+","+B+"\n");
        }
      }   
    }
  }
}
      