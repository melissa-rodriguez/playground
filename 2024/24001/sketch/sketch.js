let nodes = [];

function setup() {
  createCanvas(1000, 1000);

  let cols = ['blue', 'green', 'yellow']
  for (let i = 0; i < 3; i++) {
    let strokeCol = cols[i];
    node = new Node(random(width), random(height), int(random(2, 5)), strokeCol);
    nodes.push(node);
  }
}

function draw() {
  background(0);

  for (let i = 0; i < nodes.length; i++) {
    let node = nodes[i];
    node.applyBehaviors();
    node.show();
  }

}

class Node {
  constructor(x, y, n, col) {
    this.pos = createVector(x, y);
    this.numberOfBranches = n;
    this.strokeCol = col; 

    this.vehicles = [];

    for (let i = 0; i < this.numberOfBranches; i++) {
      let wobblyFactor = int(random(0, 20));
      let vehicle = new Vehicle(this.pos.x, this.pos.y, wobblyFactor);
      this.vehicles.push(vehicle);
      this.target = createVector(random(width), random(height));
    }

    this.allVehiclesArrived = false;


  }

  applyBehaviors() {
    fill(255, 0, 0);
    noStroke();
    ellipse(this.target.x, this.target.y, 32);

    for (let i = 0; i < this.vehicles.length; i++) {
      let vehicle = this.vehicles[i];
      let wanderForce = vehicle.wander();

      if (vehicle.distance > 100) {
        vehicle.applyForce(wanderForce.mult(5));
      }


      let steering = vehicle.arrive(this.target);
      vehicle.applyForce(steering);
    }


  }

  show() {
    stroke(this.strokeCol);
    let allArrived = true; // Assume all vehicles have arrived initially
    for (let i = 0; i < this.vehicles.length; i++) {
      let vehicle = this.vehicles[i];
      vehicle.update();
      vehicle.show();

      // Check if the current vehicle has not arrived
      if (!vehicle.hasArrived) {
        allArrived = false; // Set to false if any vehicle has not arrived
      }
    }

    // Set allVehiclesArrived to true only if all vehicles have arrived
    this.allVehiclesArrived = allArrived;

    // if (this.allVehiclesArrived) {
    //   ellipse(width / 2, height / 2, 200);
    // }
  }


}


class Vehicle {
  constructor(x, y, wobble) {
    this.pos = createVector(x, y);
    this.vel = p5.Vector.random2D();
    this.acc = createVector(0, 0);
    this.maxSpeed = 5;
    this.maxForce = 0.2;
    this.r = 16;
    this.wobbleFactor = wobble; //0 = straight, 3 = shaky, 10 = curvy

    this.wanderTheta = 0;
    this.distance = 0;

    this.currentPath = [];
    this.paths = [this.currentPath];

    this.hasArrived = false;
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

    if (frameCount > 5 && this.vel.mag() < .1) {
      this.hasArrived = true; //has the vehicle arrived to the target?
    }

    force.setMag(desiredSpeed);
    force.sub(this.vel);
    force.limit(this.maxForce);
    return force;
  }

  wander(debug = false) {
    let wanderPoint = this.vel.copy();
    wanderPoint.setMag(200);
    wanderPoint.add(this.pos);

    if (debug) {
      fill(255, 0, 0);
      noStroke();
      circle(wanderPoint.x, wanderPoint.y, 8);
    }

    let wanderRadius = 100;

    if (debug) {
      noFill();
      stroke(255);
      circle(wanderPoint.x, wanderPoint.y, wanderRadius * 2);
      line(this.pos.x, this.pos.y, wanderPoint.x, wanderPoint.y);
    }

    let theta = this.wanderTheta + this.vel.heading();

    let x = wanderRadius * cos(theta);
    let y = wanderRadius * sin(theta);
    wanderPoint.add(x, y);

    if (debug) {
      fill(0, 255, 0);
      noStroke();
      circle(wanderPoint.x, wanderPoint.y, 16);


      stroke(255);
      line(this.pos.x, this.pos.y, wanderPoint.x, wanderPoint.y);
    }

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

  }

  show(debug = false) {
    // stroke(255);
    strokeWeight(2);

    if (debug) {
      fill(255);
      push();
      translate(this.pos.x, this.pos.y);
      rotate(this.vel.heading());
      triangle(-this.r, -this.r / 2, -this.r, this.r / 2, this.r, 0);
      pop();
    }

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


function intersect(x1, y1, x2, y2, x3, y3, x4, y4) {
  // Calculate the direction of the lines
  let uA = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) /
    ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1));
  let uB = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) /
    ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1));

  // If uA and uB are between 0-1, lines are intersecting
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
    // Intersection point
    let intersectionX = x1 + (uA * (x2 - x1));
    let intersectionY = y1 + (uA * (y2 - y1));
    return {
      intersects: true,
      x: intersectionX,
      y: intersectionY
    };
  }
  return {
    intersects: false
  };
}