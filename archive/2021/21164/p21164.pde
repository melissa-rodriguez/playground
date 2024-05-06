import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
  cam = new PeasyCam(this, 4000);
  smooth(8);
}

float p, i, t, k1, k2; 
float r = 200;
void draw() {
  background(0);
  t+=radians(3); 
  
  rotateX(radians(72));
  rotate(radians(136));
  println(mouseX);

  push();
  //rotateY(PI/2);
  //rotate(t);
  //translate(0,0,mouseX);

  //drawWheelSurface();
  //drawWheelPoints();
  //drawFloorSurface();
  drawFloorPoints();
  pop();
  
  push();
  stroke(255);
  strokeWeight(8);
  noFill();
  circle(0, 0, width+1500);
  //println(mouseX);
  pop();
  
  //if(frameCount<=72){
  // saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
  
}



void drawWheelSurface() {
  float numPoints = 20;
  k1 = 10;
  float n1 = 100;
  float n2 = 100;
  //float r = 500;

  //circle(0, 0, 300);

  strokeWeight(5);
  stroke(255);
  noFill();

  for (int j = 0; j < n2; j++) {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < n1; i++) {
      float theta = map(i, 0, n1, 0, TAU);
      PVector v = surface(i, j, n1, n2);
      PVector v2 = surface(i, j+1, n1, n2);
      if (v.mag() < r) {
        vertex(v.x, v.y);
        vertex(v2.x, v2.y);
      }
    }
    endShape();
  }
}

void drawWheelPoints() {
  float numPoints = 20;
  k1 = 10;
  float n1 = 60;
  float n2 = 60;
  //float r = 500;

  //circle(0, 0, 300);

  strokeWeight(5);
  stroke(255);
  noFill();

  for (int j = 0; j < n2; j++) {
    for (int i = 0; i < n1; i++) {
      float theta = map(i, 0, n1, 0, TAU);
      PVector v = surface(i, j, n1, n2);
      PVector v2 = surface(i, j+1, n1, n2);
      if (v.mag() < r) {
        float n = map((float)noise.eval(v.x*0.003, v.y*0.003), -1, 1, 0.5, 1);
        point(v.x*n, v.y*n);

        //point(v2.x, v2.y);
      }
    }
  }
  
  
}

void drawFloorSurface() {
  float numPoints = 20;
  k1 = 10;

  strokeWeight(5);
  //stroke(255,200);
  //stroke(0);
  noStroke();

  //for (i = 0; i < k1; i++) {
  //  p = (i)/k1;
  //  for (float a = 0; a < numPoints; a+=TAU/numPoints) {
  //    float scale = map(i, 0, k1, 0, 1);
  //    float x = r*cos(a);
  //    float y = r*sin(a);
  //    point(x, y, -p*r/2);
  //    //point(x, y, -r/2);
  //  }
  //}

  float n1 = 100; 
  float n2 = 100;
  float rev = 3; //revolutions for the spiral
  //for (int i = 0; i < n1; i++) {
  //  p = i/n1;
  //  //for(int j = 0; j < n2; j++){
  //  float theta = map(i, 0, n1, 0, rev*TAU);
  //  float theta2 = map(i+1, 0, n1, 0, rev*TAU);
  //  PVector v = floorSurface(theta, p, n1, n2);
  //  point(v.x, v.y, v.z);
  //  //}
  //}

  for (int i = 0; i <= n1; i++) {
    p = i/n1;
    beginShape(TRIANGLE_STRIP);
    //noFill();
    fill(0);
    for (int j = 0; j <= n2; j++) {
      float theta = map(i, 0, n1, 0, rev*TAU);
      float theta2 = map(i+1, 0, n1, 0, rev*TAU);
      float phi = map(j, 0, n2, 0, TAU);
      PVector v = floorSurface(theta, phi, p, n1, n2);
      PVector v2 = floorSurface(theta2, phi, p, n1, n2);
      float n = (float) noise.eval(v.x*0.003, v.y*0.003);
      float offset = map(n, -1, 1, 0.4, 1);
      vertex(v.x, v.y, v.z);
      vertex(v2.x, v2.y, v2.z);
      //point(v.x, v.y, v.z);
    }
    endShape();
  }
}

