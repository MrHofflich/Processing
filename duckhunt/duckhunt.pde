import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.serial.*;


Minim minim;
AudioPlayer introAudio;
AudioPlayer inicioRonda;
AudioPlayer ladrido;
AudioPlayer disparo;
AudioPlayer graznar;
Pato p;


PImage perrocaminando;
PImage intro;
PImage zacate;
PImage tierra;
PImage arbol;
PFont fuente;
int tamano = 40;
boolean estadoIntro = true;
boolean seleccionar = false;
int tiempotranscurrido =0;
boolean juego = false;
float xSelector;
float  ySelector;
int r = 30;
boolean jugador =false;
boolean jugadores = false;
int x= 0;
int y = 0;
float numFrames = 4;
float numFrames5 = 2;// The number of frames in the animation
float currentFrame = 0;
PImage[] images = new PImage[int(numFrames)];
PImage images2;
PImage images3;
PImage images4;
PImage[] images5= new PImage[int(numFrames5)];;
int tamanoPerro=230;
int contadorPatos;
boolean perrocamina = false;
boolean perroalerta = false;
boolean perrosaltando = false;
boolean perrosaltando1 = false;
boolean perrosaltando2 = false;
boolean perroladra = false;
boolean introRonda = false;
boolean gameplay = false;
boolean vivo = false;
boolean muerto = false;
boolean escape = false;
int contadorRonda=0;
int contadorTiros = 0;
float xCuadroRonda;
float yCuadroRonda;
float anchoCuadroRonda;
float altoCuadroRonda;
float xShooter;
float yShooter;
float rShooter=30;
float xScore;
float yScore;
float anchoScore;
float altoScore;
float xContadorBalas, yContadorBalas, anchoContadorBalas, altoContadorBalas;
float xContadorPatos, yContadorPatos, anchoContadorPatos, altoContadorPatos;
float distancia;
float roll  = 0.0F;
float pitch = 0.0F;
float yaw   = 0.0F;
float x1,y1,xSpeed,ySpeed;
float inclinacion;
float R,G,B,A;
float musculo;

// Serial port state.
Serial       port;
String       buffer = "";
boolean      printSerial = false;

void setup() {
  
  size(1200, 800);
  frameRate(60);

  intro = loadImage("duckhunt.jpg");
  zacate = loadImage("image10-3.png");
  tierra = loadImage("tierra.png");
  arbol = loadImage("arbol.png");  
  images3 = loadImage("PT_anim0006.png");
  images4 = loadImage("PT_anim0007.png");
  images[0] = loadImage("PT_anim0000.png");
  images[1] = loadImage("PT_anim0001.png");
  images[2] = loadImage("PT_anim0003.png");
  images[3] = loadImage("PT_anim0004.png");
  images2 = loadImage("PT_anim0005.png");
  fuente = loadFont("8BITWONDERNominal-48.vlw");
  perrocaminando = loadImage("perrocaminando0.gif");
  images5[0] = loadImage("PT_anim0018.png");
  images5[1] = loadImage("PT_anim0019.png");
  minim = new Minim(this);
  
  introAudio = minim.loadFile("17-start-game.mp3");
  inicioRonda = minim.loadFile("18-start-round.mp3");
  disparo = minim.loadFile("02-blast.mp3");
  ladrido = minim.loadFile("01-bark.mp3");
  graznar = minim.loadFile("04-duck.mp3");
  
  p = new Pato();
  for (int i = 0; i < images.length; i++) {
    images[i].resize(230, 0);
  }
  
    for (int i = 0; i < images5.length; i++) {
    images5[i].resize(230, 0);
  }
  textFont(fuente, tamano);
  //introAudio.play();
  images2.resize(230, 0);
  
  String[] availablePorts = Serial.list();
  
  if (availablePorts == null) {
    println("ERROR: No hay puertos seriales!");
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
  }catch (RuntimeException ex) {
    // Swallow error if port can't be opened, keep port closed.
    port = null; 
  }
}

void draw() {
  tiempotranscurrido = millis();
  if (tiempotranscurrido > introAudio.length()) {
    seleccionar = true;
  }
  background(0);
  introScreen();
  juegoScreen();
  

}

