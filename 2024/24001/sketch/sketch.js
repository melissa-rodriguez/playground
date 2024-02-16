let vehicles = []; 

function setup() {
  createCanvas(1000, 1000);

  let vehicle = new Vehicle(width/2, height/2); 
  vehicles.push(vehicle); 
}

function draw() {
  background(240);

  for(let i = 0; i < vehicles.length; i++){
    let v = vehicles[i]; 
    v.behaviors();
    v.update();
    v.show(); 
  }
}

class Vehicle {
  constructor(x, y) {
    this.pos = createVector(x, y/2);
    this.target = createVector(x, y); 
    this.vel = createVector();
    this.acc = createVector();

    this.r = 5; 
    this.maxSpeed = 8; 
    this.maxForce = 0.3; //strength of steering (sharp turns vs wide)

    this.trail = []; //create a line as the vehicle moves
  }

  behaviors(){
    let arrive = this.arrive(this.target);
    this.applyForce(arrive); 
  }

  applyForce(f){
    this.acc.add(f); 
  }

  update(){
    this.pos.add(this.vel); 
    this.vel.add(this.acc);
    this.acc.mult(0);  
  }

  show(){
    fill(0); 

    if(this.vel.mag() > 0.1){
    this.trail.push(this.pos.copy());
    }
    console.log(this.trail.length);
    for(let i = 0; i < this.trail.length; i++){
      let p = this.trail[i];
      ellipse(p.x, p.y, this.r/2);
    }
    ellipse(this.pos.x, this.pos.y, this.r*2);  
  }

  arrive(target){
    let desiredVel = p5.Vector.sub(target, this.pos); 
    let dist = desiredVel.mag(); 
    let speed = this.maxSpeed; 
    let slowDownRadius = 200; 
    
    if(dist < slowDownRadius){
      speed = map(dist, 0, slowDownRadius, 0, this.maxSpeed); 
    }
    desiredVel.setMag(speed); 

    let steer = p5.Vector.sub(desiredVel, this.vel); 
    steer.limit(this.maxForce); 
    return steer; 
  }

  // flee(target){
  //   let desiredVel = p5.Vector.sub(target, this.pos); 
  //   desiredVel.setMag(this.maxSpeed); 
  //   desiredVel.mult(-1); 

  //   let steer = p5.Vector.sub(desiredVel, this.vel); 
  //   steer.limit(this.maxForce); 
  //   return steer; 
  // }
}