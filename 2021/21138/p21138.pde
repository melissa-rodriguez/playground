import peasy.*;
PeasyCam cam;

// Total number of frames in the gif
int numFrames = 80;

float scale = 10;
float r1 = 6;
float r2 = 6;
float t;

// 3D parameterized surface
PVector surface(float theta, float phi, float r1, float r2) {
  float x = scale*(r1+r2*cos(theta+t)) * (cos(phi)+1.0/16*cos(8*phi+4*theta));
  float y = scale*(r1+r2*cos(theta+t)) * (sin(phi)+1.0/16*sin(8*phi+4*theta));
  float z = scale*r2*sin(theta+t);

  return new PVector(x, y, z);
}

// Draws surface
void draw_surface() {
  int n1 = 40; // theta subdivisions
  int n2 = 80; // phi subdivisions

  stroke(255); // white lines
  fill(0); // black fill

  noStroke();

  for (int i = 0; i < n1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < n2+1; j++) {
      float theta1 = map(i, 0, n1, 0, 2*PI);
      float theta2 = map(i+1, 0, n1, 0, 2*PI);

      float phi = map(j, 0, n2, 0, 2*PI);

      PVector v1 = surface(theta1, phi, r1, r2);
      PVector v2 = surface(theta2, phi, r1, r2);

      vertex(v1.x, v1.y, v1.z);
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
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
    weight = random(1, 4);
    length = l;
  }

  void draw_point(float t) {
    PVector v = surface(theta + 2*PI*t + offset, phi + 2*PI*t, r1, r2);
    stroke(255);
    strokeWeight(7);
    point(v.x, v.y, v.z);
  }

  void draw_line(float t, int n) {

    PVector[] vectors = new PVector[n+1];
    float dt = length/n;
    for (int i = 0; i <= n; i++) {
      vectors[i] = surface(theta + 2*PI*t + offset - dt*i, phi - 2*PI*t + dt*i, r1, r2);
    }

    strokeWeight(weight);
    stroke(255);

    for (int i = 0; i < n; i++) {
      line(vectors[i].x, vectors[i].y, vectors[i].z, vectors[i+1].x, vectors[i+1].y, vectors[i+1].z);
    }
  }
}

PVector camera_path(float t) {
  float x = 150+150*sin(t*2*PI - 3*PI/2);
  float y = 0;
  float z = -200*sin(t*2*PI);

  return new PVector(x, y, z);
}

float cameraX = 400;
float cameraY = 0;
float cameraZ = 0;

int numParticles = 8000; 
Particle[] particles = new Particle[numParticles];

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);

  cam = new PeasyCam(this, 100);
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle(random(0.05, 0.5));
  }
}

void draw() {
  background(0);
  t = 1.0*(frameCount-1)/numFrames;


  pushMatrix();

  //rotate(degrees(137.5)*t);
  //rotate(PI*t);
  draw_surface();

  for (int i = 0; i < numParticles; i++) {
    //particles[i].draw_line(0, 7);
    particles[i].draw_point(0);
  }

  popMatrix();

  //if (frameCount<500) {
  //  saveFrame("output/gif###.png");
  //}
}

boolean rec;
int count;
void keyPressed() {

  count++;
  if (count >0) {
    rec = true;
  }
}
