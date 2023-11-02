import peasy.*;
PeasyCam cam;

OpenSimplexNoise noise;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 800);
  noiseSeed(1000);
  noise = new OpenSimplexNoise();
}


float count = 1;
float noiseMax = 0.5;
float numPoints = 400;
float amount = 5;
float t;
float r = 100;
float k = 8;
void draw() {
  background(0);
  noFill();
  stroke(255);
  t+=.04;
  strokeWeight(10);



  //for(float x = - width/2 + 2*r; x < width/2 - 2*r; x += r*2){
  // PVector pos = new PVector(x, 0);
  // phase = map(dist(x, 0, width/2, 0), 0, width/2, 0, PI);
  // drawCircle(pos, r, phase); 
  //}

  for (int i = 0; i<k; i++) {
    float p = (i)/k;
    //for (int j = 0; j < amount;j++) {
    float x = map(i, 0, k, -2*r, 2*r);
    float phase = map(i, 0, amount, 0, 6*TAU);
    drawCircle(new PVector(0, 0), 450*p, 0, p);
    //}
  }
}

void drawCircle(PVector pos, float size, float phase, float p) {
  beginShape();
  for (float a = 0; a <= TAU; a += TAU/numPoints) {
    float xoff = map(easeInExpo(sin(a+t))*easeInExpo(sin(6*TAU*a)), -1, 1, 0, noiseMax*easeInExpo(sin(a+t)));
    float yoff = map(sin(a+phase), -1, 1, 0, noiseMax*easeInExpo(sin(a+t)));

    //float r = map(noise(xoff, yoff), 0, 1, 50, 100);
    float r = map((float)noise.eval(xoff, yoff), -1, 1, size/2, size);
    float x = (r)*(cos(a));
    float y = (r)*(sin(a));
    //float y = (r)*(sin(a))*easeInExpo(sin(a+t));
    curveVertex(pos.x + x, pos.y + y);
  }
  endShape(CLOSE);


  //  saveFrame("output/gif###.png");

}

void mousePressed() {
  count ++;
  println(count);
}

//do sketchbook sundays post incomplete/in progress/experiments work + inspo
