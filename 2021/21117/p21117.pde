import peasy.*;
PeasyCam cam;
//void setup(){
//  size(1080, 1080, P3D);
//  cam = new PeasyCam(this, 800);
//}

int xspacing = 16;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 75.0;  // Height of wave
float period = 500.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave

ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 900);
  w = width*2;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
  int numParticles = 2000;
  
  for(int amt = 0; amt < numParticles; amt++){
    particles.add(new Particle());
  }
}
//float t;
void draw() {
  background(0);
  for(Particle p : particles){
   p.render(); 
  }
  
 
  
  
  //t+=0.01;
  stroke(0);
  rotateY(PI/2);
  rotate(-radians(30));
  //println(mouseX);
  rotateY(PI);
  translate(0, width, 0);
  for (float z = -width*2; z<width*2; z+=200) {
    push();
    translate(0, 0, z);
    calcWave(z);
    renderWave();
    pop();
  }
  
  //if(frameCount<15){
  // saveFrame("output3/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}



void calcWave(float z) {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.01;
  float d = map(dist(0, 0, z, 0, 0,0), 0, width, TAU, 0);
  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x+d)*amplitude;
    x+=dx;
  }
}

void renderWave() {
  noStroke();
  fill(255);
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    //ellipse(width/2-x*xspacing, yvalues[x], 16, 16);
    push();
    translate(width/2-x*xspacing, yvalues[x], 0);
    box(7, 7, 100);
    pop();
  }
}
