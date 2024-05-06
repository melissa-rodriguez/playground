// Spherical Geometry
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/025-spheregeometry.html
// https://youtu.be/RkuBWEkBrZA
// https://editor.p5js.org/codingtrain/sketches/qVs1hxt

import peasy.*;

PeasyCam cam;
OpenSimplexNoise noise;

PVector[][] globe;
int total = 100;

int numParticles = 800;
Particle[] particles = new Particle[numParticles];

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 1500);
  colorMode(HSB);
  globe = new PVector[total+1][total+1];

  for (int i = 0; i<numParticles; i++) {
    particles[i] = new Particle(random(0.05, 0.5));
  }

  noise = new OpenSimplexNoise();
}

float r = 200;
float t;
void draw() {
  background(0);
  t+=0.025;
  //push();
  //strokeWeight(2);
  //stroke(255);
  //noFill();
  //rectMode(CENTER);
  ////translate(0, 0, mouseX);
  //rect(0, 0, 400, 500);
  //pop();


  rotateX(radians(150));
  rotateY(radians(150));
  
  
  println(mouseX);
  drawSurface(t);
  push();
  drawPoint(t);

  //for (int i = 0; i<numParticles; i++) {
  //  //particles[i].drawPoint(t); 
  //  //particles[i].drawLine(t, 1);
  //}
  pop();

  //if(frameCount<127){
  // saveFrame("output/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}

PVector surface(float lat, float lon, float r) {
  float x = r * sin(lat) * cos(lon);
  float y = r * sin(lat) * sin(lon);
  float z = r * cos(lat);

  return new PVector(x, y, z);
}

void drawSurface(float t) {


  //noFill();
  fill(0);
  for (int i = 0; i < total+1; i++) {
    float lat = map(i, 0, total, 0, PI);
    for (int j = 0; j < total+1; j++) {
      float lon = map(j, 0, total, 0, TWO_PI);
      float x = r*2 * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      float z = r*2 * cos(lat);
      float n = (float)noise.eval(x, y);

      globe[i][j] = new PVector(x, y+150*easeOutBack(sin(radians(mag(x, z))+t)), z);
    }
  }

  for (int i = 0; i < total; i++) {
    beginShape(TRIANGLE_STRIP);

    for (int j = 0; j < total+1; j++) {
      PVector v1 = globe[i][j];
      //stroke(255, 80*sin(radians(mag(v1.y, v1.y))));
      stroke(255, 50*map(mag(v1.y, v1.y), 0, r, 0.2, 1));
      //stroke(255);
      strokeWeight(2);
      noStroke();
      vertex(v1.x, v1.y, v1.z);
      PVector v2 = globe[i+1][j];
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
}

void drawPoint(float t) {
  stroke(255);
  //noFill();
  strokeWeight(5);
  fill(0);
  for (int i = 0; i < total+1; i++) {
    float lat = map(i, 0, total, 0, PI);
    for (int j = 0; j < total+1; j++) {
      float lon = map(j, 0, total, 0, TWO_PI);
      float x = (r+1)*2 * sin(lat) * cos(lon);
      float y = (r+1) * sin(lat) * sin(lon);
      float z = (r+1)*2 * cos(lat);
      //globe[i][j] = new PVector(x, y, z);
      PVector v1 = new PVector(x, y+150*easeOutBack(sin(radians(mag(x, z))+t)), z);
      push();
      translate(v1.x, v1.y, v1.z);
      //circle(0, 0, 30);
      strokeWeight(20*(float)noise.eval(x*.02, y*.02));
      //strokeWeight(40);
      point(0, 0, 0);
      pop();
    }
  }

  //for (int i = 0; i < total; i++) {
  //  //beginShape();
  //  for (int j = 0; j < total+1; j++) {
  //    PVector v1 = globe[i][j];
  //    push();
  //    translate(v1.x, v1.y, v1.z);

  //    circle(0, 0, 20);
  //    pop();
  //  }
  //  //endShape();
  //}
}