void drawFloorPoints() {
  float numPoints = 20;
  k1 = 10;

  strokeWeight(5);
  stroke(255);

  //for (i = 0; i < k1; i++) {
  //  p = (i)/k1;
  //  for (float a = 0; a < numPoints; a+=TAU/numPoints) {
  //    float scale = map(i, 0, k1, 0, 1);
  //    float x = r*cos(a);
  //    float y = r*sin(a);
  //    point(x, y, -p*r/2);
  //    //point(x, y, -r/2);
  //  }
  //}

  float n1 = 100; 
  float n2 = 100;
  float rev = 6; //revolutions for the spiral
  //for (int i = 0; i < n1; i++) {
  //  p = i/n1;
  //  //for(int j = 0; j < n2; j++){
  //  float theta = map(i, 0, n1, 0, rev*TAU);
  //  float theta2 = map(i+1, 0, n1, 0, rev*TAU);
  //  PVector v = floorSurface(theta, p, n1, n2);
  //  point(v.x, v.y, v.z);
  //  //}
  //}

  for (int i = 0; i <= n1; i++) {
    p = i/n1;
    //noFill();
    fill(0);
    beginShape();
    noFill();
    stroke(255);
    for (int j = 0; j <= n2; j++) {
      float theta = map(i, 0, n1, 0, rev*TAU);
      float theta2 = map(i+1, 0, n1, 0, rev*TAU);
      float phi = map(j, 0, n2, 0, TAU);
      PVector v = floorSurface(theta, phi, p, n1, n2);
      PVector v2 = floorSurface(theta2, phi, p, n1, n2);
      float n = (float) noise.eval(v.x*0.01, v.y*0.01);
      float off = map(n, -1, 1, 0, 1);
      //strokeWeight(12*off);
      strokeWeight(10);
      vertex(v.x, v.y, v.z);
      //point(v.x, v.y, v.z);
    }
    endShape();
  }
  
  for (int i = 0; i <= n1; i++) {
    p = i/n1;
    //noFill();
    fill(0);
    beginShape();
    noFill();
    stroke(0);
    for (int j = 0; j <= n2; j++) {
      float theta = map(i, 0, n1, 0, rev*TAU);
      float theta2 = map(i+1, 0, n1, 0, rev*TAU);
      float phi = map(j, 0, n2, 0, TAU);
      PVector v = floorSurface(theta, phi, p, n1, n2);
      PVector v2 = floorSurface(theta2, phi, p, n1, n2);
      float n = (float) noise.eval(v.x*0.01, v.y*0.01);
      float off = map(n, -1, 1, 0, 1);
      //strokeWeight(12*off);
      strokeWeight(5);
      vertex(v.x, v.y, v.z);
      //point(v.x, v.y, v.z);
    }
    endShape();
  }
}

PVector floorSurface(float theta, float phi, float p, float n1, float n2) {
  float x = r*phi*(cos(theta));
  float y = r*phi*(sin(theta));
  //float z = -p*r*sin(theta+t); 
  //float z = -p*r/7*phi*easeOutBack(sin(theta+t))*sin(phi); 
  float z = -p*r/2*phi*(sin(theta+t))*sin(phi); 
  float n = (float) noise.eval(x*0.01, y*0.01);
  float off = map(n, -1, 1, 0.8, 1);


  return new PVector(x, y, z*off);
}

PVector surface(float i, float j, float n1, float n2) {
  float x = map(i, 0, n1, -width/2, width/2);
  float y = map(j, 0, n2, -height/2, height/2);
  return new PVector(x, y);
}
