// Spherical Geometry
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/025-spheregeometry.html
// https://youtu.be/RkuBWEkBrZA
// https://editor.p5js.org/codingtrain/sketches/qVs1hxt

import peasy.*;

PeasyCam cam;
OpenSimplexNoise noise;

PVector[][] globe;
int total = 200;

//int numParticles = 800;
//Particle[] particles = new Particle[numParticles];

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 330);
  colorMode(HSB);
  globe = new PVector[total+1][total+1];

  //for (int i = 0; i<numParticles; i++) {
  //  particles[i] = new Particle(random(0.05, 0.5));
  //}

  noise = new OpenSimplexNoise();
}

float r1 = 100;
float r2 = 60;
float t;
float scale = 1;
void draw() {
  background(0); 
  t+=0.05;
  //push();
  //strokeWeight(2);
  //stroke(255);
  //noFill();
  //rectMode(CENTER);
  ////translate(0, 0, mouseX);
  //rect(0, 0, 400, 500);
  //pop();


  rotateX(radians(90));
  rotateY(radians(90));
  rotate(radians(90));
  strokeWeight(2);
  //println(mouseX);
  push();
  translate(-r1, 0);
  noStroke();
  stroke(255);
  drawSurface(t);
  
  //drawPoint(t);
  pop();
  push();
  translate(r1, 0);
  noStroke();
  drawSurface(t);
  stroke(255);
  drawPoint(t);
  pop();
  push();
  //drawPoint(t);

  //for (int i = 0; i<numParticles; i++) {
  //  //particles[i].drawPoint(t); 
  //  //particles[i].drawLine(t, 1);
  //}
  pop();

  //if(frameCount<127){
  // saveFrame("output3/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}

PVector surface(float theta, float phi) {
  float x = scale*(r1+r2*cos(theta))*cos(phi+t/5);
  float y = scale*(r1+r2*cos(theta))*sin(phi+t/5);
  float z = scale*2*r2*sin(theta);

  return new PVector(x, y, z);
}

void drawSurface(float t) {
  int n1 = 40; // theta subdivisions
  int n2 = 40; // phi subdivisions

  //stroke(255); // white lines
  fill(0); // black fill

  //noStroke();

  for (int i = 0; i < n1; i++) {
    // Stripes
    // if ((i)%2 == 0) {
    //   fill(0);
    // } else {
    //   fill(200);
    // }
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < n2+1; j++) {
      float theta1 = map(i, 0, n1, 0, 2*PI);
      float theta2 = map(i+1, 0, n1, 0, 2*PI);

      float phi = map(j, 0, n2, 0, 2*PI);

      PVector v1 = surface(theta1, phi);
      PVector v2 = surface(theta2, phi);
      globe[i][j] = new PVector(v1.x, v1.y, v1.z);
      //stroke(255, 50*map(mag(v1.x, v1.y,v1.z), 0, r2, 0.2, 1));

      vertex(v1.x, v1.y, v1.z);
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
}

void drawPoint(float t) {
  int n1 = 100; // theta subdivisions
  int n2 = 100; // phi subdivisions

  stroke(255); // white lines
  fill(0); // black fill
  

  //noStroke();

  for (int i = 0; i < n1; i++) {
    // Stripes
    // if ((i)%2 == 0) {
    //   fill(0);
    // } else {
    //   fill(200);
    // }
    //beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < n2+1; j++) {
      float theta1 = map(i, 0, n1, 0, 2*PI);
      float theta2 = map(i+1, 0, n1, 0, 2*PI);

      float phi = map(j, 0, n2, 0, 2*PI);

      PVector v1 = surface(theta1, phi);
      PVector v2 = surface(theta2, phi);
      globe[i][j] = new PVector(v1.x, v1.y, v1.z);
      //stroke(255, 50*map(mag(v1.x, v1.y,v1.z), 0, r2, 0.2, 1));
      //strokeWeight(20*(float)noise.eval(v1.x*0.02, v1.z*0.02));
      strokeWeight(4);
      point(v1.x, v1.y, v1.z);
      point(v2.x, v2.y, v2.z);
    }
    //endShape();
  }
}
