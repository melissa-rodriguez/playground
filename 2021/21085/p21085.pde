
import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  cam = new PeasyCam(this, 1000);
  sphereDetail(20);
}

float r = 170, t;
float x, y;
int[] colorArray = {#D9FF00, #ff0000, #ffa500, #ffff00, #002BFF, #008000, #0000ff, #4b0082};
void draw() {
  background(0);
  noStroke();

  lights();
  
  //center
  push();
  sphere(120);
  pop();
  
  //petals
  int index = 1;
  t+=0.02;
  for (float a = 0; a < TAU; a+=PI/6) {
    float s=100*easeInElastic(abs(sin((t))));
    if (s > 50) {
      rotate((t));
    }
    x = (r+s)*cos(a);
    y = (r+s)*sin(a);
    push();
    translate(x, y);
    sphere(100);
    pop();
  }
  
  //saveFrame("output/gif###.png");
}