boolean introScreen() {

  if (estadoIntro) {
    image(intro, 80, 0, width-80, height/2);
    textSize(tamano);
    if (seleccionar) {
      fill(255);
      text("Juego A - 1 jugador", width/2-width/3.5, height/2 + height/6);
      text("Juego B - 2 jugadores", width/2-width/3.5, height/2 + height/6+ tamano*1.5);
      fill(255);
      textSize(15);
      ellipse(xSelector, ySelector, r, r);
      text("Copy Left , Mr. Hofflich  D'Sun Labs ", width/2-width/6, height-tamano);
    }
  }
  return true;
}

boolean juegoScreen() {
  if (juego) {
    y = height/2+height/4;
    //inicioRonda.play();

    if (introRonda) {
      strokeJoin(ROUND);
      xCuadroRonda = width/2;
      yCuadroRonda = height/4;
      anchoCuadroRonda = 300;
      altoCuadroRonda = 150;
      noStroke();
      fill(60, 188, 252);
      rect(0, 0, width, height/6*5-100);
      arbol.resize(270, 0);
      image(arbol, 40, height/5.5);
      image(tierra, 0, height-height/6);
      image(zacate, 0, height/6*3, width, height/6*3.5-100);
      fill(0);
      strokeWeight(6);
      stroke(0, 255, 0);
      rect(xCuadroRonda, yCuadroRonda, anchoCuadroRonda, altoCuadroRonda,10);
      textSize(30);
      fill(255);
      strokeWeight(1);
      text("RONDA", (xCuadroRonda+anchoCuadroRonda/4), yCuadroRonda+altoCuadroRonda/4, anchoCuadroRonda, altoCuadroRonda);
      text(str(contadorRonda), (xCuadroRonda+anchoCuadroRonda/2), yCuadroRonda+altoCuadroRonda/1.5, anchoCuadroRonda, altoCuadroRonda);

      if (perrocamina) {
        currentFrame = (currentFrame+0.4) % numFrames;  // Use % to cycle through frames
        int offset = 0;
        image(images[int((currentFrame+offset) % numFrames)], x, y );
        x=x+3;
        offset+=0.000005;
      }

      if (x >= width/2-width/6) {
        x= width/2-width/6;
        perrocamina = false;
        perroalerta = true;
      }

      if (perroalerta) {
        image(images2, x, y);
        y = y- 1;
        x = x -1;
        perroalerta = false;
        perroladra = true;
        if (perroladra) {
         // ladrido.loop(3);
        }
      }

      if ( y< height/2+height/4) {
        perroalerta = false;
        perrosaltando = true;
        perrosaltando1 = true;
      }

      if (perrosaltando) {

        if (perrosaltando1) {
          perroalerta = false;
          y = height/2+height/5;
          tamanoPerro = tamanoPerro -5;
          images3.resize(tamanoPerro, 0);
          image(images3, x, y);
          if (tamanoPerro <= 150) {
            perrosaltando1 = false;
            perrosaltando2 = true;
          }
        }
        if (perrosaltando2) {
          tamanoPerro = tamanoPerro -5;
          images4.resize(tamanoPerro, 0);
          image(images4, x, y);
          if (tamanoPerro<=8) {
            tamanoPerro = 1;  
            perroalerta = false;
            perrosaltando = false;
            perrosaltando1 = false;
            perrosaltando2 = false;
            introRonda = false;
            perroladra = false;
            gameplay = true;
            vivo = true;
          }
        }
      }
    }
    if(gameplay){
    noStroke();
    fill(60, 188, 252);
    rect(0, 0, width, height/6*5-100);
    xShooter = mouseX ;
    yShooter = mouseY ;
    fill(255,100);
    ellipse(xShooter,yShooter,rShooter,rShooter);
    anchoContadorBalas = 100;
    altoContadorBalas = 70;
    altoContadorPatos = 70;
    xContadorBalas = 50;
    anchoScore = anchoContadorBalas *1.5;
    altoScore = altoContadorBalas;
    yContadorBalas = height - altoContadorBalas;
    xContadorPatos = xContadorBalas*2 + anchoContadorBalas;
    yContadorPatos = height - altoContadorPatos;
    anchoContadorPatos = anchoContadorBalas*6; 
    xScore = xContadorPatos + anchoContadorPatos + 100;
    distancia = dist(xShooter,yShooter,p.x,p.y);
  /*strokeWeight(1);
  stroke(255);
  fill(R,G,B,100);
  ellipse(x + xSpeed, y1 + ySpeed,50,50);
  if(roll > 5 && roll < 35) {
      xSpeed = xSpeed -10;
    }else if(roll > 36 && roll < 50){
      xSpeed = xSpeed -10;
    }else if(roll > 50){
      xSpeed = xSpeed -10;
    }
  
  if(roll < -10 && roll > -35) {
  xSpeed = xSpeed +10;
  }else if(roll > -36 && roll < -50){
   xSpeed = xSpeed +10;
  }else if(roll < -50 ){
   xSpeed = xSpeed +10;
  }
  
    if(pitch > 5 && pitch < 35) {
  ySpeed = ySpeed -10;
  }else if(pitch > 36 && pitch < 50){
   ySpeed = ySpeed -10;
  }else if(pitch > 50){
   ySpeed = ySpeed -10;
  }
  
  if(pitch < -10 && pitch > -35) {
  ySpeed = ySpeed +10;
  }else if(pitch > -36 && pitch < -50){
   ySpeed = ySpeed +10;
  }else if(pitch< -50 ){
   ySpeed = ySpeed +10;
  }
      if(musculo >500){
        //disparo.play();
      if(distancia <= p.images[0].width){
        vivo=false;
        muerto = true;
        println( "Muerto");
        contadorPatos = contadorPatos +100;
      }
    }*/
  
  
     if(vivo){
     graznar.loop(4);
     p.step();
     p.render();
     }
     if(muerto){
     p.dead();
     
     }
     if(escape){
      p.escapar(); 
     }

     if(p.y >height/6*5){
       p.xSpeed = 15;
       muerto = false;
       vivo = true;
       println("Vivo");
     }
     
    arbol.resize(270, 0);
    image(arbol, 40, height/5.5);
    image(tierra, 0, height-height/6);
    image(zacate, 0, height/6*3, width, height/6*3.5-100);
    fill(0);
    strokeWeight(5);
    stroke(0,255,0);
    rect(xContadorBalas,yContadorBalas-altoContadorBalas/2,anchoContadorBalas,altoContadorBalas,10);
    rect(xContadorPatos, yContadorPatos-altoContadorPatos/2, anchoContadorPatos, altoContadorPatos,10);
    rect(xScore, yContadorBalas-altoContadorBalas/2, anchoScore, altoScore,10);
    fill(255);
    strokeWeight(3);
    text(str(contadorPatos),xScore+anchoScore/4,(yContadorBalas-altoContadorBalas/2) + altoScore/1.5);
    p.bala.resize(30,0);
    image(p.bala,xContadorBalas+10, yContadorBalas - altoContadorBalas/2.5);
    image(p.bala,xContadorBalas+p.bala.width-10+p.bala.width/2, yContadorBalas - altoContadorBalas/2.5);
    image(p.bala,xContadorBalas+(p.bala.width*2)-15+p.bala.width/2, yContadorBalas - altoContadorBalas/2.5);
    }
  }

  return true;
}

