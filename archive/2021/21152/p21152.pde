//BASED OF SKETCH FROM p2021_06_10/v01

import peasy.*;
PeasyCam cam;
dRing ring;
OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  ring = new dRing(0, 0, 0, 0,0,0);
  cam = new PeasyCam(this, 900);
  noise = new OpenSimplexNoise();
}

float t = 0;

int k = 200;

void draw() {
  t += .01;
  //background(240);
  background(0);
  //noStroke();
  //translate(300, 300);
  rotateY(radians(112));
  println(mouseX);
  for (int i=0; i<k; i++) {
    float p = (i+15*t)/k;
    ring.update(p);
    ring.display(p);
  }
  if(t>1)t=0;
  //if(t<1){
  // saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
}
