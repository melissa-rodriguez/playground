class Vehicle {
  PVector pos;
  PVector vel = PVector.random2D();
  PVector acc = new PVector(0, 0);
  PVector target;
  float r = 1;
  float maxSpeed = 10;
  float maxForce = 0.3;
  Vehicle(float x, float y) {
    //pos = new PVector(x,y);
    pos = new PVector(width/2,height/2);
    target = new PVector(x,y);
  }
  
  void behaviors(){
    PVector arrive = arrive(target);
    applyForce(arrive);
  }
  
  void applyForce(PVector f){
   acc.add(f); 
  }
  
  void update(){
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
  }
  
  void display(){
    //float fillmap = map(pos.y, 0, height, 255, 255);
    float n = (float) noise.eval(pos.x, pos.y);
    float fillmap = map(n, -1, 1, 150, 255);
    stroke(fillmap);
    ellipse(pos.x, pos.y, r, r);
  }
  
  PVector arrive(PVector target){
    PVector desired = PVector.sub(target, pos);
    float d = desired.mag();
    float speed = maxSpeed;
    d = map(d, 0, width, 0, 1);
    //float dEase = easeOutElastic(d);
    float dEase = easeInBack(d)*30;
    speed = dEase*maxSpeed;
    //if(d < 100){
    //  //speed = map(d, 0, 100, 0, maxSpeed);
    //  speed = pow(exp(1), (speed/.5 * -1)) * cos(speed * 200) + 1;
    //}
    desired.setMag(speed);
    PVector steer = desired.sub(vel);
    steer.limit(maxForce);
    return steer;
  }
  
  PVector seek(PVector target){
    PVector desired = PVector.sub(target, pos);
    desired.setMag(maxSpeed);
    PVector steer = desired.sub(vel);
    steer.limit(maxForce);
    return steer;
  }
}
