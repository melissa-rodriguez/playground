import peasy.*;
PeasyCam cam;

int circleRes = 200; 
float r = 300; 
float zres = 20; 
float stripWidth = 300; 
float t; 


int numParticles = 1000; 
Particle[] particles = new Particle[numParticles];

void setup() {
  size(1080, 1080, P3D); 
  smooth(8); 
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle(random(0.05, 0.5));
  }

  cam = new PeasyCam(this, 800);
}

float p, j, k = 10; 
void draw() {
  clear(); 
  stroke(255); 
  t+=radians(5);  
  for (j = 0; j < k; j++) {
    p = (j+t)/k; 
    push(); 
    push();
    translate(100*cos(TAU*p), 100*sin(TAU*p), -2000+stripWidth*k*p); 

    drawSurface(); 
    if (p > 0.2) {
      stroke(255*map(p, 0.2, 0.4, 0, 1));
    }
    for (int i = 0; i < numParticles; i++) {
      particles[i].draw_point(-t);
      //particles[i].draw_line(t, 7);
    }
    pop();
    pop();
  }

  //if (frameCount <= 24) {
  //  saveFrame("output/gif###.png");
  //}
}

void drawSurface() {
  for (int k = 0; k < zres; k++) {

    beginShape(TRIANGLE_STRIP); 
    fill(0); 
    noStroke(); 
    //noFill(); 
    for (float a = 0; a <= TAU+PI; a+=TAU/circleRes) {
      PVector v1 = calcPoint(k, a); 
      PVector v2 = calcPoint(k+1, a); 
      vertex(v1.x, v1.y, v1.z);
      vertex(v2.x, v2.y, v2.z);
    }
    endShape(CLOSE);




    //for (float a = 0; a <= TAU+PI; a+=TAU/circleRes) {
    //  PVector v1 = calcPoint(k, a); 
    //  PVector v2 = calcPoint(k+1, a); 
    //  push();
    //  stroke(255); 
    //  translate(v1.x, v1.y, v1.z); 
    //  rotate(TAU*map(a, 0, TAU, 0, 1)); 
    //  //line(0, -5, 0, 5); 
    //  //line(-5, 0, 5, 0); 
    //  noFill(); 
    //  //arc(0, 0, 50, 50, 0, PI, OPEN); 
    //  pop(); 
    //}
  }
}

PVector calcPoint(float k, float a) {
  float xoff = map(cos(a), -1, 1, 0, .8); 
  float yoff = map(sin(a), -1, 1, 0, .8);
  float n = noise(xoff, yoff); 

  float x = r*(cos(a)); 
  float y = r*(sin(a)); 
  float z = stripWidth*map(k, 0, zres, -0.5, 0.5);


  return new PVector(x, y, z);
}

class Particle {
  float k;
  float a;
  float offset;
  float weight = 4; 
  float length = 0.3; 
  float sw;

  Particle() {
    offset = random(0, 1);
    k = random(0, zres);
    a = random(0, 2*PI);
    sw = constrain(5*randomGaussian(), 1, 5);
  }

  Particle(float l) {
    offset = random(0, 1);
    k = random(0, zres);
    a = random(0, 2*PI);
    weight = random(1, 2);
    length = l;
    sw = constrain(5*randomGaussian(), 1, 5);
  }

  void draw_point(float t) {
    PVector v = calcPoint(k + offset, a);
    //stroke(255);
    strokeWeight(sw*1.3);
    point(v.x, v.y, v.z);
  }

  void draw_line(float t, int n) {

    PVector[] vectors = new PVector[n+1];
    float dt = length/n;
    for (int i = 0; i <= n; i++) {
      vectors[i] = calcPoint(k + offset - dt*i, a + dt*i);
    }

    strokeWeight(sw);
    //stroke(255);

    for (int i = 0; i < n; i++) {
      line(vectors[i].x, vectors[i].y, vectors[i].z, vectors[i+1].x, vectors[i+1].y, vectors[i+1].z);
    }

    //push();
    //strokeWeight(8);
    //stroke(0, 255, 0);
    //PVector test = vectors[0];
    //point(test.x, test.y, test.z);
    //pop();
  }
}
