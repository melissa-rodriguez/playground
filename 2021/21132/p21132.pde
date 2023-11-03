import peasy.*;
PeasyCam cam;

OpenSimplexNoise noise;

NoiseLoop xNoise;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 4000);
  noise = new OpenSimplexNoise();
  
  xNoise = new NoiseLoop(5);
}

float t;
float scale = 10;
float r1 = 20;
float r2 = 10;
float noiseMax = 2;
void draw() {
  background(0);
  t+=0.002;
  
  rotateX(radians(-145));
  //println(mouseX);
  drawSurface(t);
  drawPoint(t);
  
  //saveFrame("output/gif###.png");
}

PVector surface(float theta, float phi, float t) {
  float x = scale*(r1+r2*easeOutExpo(cos(theta+t)))*cos(phi);
  float y = scale*(r1+r2*easeOutExpo(cos(theta+t)))*sin(phi);
  float z = scale*(r2*easeOutExpo(sin(theta+t)));

  return new PVector(x, y, z);
}

void drawSurface(float t) {
  int n1 = 20; //theta res
  int n2 = 20; //phi res
  fill(0);
  noStroke();
  for (int i = 0; i<=n1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j<=n2; j++) {
      float theta1 = map(i, 0, n1, 0, TAU);
      float theta2 = map(i+1, 0, n1, 0, TAU);
      
      float phi = map(j, 0, n2, 0, TAU);
      
      
      PVector v1 = surface(theta1, phi, t);
      PVector v2 = surface(theta2, phi, t);
      
      float noise1 = (float)noise.eval(v1.x, v1.y,t);
      
      vertex(v1.x, v1.y, v1.z);
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
}

void drawPoint(float t) {
  int n1 = 80; //theta res
  int n2 = 80; //phi res
  for (int i = 0; i<=n1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j<=n2; j++) {
      float theta1 = map(i, 0, n1, 0, TAU);
      float theta2 = map(i+1, 0, n1, 0, TAU);
      
      float phi = map(j, 0, n2, 0, TAU);
      
      
      PVector v1 = surface(theta1, phi, t);
      PVector v2 = surface(theta2, phi, t);
      
      float noise1 = (float)noise.eval(v1.x, v1.y,t);
      
      push();
      translate(v1.x, v1.y, v1.z);
      strokeWeight(map(noise1, -1, 1, 1, 10));
      stroke(255);
      point(0, 0);
      pop();
    }
    endShape();
  }
}

class NoiseLoop{
  float diameter;
 NoiseLoop(float d){
   diameter = d;
 }
}
