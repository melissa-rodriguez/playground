import peasy.*;
PeasyCam cam;
ArrayList<Vehicle> vehicles; //vehicles class 
int cols, rows;
int res; //resolution

OpenSimplexNoise noise;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
  vehicles = new ArrayList<Vehicle>();
  //vehicles.add(new Vehicle(0, 0)); //test add vehicle 

  res = 3;

  cols = width/res; 
  rows = height/res;

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = map(i, 0, cols, 0, width);
      float y = map(j, 0, rows, 0, height);
      vehicles.add(new Vehicle(x, y));
    }
  }
  cam = new PeasyCam(this, 800);
}

float t; 
void draw() {
  background(0);
  translate(-width/2, -height/2);
  t+=radians(5);

  for (Vehicle v : vehicles) {
    v.show();
    v.update();
    v.behaviors();
  }

  //if (frameCount>100 && frameCount<=172) {
  //  saveFrame("output2/gif###.png");
  //}
}

class Vehicle {
  PVector pos, vel, acc;
  PVector target;
  float r;
  float maxSpeed = 10;
  float maxForce = 1; 
  PVector steer;
  float a; //angle

  Vehicle(float x, float y) {
    //pos = new PVector(random(-width/2, width/2), random(-height/2, height/2));
    pos = new PVector(x, y);
    target = new PVector(x, y);
    //vel = new PVector(0, 0);
    vel = PVector.random2D();
    acc = new PVector(0, 0); 


    //r = map((float)noise.eval(pos.x*0.005, pos.y*0.005), -1, 1, 1, 8); //size of particle
    r = 5;
  }

  void behaviors() {
    PVector arrive = arrive(target);

    float x1 = 200*(cos(a));
    float y1 = 200*(sin(a));
    
    float x2 = 250*(cos(a+PI));
    float y2 = 250*(sin(a+PI));
    //a+=radians(10);
    a = (sin((t)));
    PVector mouse = new PVector(width/2+x1, height/2+y1);
    PVector flee1 = flee(mouse);
    PVector flee2 = flee(new PVector(width/2+x2, height/2+y2));

    arrive.mult(1);
    flee1.mult(5);
    flee2.mult(5);

    applyForce(arrive);
    applyForce(flee1);
    applyForce(flee2);
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  void update() {
    pos.add(vel);
    vel.add(acc);

    acc.mult(0); //clears acc
  }

  void show() {
    stroke(255);
    strokeWeight(r); 
    point(pos.x, pos.y);
  }

  PVector arrive(PVector target) {
    PVector desired = PVector.sub(target, pos); //subtract two vectors
    float speed = maxSpeed; 
    float d = desired.mag();
    if (d < 100) {
      speed = map(d, 0, 100, 0, maxSpeed);
      r = map(speed, 0, maxSpeed, 0, 7);
    }
    desired.setMag(speed);
    steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    return steer;
  }

  PVector flee(PVector target) {
    PVector desired = PVector.sub(target, pos); //subtract two vectors
    float d = desired.mag();
    if (d<50) {
      desired.setMag(maxSpeed);
      desired.mult(-1);
      steer = PVector.sub(desired, vel);
      steer.limit(maxForce);

      return steer;
    } else {
      return new PVector(0, 0);
    }
  }
}
