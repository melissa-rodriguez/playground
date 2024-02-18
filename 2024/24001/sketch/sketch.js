let vehicle;

function setup() {
  createCanvas(1000, 1000);
  vehicle = new Vehicle(100, 100);
}

function draw() {
  background(0);

  // vehicle.wander();
  let target = createVector(width/2, height/2);
  fill(255, 0, 0);
  noStroke();
  ellipse(target.x, target.y, 32);

  let wanderForce = vehicle.wander();

  if (vehicle.distance > 100) {
    vehicle.applyForce(wanderForce.mult(5));
  }

  let steering = vehicle.arrive(target);
  vehicle.applyForce(steering);

  vehicle.update();
  vehicle.show();

}


class Vehicle {
  constructor(x, y) {
    this.pos = createVector(x, y);
    this.vel = createVector(1, 0);
    this.acc = createVector(0, 0);
    this.maxSpeed = 5;
    this.maxForce = 0.2;
    this.r = 16;
    this.wobbleFactor = 5; //0 = straight, 3 = shaky, 10 = curvy

    this.wanderTheta = 0;
    this.distance = 0;

    this.currentPath = [];
    this.paths = [this.currentPath];
  }



  evade(vehicle) {
    let pursuit = this.pursue(vehicle);
    pursuit.mult(-1);
    return pursuit;
  }

  pursue(vehicle) {
    let target = vehicle.pos.copy();
    let prediction = vehicle.vel.copy();
    prediction.mult(10);
    target.add(prediction);
    fill(0, 255, 0);
    circle(target.x, target.y, 16);
    return this.seek(target);
  }

  arrive(target) {
    // 2nd argument true enables the arrival behavior
    return this.seek(target, true);
  }

  flee(target) {
    return this.seek(target).mult(-1);
  }

  seek(target, arrival = false) {


    let force = p5.Vector.sub(target, this.pos);
    let desiredSpeed = this.maxSpeed;
    if (arrival) {
      let slowRadius = 100;
      this.distance = force.mag();
      if (this.distance < slowRadius) {
        desiredSpeed = map(this.distance, 0, slowRadius, 0, this.maxSpeed);
      }
    }
    force.setMag(desiredSpeed);
    force.sub(this.vel);
    force.limit(this.maxForce);
    return force;
  }

  wander() {
    let wanderPoint = this.vel.copy();
    wanderPoint.setMag(200);
    wanderPoint.add(this.pos);
    fill(255, 0, 0);
    noStroke();
    circle(wanderPoint.x, wanderPoint.y, 8);

    let wanderRadius = 100;
    noFill();
    stroke(255);
    circle(wanderPoint.x, wanderPoint.y, wanderRadius * 2);
    line(this.pos.x, this.pos.y, wanderPoint.x, wanderPoint.y);

    let theta = this.wanderTheta + this.vel.heading();

    let x = wanderRadius * cos(theta);
    let y = wanderRadius * sin(theta);
    wanderPoint.add(x, y);
    fill(0, 255, 0);
    noStroke();
    circle(wanderPoint.x, wanderPoint.y, 16);

    stroke(255);
    line(this.pos.x, this.pos.y, wanderPoint.x, wanderPoint.y);

    let steer = wanderPoint.sub(this.pos);
    steer.setMag(this.maxForce);

    // this.applyForce(steer);

    let displaceRange = radians(360);

    if (frameCount % this.wobbleFactor == 0) {
      this.wanderTheta += random(-displaceRange, displaceRange);
    }

    return steer;

  }

  applyForce(force) {
    this.acc.add(force);
  }

  update() {
    this.vel.add(this.acc);
    this.vel.limit(this.maxSpeed);
    this.pos.add(this.vel);
    this.acc.set(0, 0);

    if (this.vel.mag() > 0.1) {
      this.currentPath.push(this.pos.copy());
    }

    console.log(this.currentPath.length);
  }

  show() {
    stroke(255);
    strokeWeight(2);
    fill(255);
    push();
    translate(this.pos.x, this.pos.y);
    rotate(this.vel.heading());
    triangle(-this.r, -this.r / 2, -this.r, this.r / 2, this.r, 0);
    pop();

    for (let path of this.paths) {
      beginShape();
      noFill();
      for (let v of path) {
        vertex(v.x, v.y);
      }
      endShape();
    }
  }

  edges() {
    let hitEdge = false;
    if (this.pos.x > width + this.r) {
      this.pos.x = -this.r;
      hitEdge = true;
    } else if (this.pos.x < -this.r) {
      this.pos.x = width + this.r;
      hitEdge = true;
    }
    if (this.pos.y > height + this.r) {
      this.pos.y = -this.r;
      hitEdge = true;
    } else if (this.pos.y < -this.r) {
      this.pos.y = height + this.r;
      hitEdge = true;
    }

    if (hitEdge) {
      this.currentPath = [];
      this.paths.push(this.currentPath);
    }
  }
}

class Target extends Vehicle {
  constructor(x, y) {
    super(x, y);
    this.vel = p5.Vector.random2D();
    this.vel.mult(5);
  }

  show() {
    stroke(255);
    strokeWeight(2);
    fill("#F063A4");
    push();
    translate(this.pos.x, this.pos.y);
    circle(0, 0, this.r * 2);
    pop();
  }
}