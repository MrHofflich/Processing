class marcador {
  
  double latitud;
  double longitud;
  ScreenPosition posloc;
  PImage marker = loadImage("arduino_marker.png");
  String texto;
  String usuario;
  
  marcador (double lat,double lon,String usuario_, String texto_) {
    
    latitud  = lat;
    longitud = lon;
    usuario  = usuario_; 
    texto    = texto_;
    
  }
  
  void update() {
    
    loc = new de.fhpotsdam.unfolding.geo.Location(latitud, longitud);
    
    if(loc != null) {
      posloc = mapa.getScreenPosition(loc);
      fill(0);
      noStroke();
      image(marker,posloc.x-(53/2), posloc.y-38, 38, 53);
    }
  
  }
  
  void letras() {
    int boxHeight = texto.length()/13;
    boxHeight*= 20;
    strokeWeight(2);
    stroke(71,170,164);
    fill(255);
    rect(posloc.x-10,posloc.y+5,120,boxHeight+20,20);
    fill(255,0,0);
    textFont(montserratBold);
    text("@"+usuario,posloc.x, posloc.y +15,100,boxHeight);
    fill(0);
    textFont(montserratRegular);
    text(texto,posloc.x, posloc.y +30,100,boxHeight);
  }
  

}
