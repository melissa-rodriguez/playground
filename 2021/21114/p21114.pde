import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;

float p, i, t, k = 1;
float r = 200;
int total = 50;

float noiseOffset(float x, float y, float seed) {
  return (float) noise.eval(x+seed, y+seed);
}
PVector surface(float theta, float phi, float r) {
  float x = r*sin(theta)*cos(phi);
  float y = r*sin(theta)*sin(phi);
  float z = r*cos(theta);
  float n = (float) noise.eval(x*0.0001, y*.01);

  //float n = (float) noise.eval(x*0.002, y*.002);
  return new PVector(x*n, y, z);
}

void drawSurface() {
  float n1 = 40; //theta subdivisions
  float n2 = 80; //phi subdivisions
  //noFill();
  fill(0);
  //strokeWeight(3);
  noStroke();

  for (int i = 0; i<=total+1; i++) {

    beginShape();
    for (int j = 0; j<=total+1; j++) {
      float theta1 = map(i, 0, total, -PI, PI); 
      float theta2 = map(i+1, 0, n1, -PI, PI);

      float phi = map(j, 0, total, -PI/2, PI/2);

      //stroke(255);
      //curveVertex(x, y*n, z);
      PVector v1 = surface(theta1, phi, r);
      PVector v2 = surface(theta2, phi, r);

      curveVertex(v1.x, v1.y, v1.z);
      //curveVertex(v2.x, v2.y, v2.z);
    }
    endShape(CLOSE);
  }
}

int numParticles = 2000;
Particle[] particles = new Particle[numParticles];
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 500);
  noise = new OpenSimplexNoise();

  for (int i = 0; i<numParticles; i++) {
    particles[i] = new Particle(random(0.05, 0.5));
  }
}


void draw() {
  background(0); 
  t+=0.01;
  //rotate(PI/2);
  //rotateY(PI/3);
  drawSurface();
  //for (i = 0; i< k; i++) {
  //  p = (i+t)/k;
  //  //createGlobe(p);
  //}

  push();
  for (int i = 0; i<numParticles; i++) {
    //particles[i].drawPoint(t); 
    particles[i].drawLine(t, 7);
  }
  pop();
  
  
  //if(frameCount<=200){
  // saveFrame("output2/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}

void createGlobe(float p) {
}

void globe() {
  //float r = 200;
  //int total = 100;
  //noFill();
  //strokeWeight(3);
  //for (int i = 0; i<total+1; i++) {
  //  float theta = map(i, 0, total, -PI, PI);
  //  beginShape();
  //  for (int j = 0; j<total+1; j++) {
  //    float phi = map(j, 0, total, -PI/2, PI/2);
  //    float x = r*sin(theta)*cos(phi);
  //    float y = r*sin(theta)*sin(phi);
  //    float z = r*cos(theta);
  //    float n = (float) noise.eval(x*0.002, y*0.002);
  //    stroke(255);
  //    curveVertex(x, y*n, z);
  //  }
  //  endShape(CLOSE);
  //}
}

boolean save = false;
void keyPressed(){
 if (key == 's' || key == 'S') {
      save = true;
    } 
  
}
