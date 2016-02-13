/*
Aplicacion para trackear hashtags en base a su geolocalizacion. 
Herramientas utilizadas:
Twitter4j
Googlemaps API
Unfolding Library
OOP

Alexander Höfflich Enero/Febrero 2015
Hermosillo,Sonora.
D'Sun Labs
www.dsunlabs.com
www.dsunshop.com

 */

//Importando lasl ibrerias necesarias, la libreria de twitter se importo agreando el corefile a la carpta del sketch
import java.net.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.*;

// Se crean los objetos necesarios y se declaran las variable globales a utilizar
ArrayList<marcador>                 marca   = new ArrayList<marcador>();
de.fhpotsdam.unfolding.geo.Location loc;
UnfoldingMap                        mapa;
String                              usuario,text,location;
double                              latitude,longitude;
String                              hashtag = "#Makersguaymas";
boolean                             geoEnabled;

// Informacion de acceso de Twitter
static String OAuthConsumerKey    = "Tuconsumerkey";
static String OAuthConsumerSecret = "TuConsumersecret";
static String AccessToken         = "Tuaccesstoken";
static String AccessTokenSecret   = "TuaccessTokenSecret";

// Informacion de acceso a google
       String accesoGoogle        = "TuApikeydeGoogle"; //Dsun Labs API KEY
       String accesoGoogle2       = "TuotroapikeydeGoogle"; //Montiel.m API KEY
       int    contadorToken1,contadorToken2;
       

// Se guardan los hashtas a buscar, para poder filtrar la busqueda, de lo contrario arrojara tweets al azar
String keywords[] = {
 hashtag
};

PFont montserratRegular;
PFont montserratBold;
PImage mapaFondo;

float screenPos;

void setup() {
  
  size(1920, 1080, P2D);
  //noCursor(); //Ocultar el cursor del mouse
  
  montserratRegular = loadFont("Montserrat-Regular-12.vlw");
  montserratBold = loadFont("Montserrat-Bold-12.vlw");
  mapaFondo = loadImage("final 6.png");
  
  //////// SE CREA MAPA ///////
  mapa = new UnfoldingMap(this, new AcetateProvider.Basemap());
  MapUtils.createDefaultEventDispatcher(this, mapa);
  /////////////////////////////
  
  ///////// Se conecta a twitter y se crea el "escucha"/////////////
  TwitterStream twitter = new TwitterStreamFactory().getInstance();
  connectTwitter(twitter);
  twitter.addListener(listener);
  //////////////////////////////////////////////////////////////////
  
  //Se revisa si existe algun filtro para nuestra busqueda de tweets 
  if (keywords.length == 0) {
    twitter.sample();
  } else {
    twitter.filter(new FilterQuery().track(keywords));
  }
  
}

void draw() {
  screenPos = map(mouseY, 0, 1080, 0, 1920);
  screenPos = constrain(screenPos, 320, 1600);
  
  image(mapaFondo,0,0); //Se dibuja el fondo
  mapa.draw(); // Se dibuja el map
  

  // En esta parte vamos a dibujar los marcadores con las coordenadas que hayamos obtenido
  for (int i=0 ; i < marca.size(); i++) {
    // Se obtienen todos los objetos dentro de nuestro arreglo
    marcador marc = marca.get(i); 
    marc.update(); //Aqui se dibujan
    
      if(screenPos >= marc.posloc.x-10 && screenPos <= marc.posloc.x+10) { //Si el mouse pasa por encima de un marcador, despliega el usuario y el tweet
      marc.letras(); 
    }
    
  }
  
  //if(screenPos >= 320 && screenPos <= 1600) {
    stroke(222,59,9);
    strokeWeight(2);  
    line(screenPos,0,screenPos,height); // Se dibuja el apuntador
  //}
}


