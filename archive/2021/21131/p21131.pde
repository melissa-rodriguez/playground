import peasy.*;
PeasyCam cam;
dRing ring;

int numParticles = 2000; 
Particle[] particles = new Particle[numParticles];

void setup() {
  size(900, 900, P3D);
  pixelDensity(2);
  ring = new dRing(0, 0, 0, 0, 0, 0);
  cam = new PeasyCam(this, 900);

  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle(random(0.05, 0.5));
  }
}

//float t = 0;

int k = 200;

float j = 0;

void draw() {
  //t += .01;
  background(0);
  stroke(255);
  //noStroke();
  //translate(300, 300);
  for (int i=0; i<k; i++) {
    p = (i+25*j)/k;
    //p = map(mouseX, 0, width, 0 ,1);
    ring.update(p);
    ring.display(p);
  }

  //for (int i = 0; i < numParticles; i++) {
  //  particles[i].draw_pt(t, p);
  //}
}
//  if (t>1)t=0
float t, x, y, z, r,p;
PVector pointSurface(float theta, float phi, float t) {
    //r = pow(p, 8.0)*1000;
    float r = 100;
    float xPos1 = r*x + r*cos(theta)*cos(phi+t);
    float yPos1 = y + r*sin(theta)*sin(phi+t);
    float zPos1 = 800-(p*0.1)*1e4;

    return new PVector(xPos1, yPos1, zPos1);
  }

class Particle {
  float theta;
  float phi;
  float offset;
  float weight = 2; 
  float length = 0.3; 

  Particle() {
    offset = random(0, 1);
    theta = random(0, 2*PI);
    phi = random(0, 2*PI);
  }

  Particle(float l) {
    offset = random(0, 1);
    theta = random(0, 2*PI);
    phi = random(0, 2*PI);
    weight = random(1, 2);
    length = l;
  }

  void draw_point(float t, float p) {
    PVector v = pointSurface(theta + 2*PI*t + offset, phi + 2*PI*t, t);
    stroke(255);
    strokeWeight(3);
    point(v.x, v.y, v.z);
  }

  void draw_line(float t, int n, float p) {

    PVector[] vectors = new PVector[n+1];
    float dt = length/n;
    for (int i = 0; i <= n; i++) {
      vectors[i] = pointSurface(theta + 2*PI*t + offset - dt*i, phi - 2*PI*t + dt*i, t);
    }

    strokeWeight(weight);
    stroke(255);

    for (int i = 0; i < n; i++) {
      line(vectors[i].x, vectors[i].y, vectors[i].z, vectors[i+1].x, vectors[i+1].y, vectors[i+1].z);
    }
  }
}
