PGraphics pg;
import peasy.*;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pg = createGraphics(2000, 2000, P3D);
  pixelDensity(2);
  smooth(8);
  pg.smooth(8);

  cam = new PeasyCam(this, 1200);
}

float a; 
float count = 0;
void draw() {
  background(0);
  stroke(255);
  strokeWeight(4);


  beginShape();
  noFill();
  for (float theta = 0; theta <= TAU; theta+=TAU/100) {
    //float off = map(theta, 0, TAU, 0, count*TAU);
    float off = map(theta, 0, TAU, 0, 32*TAU);
    float cx = 300*cos(theta+off);
    float cy = 300*sin(theta+off);
    float x = 150*cos(a+off);
    float y = 150*sin(a+off);
    curveVertex(cx+x, cy+y);
  }
  endShape();
  a+=radians(2);

  //if (frameCount <= 180) {
  //  saveFrame("output/gif###.png");
  //}else{exit();}
}

void mousePressed() {
  count++;
  println(count);
}
