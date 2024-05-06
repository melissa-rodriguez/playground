OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P2D); 

  noise = new OpenSimplexNoise();
}


float noiseMax = 0.7;
float phase = 0;
void draw() {
  background(0);
  translate(width/2, height/2);
  //noFill();
  for (float yHeight=0; yHeight<5; yHeight+=.01) {
    beginShape();
    for (float a=0; a<6.28; a+=.1) {
      float xoff=map(cos(a+phase), -1, 1, 0, noiseMax);
      float yoff=map(sin(a), -1, 1, 0, noiseMax);
      float n=(float)noise.eval(xoff, yoff);
      float r=map(n, -1, 1, height/4, height/2);
      float x=r*cos(a);
      float y=r*sin(yHeight);
      vertex(x, y);
    }
    endShape();
    phase+=.05;
  }
}
