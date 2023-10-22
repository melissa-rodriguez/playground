import peasy.*;
PeasyCam cam;


OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P2D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
  //cam = new PeasyCam(this, 500);
}

float noiseMax = 0.7;
float phase = 0;
void draw() {
  background(240); 

  translate(width/2, height/2);
  noFill();

  for (float yHeight = 0; yHeight < 5; yHeight += 0.01) {
    drawCircle(yHeight);
  }
  
  //rec();
}

void drawCircle(float yHeight) {
  beginShape();
  for (float a = 0; a< TWO_PI; a += 0.1) {
    float xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
    float yoff = map(sin(a), -1, 1, 0, noiseMax);

    float n = (float) noise.eval(xoff, yoff);
    float r = map(n, 0, 1, height/4, height/2);
    float x = r*cos(a);
    float y = r*sin(yHeight);
    vertex(x, y);
  }
  endShape(CLOSE);
  phase+=0.05;
}
