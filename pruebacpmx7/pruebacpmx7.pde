import twitter4j.*;
import twitter4j.api.*;
import twitter4j.auth.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.management.*;
import twitter4j.util.*;
import java.util.*;
import processing.video.*;

Twitter twitter;
File file ;
int numPixels;
int[] previousFrame;
Capture video;
String rutaFotos = "C:/Users/MrHofflich/Desktop";

void setup()
{
  size(640,480);
    
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("");
  cb.setOAuthConsumerSecret("");
  cb.setOAuthAccessToken("");
  cb.setOAuthAccessTokenSecret("");
  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, 640,480);
  // Start capturing the images from the camera
  video.start(); 
  
  numPixels = video.width * video.height;
  // Create an array to store the previously captured frame
  previousFrame = new int[numPixels];
  loadPixels();

}

void draw()
{
 if (video.available()) {
    // When using video to manipulate the screen, use video.available() and
    // video.read() inside the draw() method so that it's safe to draw to the screen
    video.read(); // Read the new frame from the camera
    video.loadPixels(); // Make its pixels[] array available
    
    int movementSum = 0; // Amount of movement in the frame
    for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...
      color currColor = video.pixels[i];
      color prevColor = previousFrame[i];
      // Extract the red, green, and blue components from current pixel
      int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      // Extract red, green, and blue components from previous pixel
      int prevR = (prevColor >> 16) & 0xFF;
      int prevG = (prevColor >> 8) & 0xFF;
      int prevB = prevColor & 0xFF;
      // Compute the difference of the red, green, and blue values
      int diffR = abs(currR - prevR);
      int diffG = abs(currG - prevG);
      int diffB = abs(currB - prevB);
      // Add these differences to the running tally
      movementSum += diffR + diffG + diffB;
      // Render the difference image to the screen
      pixels[i] = color(diffR, diffG, diffB);
      // The following line is much faster, but more confusing to read
      //pixels[i] = 0xff000000 | (diffR << 16) | (diffG << 8) | diffB;
      // Save the current color into the 'previous' buffer
      previousFrame[i] = currColor;
    }
    // To prevent flicker from frames that are all black (no movement),
    // only update the screen if the image has changed.
    if (movementSum > 0) {
      updatePixels();
      println(movementSum); // Print the total amount of movement to the console
    }
  }
}

void keyPressed()
{
  println("KEY PRESSED");
  if(key == 's'){
  saveFrame(rutaFotos + "/fotos/line.png");
   //file = new File(rutaFotos + "/fotos/line.png"); //<>//
  }
  if(key == 't'){
 file = new File(rutaFotos + "/fotos/line.png");
  //The random numbers at the end of randomTweet are to create a new unique tweet everytime. Twitter doesn't like repeat tweets back to back.
  String randomTweet = "Esta imagen y tweet vienen de Processing! @EdenCandelas @Sabasacustico @dgnerbgirl14 " + random(100,200);
  //uncomment testPassingFile(file) to test if your file is good and accessible
  testPassingFile(file); //<>//
  tweetPic(file, randomTweet); //<>//

  }
}
/*
void tweet()
{
    try
    {
        Status status = twitter.updateStatus("Tirando codigo en Processing");
        System.out.println("Estado actualizado a [" + status.getText() + "].");
    }
    catch (TwitterException te)
    {
        System.out.println("Error: "+ te.getMessage());
    }
}
*/
 void testPassingFile(File _file)
{
  println(_file.exists());
  println(_file.getName());
  println(_file.getPath());
  println(_file.canRead());
}
 
void tweetPic(File _file, String theTweet)
{
  try
    {
       StatusUpdate status = new StatusUpdate(theTweet); //<>//
       StatusAdapter statusAda = new StatusAdapter();
       status.setMedia(_file); //<>//
       twitter.updateStatus(status); //<>//
       println(status.getInReplyToStatusId());
       
    }
    catch (TwitterException te)
    {
        println("Error: "+ te.getMessage()); 
    }
}