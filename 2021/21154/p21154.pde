/**
 * Sine Wave
 * by Daniel Shiffman.  
 * 
 * Render a simple sine wave. 
 */

//Wave w = new Wave();
import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;

ArrayList<Wave> waves = new ArrayList<Wave>();

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 1500);
  smooth(8);
  noise = new OpenSimplexNoise();
  
  for(int i = 0; i < 9; i++){
   float x = map(i, 0, 5, -100, 100);
   waves.add(new Wave(x));
  }
  
}

float t;
void draw() {
  background(0);
  t+=1;
  translate(0, 0, -1000);
  rotateX(radians(88));
  //w.calcWave();
  //w.renderWave();
  
  for(Wave w : waves){
   w.calcWave();
   w.renderWave();
  }
  //println(mouseX);
  
  //saveFrame("output/gif###.png");
}





class Wave {
  int yspacing = 20;   // How far apart should each horizontal location be spaced
  int w;              // Width of entire wave

  float theta = 0.0;  // Start angle at 0
  float amplitude = 75.0;  // Height of wave
  float period = 500.0;  // How many pixels before the wave repeats
  float dy;  // Value for incrementing X, a function of period and xspacing
  float[] xvalues;  // Using an array to store height values for the wave
  float x; //x location of the wave as a whole
  float r;

  Wave(float xpos) {
    w = width*100;
    dy = (TWO_PI / period) * yspacing;
    xvalues = new float[w/yspacing];
    x = xpos;
    r = random(1, 16);
  }

  void calcWave() {
    // Increment theta (try different values for 'angular velocity' here
    theta += 0.02;

    // For every x value, calculate a y value with sine function
    float y = theta;
    for (int i = 0; i < xvalues.length; i++) {
      xvalues[i] = sin(y)*amplitude;
      y+=dy;
    }
  }

  void renderWave() {
    noStroke();
    //stroke(255);
    fill(255);
    // A simple way to draw the wave with an ellipse at each location
    for (int y = 0; y < xvalues.length; y++) { 
      //push();
      //strokeWeight(r);
      //translate(x +xvalues[y],y*yspacing);
      //point(0,0);
      //pop();
      ellipse(x +xvalues[y],y*yspacing, r, r);
    }
  }
}
