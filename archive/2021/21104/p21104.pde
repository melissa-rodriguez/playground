import peasy.*;
PeasyCam cam;
dRing ring;
OpenSimplexNoise noise;
void setup() {
  size(900, 900, P3D);
  pixelDensity(2);
  ring = new dRing(0, 0, 0, 0,0,0);
  cam = new PeasyCam(this, 1100);
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
  for (int i=0; i<k; i++) {
    float p = (i+15*t)/k;
    ring.update(p);
    ring.display(p);
  }
  //if(t>1)t=0;
  //if(t<1){
  // saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
}