void keyPressed() {

  if (key == CODED) {
    if (keyCode == UP) {
      xSelector = width/2-width/3.5 - r*2;
      ySelector = height/2 + height/6 - r;
    } else if (keyCode == DOWN) {
      xSelector = width/2-width/3.5 - r*2;
      ySelector = height/2 + height/6+ tamano*1.5;
    }
  }

  if (ySelector == height/2 + height/6 - r) {
    println("1 jugador");
    if (key == ENTER) {
      estadoIntro = false;
      perrocamina = true;
      introRonda = true;
      jugador = true;
      juego = true;
    }
  } else if (ySelector == height/2 + height/6+ tamano*1.5) {
    println("2Jugadores");
    if (key == ENTER) {
      estadoIntro = false;
      introRonda = true;
      jugadores = true;
      juego = true;
    }
  }  

  if (key == 's') {
    estadoIntro = false;
  }
}

void mousePressed() {
  
     if(mousePressed == true){
      //disparo.play();
      if(distancia <= p.images[0].width){
        vivo=false;
        muerto = true;
        println( "Muerto");
        contadorPatos = contadorPatos +100;
      }
     }

}

void mouseReleased(){
  
  if(gameplay){
    disparo.rewind();
    contadorTiros ++;
    println(contadorTiros);
      if(contadorTiros>= 3){
        escape = true;
        vivo = false;
        muerto = false;
  }
}
}
/*
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
      //println(pitch);
    }
  }
  
  
}*/