// Aqui empezaremos a escuchar a twitter
StatusListener listener = new StatusListener() {
  
  public void onStatus(Status status) {
    
    usuario      = status.getUser().getScreenName();     //Con esto obtenemos el nombre pantalla del usuario
    location     = trim(status.getUser().getLocation()); //Obtenemos la localidad o ciudad (la funion trim nos va a quitar en caso de haberlo un espacio al inicio y al final
    text         = status.getText();    //Con esto obtenemos el tweet en si, el puro texto
    geoEnabled   = status.getUser().isGeoEnabled();      //Con esto revisamos si el tweet tiene activada la geolocalizacion
    latitude     = 0.0;
    longitude    = 0.0;

    if (geoEnabled) {
      GeoLocation geo = status.getGeoLocation();
      if (geo != null) {
        latitude  = geo.getLatitude();
        longitude = geo.getLongitude();

        //println("Total de tweets validos de Twitter: " + marcadorDeTwitter); 
      }
    }  
    
    
    if ((longitude == 0.0 || latitude == 0.0) && !location.isEmpty()) {
         
      if (contadorToken1 >= 0 && contadorToken1 <= 10) {
        //println("Geo no encontrado usando ubicacion: " + location);
        contadorToken1++;
        try {
          URI uri = new URI(
            "https", 
            "maps.googleapis.com", 
            "/maps/api/geocode/json",
            "address=" + location + accesoGoogle,
            null
          );
          
          processing.data.JSONObject oJason    = loadJSONObject(uri.toASCIIString());
          processing.data.JSONArray aData      = oJason.getJSONArray("results");
          processing.data.JSONObject oElement  = aData.getJSONObject(0);
          processing.data.JSONObject oGeo      = oElement.getJSONObject("geometry");
          processing.data.JSONObject oLocation = oGeo.getJSONObject("location");
          longitude = (double) oLocation.getFloat("lng");
          latitude  = (double) oLocation.getFloat("lat");

          //println("Sacado de google");
         ///println("Total de tweets validos de google: " + marcadorDeGoogle);
          
          if(latitude == 0.0 || longitude == 0.0 || oElement ==null ) {

           // println("Total de tweets fallidos: " + tweetsFallidos);
          }
          
        } catch (Exception e) {
          //println("Error general" +e );
        }
        delay(1000);
        println("Usando Access Token D'Sun Labs",contadorToken1);
      }
      
            if (contadorToken2 >= 0 && contadorToken1 >10) {
        //println("Geo no encontrado usando ubicacion: " + location);
        contadorToken2++;
        try {
          URI uri = new URI(
            "https", 
            "maps.googleapis.com", 
            "/maps/api/geocode/json",
            "address=" + location + accesoGoogle2,
            null
          );
          
          processing.data.JSONObject oJason    = loadJSONObject(uri.toASCIIString());
          processing.data.JSONArray aData      = oJason.getJSONArray("results");
          processing.data.JSONObject oElement  = aData.getJSONObject(0);
          processing.data.JSONObject oGeo      = oElement.getJSONObject("geometry");
          processing.data.JSONObject oLocation = oGeo.getJSONObject("location");
          longitude = (double) oLocation.getFloat("lng");
          latitude  = (double) oLocation.getFloat("lat");

          //println("Sacado de google");
         ///println("Total de tweets validos de google: " + marcadorDeGoogle);
          
          if(latitude == 0.0 || longitude == 0.0 || oElement ==null ) {

           // println("Total de tweets fallidos: " + tweetsFallidos);
          }
          
        } catch (Exception e) {
          //println("Error general" +e );
        }
        delay(1000);
        println("Usando Acces Token de Alex",contadorToken2);
      }
      //println(counter);
 
    }
    
    if (longitude != 0.0 && latitude != 0.0) {
      
      if( marca.size() <= 5) {
        marca.add(new marcador(latitude,longitude,usuario,text));
       //println("Latitude: " + latitude + " Longitude: " + longitude);
       }
       
      if(marca.size() >= 6) {
        marca.remove(0);
         println("removed 0");
        
      }
    }
    
  }

  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
      System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
  }
  
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
      System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
  }
  
  public void onScrubGeo(long userId, long upToStatusId) {
    System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }

  public void onException(Exception ex) {
    ex.printStackTrace();
  }
  
};



// Initial connection
void connectTwitter(TwitterStream twitter) {
  twitter.setOAuthConsumer(OAuthConsumerKey, OAuthConsumerSecret);
  AccessToken accessToken = loadAccessToken();
  twitter.setOAuthAccessToken(accessToken);
}

// Loading up the access token
private static AccessToken loadAccessToken() {
  return new AccessToken(AccessToken, AccessTokenSecret);
}

void mouseReleased() {
  //save("foto.png");
  println(mouseY);
}