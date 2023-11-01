//mobius strip equation found here:
//http://virtualmathmuseum.org/Surface/klein_bottle/klein_bottle.html#:~:text=Klein%20Bottle%20Hermann%20Karcher%20Parametric,See%20the%20Mobius%20Strip%20first.

import peasy.*;

PeasyCam cam;
OpenSimplexNoise noise;

PVector[][] globe;
int total = 200;

//int numParticles = 800;
//Particle[] particles = new Particle[numParticles];

void settings(){
    size(1080, 1080, P3D);
    pixelDensity(2);
    smooth(8);
}

void setup() {

  cam = new PeasyCam(this, 2500);
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
  t+=0.03;

  println(mouseX, mouseY);
  //rotateX(radians(180));
  //rotateY(radians(338));
  //rotateX(radians(60));
  //rotateY(radians(10));
  push();
  rectMode(CENTER);
  //noFill();
  //stroke(255);
  translate(0, 500,0);
  rotateX(radians(135));
  rect(0, 0, 150, 1000);
  
  stroke(255);
  strokeWeight(2);
  line(-width, -500, width, -500);
  
  pop();
  
  rotate(radians(45));
  //rotateX(radians(mouseX));
  push();
  noStroke();
  stroke(255);
  drawSurface(t);
  
  //drawPoint(t);
  pop();

  
  //if(frameCount<106){
  // saveFrame("output2/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}

PVector surface(float theta, float phi) {
  float w = 1+(sin(theta+t)*sin(phi)+sin(theta/2+t)*cos(phi))/sqrt(2);


  //equation for mobius strip
  //float x = scale*((1.5 + cos(theta+t / 2) * sin(phi) - sin(theta+t / 2) * sin(2 * phi)) * cos(theta));
  //float y = scale*(( 1.5+ cos(theta+t / 2) * sin(phi) - sin(theta+t / 2) * sin(2 * phi)) * sin(theta));
  //float z = scale*(sin(theta+t / 2) * sin(phi) + cos(theta+t / 2) * sin(2 * phi));
  float r = 2*sin(theta)+3*cos(theta)+phi;
    //equation for mobius strip
  float x = scale*(1-theta)*(3+cos(phi+t)*cos(4*PI*theta+t));
  float y = scale*(1-theta)*(3+cos(phi+t)*sin(4*PI*theta+t));
  float z = scale*3*theta+(1-theta)*sin(phi+t);


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
  int n1 = 50; // theta subdivisions
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
      strokeWeight(12*map((float)noise.eval(v1.x*0.02, v1.y*0.02), 0, 1, 0.5, 1));
      //strokeWeight(7*map(noise(v1.x, v1.y), 0, 1, 0.3, 1));
      point(v1.x, v1.y, v1.z);
      point(v2.x, v2.y, v2.z);
    }
    //endShape();
  }
}
