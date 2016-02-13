color[] backstage = {#A23645,#AA6639,#479030,#246D5F, #6E383F};
color[] palette = backstage;
PFont font;

void setup() {
  size(851, 315);
  noStroke();
  noLoop();
  background(palette[0]);
  drawCircle(width/2, 280, 6);
  font = loadFont("URWChanceryL-MediItal-48.vlw");
fill(255);
textFont(font,25);
text("Höfflich",750,300);
}

void draw() {

}

void drawCircle(int x, int radius, int level) {
  fill(palette[int(random(0,5))],100);
  ellipse(x, height/2, radius*2.5, radius*2.5);      
  if(level > 1) {
    level = level - 1;
    drawCircle(x - radius/2, radius/2, level);
    drawCircle(x + radius/2, radius/2, level);
  }
}

void keyPressed(){
  
 save("facebookcover3.png");
 
}