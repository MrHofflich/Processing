// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A random walker object!

class Pato {
  float x, y;
  float xSpeed;
  float numFrames = 3;  
  PImage[] images = new PImage[int(numFrames)];
  float currentFrame = 0;
  float numFrames2 =4;
  float numFrames3 =2;
  float numFrames6 = 3;
  PImage[] images2 = new PImage[int(numFrames2)];
  PImage[] images3 = new PImage[int(numFrames3)];
  PImage[] images6 = new PImage[int(numFrames6)];
  float currentFrame2 = 0;
  PImage bala;
  int tamanoPato;
  Pato() {
    x = width/2;
    y = height/2;
   xSpeed = 15;  
   tamanoPato=90;

  images[0] = loadImage("PT_anim0009.png");
  images[1] = loadImage("PT_anim0010.png");
  images[2] = loadImage("PT_anim0011.png");
  images2[0] = loadImage("PT_anim0012.png");
  images2[1] = loadImage("PT_anim0013.png");
  images2[2] = loadImage("PT_anim0014.png");
  images2[3] = loadImage("PT_anim0015.png");
  images3[0] = loadImage("PT_anim0016.png");
  images3[1] = loadImage("PT_anim0017.png");
  images6[0] = loadImage("PT_anim0020.png");
  images6[1] = loadImage("PT_anim0021.png");
  images6[2] = loadImage("PT_anim0022.png");
// images6[3] = loadImage("PT_anim0023.png");
   bala = loadImage("PT_anim0008.png");
  
    for (int i = 0; i < images.length; i++) {
    images[i].resize(tamanoPato, 0);
  }
      for (int i = 0; i < images2.length; i++) {
    images2[i].resize(60, 0);
  }
      for (int i = 0; i < images3.length; i++) {
    images3[i].resize(90, 0);
  }
        for (int i = 0; i < images6.length; i++) {
    images6[i].resize(90, 0);
  }
  }

  void render() {
    graznar.loop(100);
    graznar.play();
    if(xSpeed>0){
    currentFrame = (currentFrame+0.4) % numFrames;  // Use % to cycle through frames
    int offset = 0;
    image(images[int((currentFrame+offset) % numFrames)], x, y );
    offset+=0.000005;
    }
    
    if(xSpeed<0) {
      currentFrame = (currentFrame+0.4) % numFrames3;  // Use % to cycle through frames
      int offset = 0;
      image(images3[int((currentFrame+offset) % numFrames3)], x, y );
      offset+=0.000005;
      
    }
  }

  // Randomly move up, down, left, right, or stay in one place
  void step() {

    float r = random(0, 1);
    // A 40% of moving to the right!
    if (r > 0.80) {    
      y= y-10;
  
    } else if (r < 0.20) {
      y=y+10;

    } 
    x+=xSpeed;
    if (x >= width -100) {
      xSpeed *= -1;
    }

    if (x<= 60) {
      xSpeed *= -1;
      
    }
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height/4);
  }
  
  void dead(){
   graznar.rewind();
   xSpeed=0;
   y = y +10;
   currentFrame2 = (currentFrame2+0.4) % numFrames2;
   int offset = 0;
    image(images2[int((currentFrame2+offset) % numFrames2)], x, y );
    offset+=0.000005;
  }
  
    void escapar(){
   y = y -10;
   currentFrame = (currentFrame+0.4) % numFrames6;
   int offset = 0;
    image(images6[int((currentFrame+offset) % numFrames6)], x, y );
    offset+=0.000005;
  }
}