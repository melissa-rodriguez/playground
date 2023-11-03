ArrayList<Vehicle> vehicles; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 

  vehicles = new ArrayList<Vehicle>(); 

  int grid_w = 1080; 
  int grid_h = 1920; 
  int res = 10; 
  int cols = grid_w/res; 
  int rows = grid_h/res; 

  for (float i = 0; i <= cols; i++) {
    for (float j = 0; j <= rows; j++) {
      float x = map(i, 0, cols, 0, grid_w); 
      float y = map(j, 0, rows, 0, grid_h); 
      vehicles.add(new Vehicle(x, y));
    }
  }

  background(240);
}

void draw() {
  //clear();
  //background(240); 

  if (keyPressed) {

    if (key == 'b') {
      for (Vehicle v : vehicles) {
        v.render();  
        v.update();
        v.behaviors();
      }
    }
  }
}

class Vehicle {
  PVector pos, vel, acc; 
  PVector target; 
  float r = 1; 
  float maxSpeed = 1; 
  float maxForce = 1; 

  Vehicle(float x, float y) {
    pos = new PVector(x, y); 
    //pos = new PVector(random(width), random(height)); 
    vel = new PVector(0, 0); 
    vel = PVector.random2D(); 
    acc = new PVector(0, 0); 
    target = new PVector(x, y);
  }

  void behaviors() {
    PVector arrive = arrive(target); 
    PVector object = new PVector(mouseX, mouseY); 
    PVector flee = flee(object); 


    arrive.mult(1); 
    flee.mult(5); 

    applyForce(flee); 
    applyForce(arrive);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  PVector flee(PVector target) {
    PVector desired = PVector.sub(target, pos); 
    float d = desired.mag(); 
    desired.setMag(maxSpeed); 
    desired.mult(-1); //opposite direction 

    PVector steer = PVector.sub(desired, vel); 
    steer.limit(maxForce); 

    float fleeDiameter = 100;  //brush diameter


    if (d < fleeDiameter) {
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  PVector arrive(PVector target) {
    PVector desired = PVector.sub(target, pos); 
    float d = desired.mag(); 

    float speed = maxSpeed; 
    float thresh = 100;  //thresh hold //affects hairy texture
    if (d < thresh) {
      speed = map(d, 0, thresh, 0, maxSpeed);
    }

    //stroke(map(speed, 0, maxSpeed, 240, 0));
    if (speed > 0.1) {
      stroke(0);
    } else {
      noStroke();
    }

    desired.setMag(speed); 

    PVector steer = PVector.sub(desired, vel); 
    steer.limit(maxForce); 

    return steer;
  }

  void update() {
    pos.add(vel); 
    vel.add(acc);  
    acc.mult(0);
  }

  void render() {
    //stroke(0,20); 

    strokeWeight(r); 
    point(pos.x, pos.y);
  }
}

void mousePressed(){
 saveFrame("output.png");  
}
