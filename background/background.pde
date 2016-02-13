
color[] backstage = {#183E3F, #1A561A, #F48B20, #BF0400, #0A0E0D, #2F787A,#338587,#2E7678,#205249,#41A897};
color[] palette = backstage;
PFont font;

int day = day(); 
String titulo = "PROTESS";
String d;
int mes;
String y;
int year = year();
String[] years= {"Enero","Febrero","Marzo","Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre","Diciembre"};
PShape recuadro;
int s; 
int m;
int h;    // Values from 0 - 23
String segundos;
PShape protess;
PShape fondoGrid;
PShape esquinas;
float angulo;

void setup() {
  //size(1500,900,P3D);
  fullScreen(P3D);
  frameRate(85);
  
  recuadro = loadShape("boton.svg");
  protess = loadShape("myhoand.svg");
  font = loadFont("URWGothicL-Demi-48.vlw");
  fondoGrid = loadShape("fondogrid.svg"); //<>//
  esquinas   = loadShape("menucorners.svg");
  fondoGrid.disableStyle();
  protess.disableStyle();
  esquinas.disableStyle();
  protess.disableStyle();
  recuadro.disableStyle();
  
  textFont(font,80);
   
}

void draw() {
  background(0,100);
  render();
  time();    
}

void render() {
  
  angulo = angulo+ 2;
  
  pushMatrix();
    translate(0,0,0);
    stroke(palette[0],100);
    fill(palette[0]);
    shape(fondoGrid,0,0);
  popMatrix();
  
  pushMatrix();
    translate(0,0,1);
    //Código para dibujar la mano del centro
    noFill();
    stroke(0, 184, 182, 80);
    strokeWeight(11);
    ellipse(this.width/2, this.height/2, this.width/4, this.width/4);
    arc(this.width/2, this.height/2, this.width/4.2, this.width/4.2, radians(angulo), radians(angulo+width/40));
    arc(this.width/2, this.height/2, this.width/3.8, this.width/3.8, radians(-angulo), radians(-angulo+width/40));
    strokeWeight(1);
    stroke(0);
    fill(palette[9],120);
    shapeMode(CENTER);
    shape(protess, this.width/2, this.height/2, this.width/6, this.width/6);
    //Código para dibujar las esquinas
    fill(255);
    textSize(30);
    text(titulo,200,35);
    stroke(palette[0],180);
    fill(palette[0],180);
    shapeMode(CORNER);    
    shape(esquinas,10,0,this.width-15,this.height-10);
  popMatrix();
  //El boton para regresar
  pushMatrix();
    translate(0,0,2);
    strokeWeight(1);
    fill(palette[0]);
    ellipse(70,68,120,120);
    fill(0, 174, 172,120);
    shapeMode(CENTER);
    shape(protess,70,68);
  popMatrix();
     
}
  
void time(){

  d = String.valueOf(day);
  y = String.valueOf(year);
  mes = month();
  s = second();
  m = minute();
  h = hour();
  
  pushMatrix();
    translate(0,0,1);
    
    textSize(80);
    fill(palette[6]);
    text(d,width-130,height/12);
    
    stroke(palette[2]);
    fill(palette[2]);
    shapeMode(CORNER);
    shape(recuadro, width-130, height/11,120, 25);
    
    textSize(20);
    fill(0);
    text(years[mes-1], width-121,height/8.9);
    
    fill(255,100);
    textSize(33);
    text(s,width-40,height/6.5);
    text(":",width-50,height/6.5);
    text(m,width-90,height/6.5);
    text(":",width-105,height/6.5);
    text(h,width-140,height/6.5);
    
  popMatrix();

}