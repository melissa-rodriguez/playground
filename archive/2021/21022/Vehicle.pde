class Vehicle {
  PVector pos;
  PVector vel = PVector.random2D();
  PVector acc = new PVector(0, 0);
  PVector target;
  float r;
  float maxSpeed = 10;
  float maxForce = 0.3;
  float bright;
  //float red, green, blue;
  Vehicle(float x, float y, float radius, float red, float green, float blue) {
    pos = new PVector(x, y);
    //pos = new PVector(random(width), random(height));
    target = new PVector(x, y);
    //target = new PVector(x-100, y);
    r = radius;
    red = red;
    green = green;
    blue = blue;
  }

  void behaviors() {
    PVector arrive = arrive(target);

    PVector mouse = new PVector(mouseX, mouseY);
    PVector flee = flee(mouse);


    flee.mult(6);
    arrive.mult(1);

    applyForce(arrive);
    //if (mousePressed) {
      applyForce(flee);
    //}
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  void update() {
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
  }

  void display() {
    fill(255);
    //fill(red+255,green+255,blue);
    //float diameter = map(r, 0, 1, 0, 10);
    ellipse(pos.x, pos.y, r, r);
  }

  PVector arrive(PVector target) {
    PVector desired = PVector.sub(target, pos);
    float d = desired.mag();
    float speed = maxSpeed;
    //d = map(d, 0, width, 0, 1);
    //float dEase = easeOutElastic(d);
    //float dEase = easeInBack(d)*30;
    //speed = dEase*maxSpeed;
    speed = maxSpeed;
    if (d < 100) {
      speed = map(d, 0, 100, 0, maxSpeed);
      //speed = pow(exp(1), (speed/.5 * -1)) * cos(speed * 200) + 1;
    }
    desired.setMag(speed);
    PVector steer = desired.sub(vel);
    steer.limit(maxForce);
    return steer;
  }

  PVector flee(PVector target) {
    PVector desired = PVector.sub(target, pos);
    float d = desired.mag();  
    if (d<25) {
      desired.setMag(maxSpeed);
      desired.mult(-1);
      PVector steer = desired.sub(vel);
      steer.limit(maxForce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }
}
