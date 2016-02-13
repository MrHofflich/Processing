class neoPixel {
  
  
 int posicionX,posicionY,ancho,alto,R,G,B;
 
 
 neoPixel ( int posicionX_, int posicionY_,int ancho_,int alto_, int R_, int G_, int B_) {
   
 posicionX = posicionX_;
 posicionY = posicionY_;
 ancho = ancho_;
 alto = alto_;
 R = R_;
 G = G_;
 B = B_;
 
 }
 
 void display(){
  fill(R,G,B);
  rect(posicionX,posicionY,ancho,alto); 
   
 }
 
boolean turnOn(){
   R=255;
   G= 0;
   B=0;
 return true;
 }
   
boolean turnOff(){
   R=255;
   G= 255;
   B=255;
return true;
 }
  
  
  
  
  
}