//mobius strip equation found here:
//http://virtualmathmuseum.org/Surface/klein_bottle/klein_bottle.html#:~:text=Klein%20Bottle%20Hermann%20Karcher%20Parametric,See%20the%20Mobius%20Strip%20first.

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
float scale = 50;
void draw() {
  background(0);
  t+=0.06;
  //push();
  //strokeWeight(2);
  //stroke(255);
  //noFill();
  //rectMode(CENTER);
  ////translate(0, 0, mouseX);
  //rect(0, 0, 400, 500);
  //pop();

  println(mouseX);
  //rotateX(radians(180));
  //rotateY(radians(338));
  
  push();
  rotateY(radians(90));
  //rotateY(radians(10));
  push();
  noStroke();
  drawSurface(t);
  stroke(255);
  drawPoint(t);
  pop();
  pop();


  //if(frameCount<106){
  // saveFrame("output2/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}

PVector surface(float theta, float phi) {
  //float x = scale*(r1+r2*cos(theta))*cos(phi);
  //float y = scale*(r1+r2*cos(theta))*sin(phi);
  //float z = scale*2*r2*sin(theta);

  float w = 1+(sin(theta+t)*sin(phi)+sin(theta/2+t)*cos(phi))/sqrt(2);
  //float x = scale*(sin(theta)*cos(phi));
  //float y = scale*(sin(theta)*sin(phi));
  //float z = scale*(cos(theta));

  //equation for mobius strip
  //float x = scale*((1.5 + cos(theta+t / 2) * sin(phi) - sin(theta+t / 2) * sin(2 * phi)) * cos(theta));
  //float y = scale*(( 1.5+ cos(theta+t/ 2) * sin(phi) - sin(theta+t / 2) * sin(2 * phi)) * sin(theta));
  //float z = scale*(sin(theta+t / 2) * sin(phi) + cos(theta+t / 2) * sin(2 * phi));
  
  float x = scale*((1.5 + cos(theta/ 2) * sin(phi) - sin(theta / 2) * sin(2 * phi)) * cos(theta));
  float y = scale*(( 1.5+ cos(theta/ 2) * sin(phi) - sin(theta / 2) * sin(2 * phi)) * sin(theta));
  float z = scale*(sin(theta / 2) * sin(phi) + cos(theta / 2) * sin(2 * phi));
  
  float n = (float) noise.eval(x*0.02,y*0.02);


  return new PVector(x, y, z*easeInExpo(sin(radians(mag(y,y))+t)));
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
  int n1 = 50; // theta subdivisions
  int n2 = 200; // phi subdivisions

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
      strokeWeight(12*map((float)noise.eval(v1.x*0.02, v1.y*0.02), 0, 1, 0.5, 1));
      //strokeWeight(7*map(noise(v1.x, v1.y), 0, 1, 0.3, 1));
      point(v1.x, v1.y, v1.z);
      point(v2.x, v2.y, v2.z);
    }
    //endShape();
  }
}
