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
  cam = new PeasyCam(this, 4700);
  colorMode(HSB);
  globe = new PVector[total+1][total+1];

  //for (int i = 0; i<numParticles; i++) {
  //  particles[i] = new Particle(random(0.05, 0.5));
  //}

  noise = new OpenSimplexNoise();
}

float r1 = 60;
float r2 = 15;
float t;
float scale = 80;
float p = 3; //n times around axis of symmetry 
float q = 2; //n times around a circle 
void draw() {
  background(0);
  t+=radians(3);
  //push();
  //strokeWeight(2);
  //stroke(255);
  //noFill();
  //rectMode(CENTER);
  ////translate(0, 0, mouseX);
  //rect(0, 0, 400, 500);
  //pop();

  println(mouseX);
  //rotateX(radians(90));
  //rotateZ(radians(18));
  rotateX(radians(10));
  rotateY(radians(10));
  push();
  noStroke();
  drawSurface(t);
  stroke(255);
  drawPoint(t);
  pop();


  //if(frameCount<=120){
  // saveFrame("output2/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}

PVector surface(float theta, float phi) {
  
  //float x = scale*(r1+r2*cos(theta-t))*cos(phi);
  //float y = scale*(r1+r2*cos(theta-t))*sin(phi);
  //float z = scale*2*r2*sin(theta-t);
  

  
  float r = cos(q*theta)+4;
  float x = scale*(r*cos(p*theta+t))-3*cos((p-q)*theta)*(scale*r*phi);
  float y = scale*(r*sin(p*theta+t))-3*sin((p-q)*theta)*(scale*r*phi);
  float z = scale*2*(-r*easeInExpo(sin(q*theta+t)));
  

  //equation for mobius strip
  //float x = scale*((1.5 + cos(theta+t / 2) * sin(phi) - sin(theta+t / 2) * sin(2 * phi)) * cos(theta));
  //float y = scale*(( 1.5+ cos(theta+t / 2) * sin(phi) - sin(theta+t / 2) * sin(2 * phi)) * sin(theta));
  //float z = scale*(sin(theta+t / 2) * sin(phi) + cos(theta+t / 2) * sin(2 * phi));


  return new PVector(x, y, z);
}

void drawSurface(float t) {
  int n1 = 100; // theta subdivisions
  int n2 = 100; // phi subdivisions

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
      //strokeWeight(18*map(mag(v1.x, v1.y), 0, 200, 1, 0));
      strokeWeight(18*map((float)noise.eval(v1.x*0.02, v1.y*0.02), 0, 1, 0.5, 1));
      
      //strokeWeight(7*map(noise(v1.x, v1.y), 0, 1, 0.3, 1));
      point(v1.x, v1.y, v1.z);
      point(v2.x, v2.y, v2.z);
    }
    //endShape();
  }
}
