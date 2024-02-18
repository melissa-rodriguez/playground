let padding = 0.1;
let upper_Left, lower_Left, upper_Right, lower_Right;
let nodes = [];


function setup() {
  createCanvas(1000, 1000);

  let rightEdge = (width - width * padding);
  let leftEdge = (width * padding);
  let bottomEdge = (height - height * padding);
  let topEdge = (height * padding);

  upper_Left = createVector(leftEdge, topEdge);
  lower_Left = createVector(leftEdge, bottomEdge);
  upper_Right = createVector(rightEdge, topEdge);
  lower_Right = createVector(rightEdge, bottomEdge);

  let corners = [upper_Left, lower_Left, upper_Right, lower_Right];

  let cols = ['blue', 'green', 'yellow']
  for (let i = 0; i < 3; i++) {
    let strokeCol = cols[i];
    let startPt = corners[int(random(corners.length))];

     // Choose a target that is not the same as the startPt
     let targetIndex = int(random(corners.length - 1));
     if (corners[targetIndex].equals(startPt)) {
       targetIndex = (targetIndex + 1) % corners.length;
     }
     let target = corners[targetIndex];
     
    let numBranches = int(random(1, 3));

    node = new Node(startPt, target, numBranches, strokeCol);
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

  // Check for intersections if all vehicles have arrived at their targets
  let allVehiclesArrived = nodes.every(node => node.allVehiclesArrived);
  if (allVehiclesArrived) {
    let intersectionPoints = []; // Store intersection points

    // Loop through each node
    for (let i = 0; i < nodes.length; i++) {
      let node = nodes[i];

      // Loop through each vehicle's path in the node
      for (let j = 0; j < node.vehicles.length; j++) {
        let vehicle = node.vehicles[j];

        // Loop through other nodes to check intersections
        for (let k = i + 1; k < nodes.length; k++) {
          let otherNode = nodes[k];

          // Loop through other node's vehicles' paths
          for (let l = 0; l < otherNode.vehicles.length; l++) {
            let otherVehicle = otherNode.vehicles[l];

            // Check for intersection between current vehicle path and other vehicle path
            for (let m = 0; m < vehicle.paths.length; m++) {
              for (let n = 0; n < otherVehicle.paths.length; n++) {
                let intersection = findIntersection(vehicle.paths[m], otherVehicle.paths[n]);
                if (intersection !== null) {
                  // Check if intersection is within 25 pixels of another stored intersection point
                  let tooClose = false;
                  for (let p = 0; p < intersectionPoints.length; p++) {
                    let distSq = (intersection.x - intersectionPoints[p].x) ** 2 + (intersection.y - intersectionPoints[p].y) ** 2;
                    if (distSq < 25 ** 2) {
                      tooClose = true;
                      break;
                    }
                  }
                  if (!tooClose) {
                    intersectionPoints.push(intersection);
                  }
                }
              }
            }
          }
        }
      }
    }

    push();
    // Display intersection points
    fill(255, 0, 0);
    stroke(255); 
    for (let i = 0; i < intersectionPoints.length; i++) {
      ellipse(intersectionPoints[i].x, intersectionPoints[i].y, 10);
    }
    pop();
  }


  push();
  noFill();
  stroke(255);
  rectMode(CORNERS);
  rect(upper_Left.x, upper_Left.y, lower_Right.x, lower_Right.y);
  pop();

}

class Node {
  constructor(origin, target_, n, col) {
    this.pos = origin;
    this.numberOfBranches = n;
    this.strokeCol = col;

    this.vehicles = [];

    for (let i = 0; i < this.numberOfBranches; i++) {
      let wobblyFactor = int(random(0, 5));
      let vehicle = new Vehicle(this.pos.x, this.pos.y, wobblyFactor);
      this.vehicles.push(vehicle);
      this.target = target_;
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
    strokeWeight(4);
    let allArrived = true; // Assume all vehicles have arrived initially
    for (let i = 0; i < this.vehicles.length; i++) {
      let vehicle = this.vehicles[i];
      vehicle.update();
      vehicle.show();
      vehicle.edges();

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
    let avoidanceRadius = 200; // Distance at which vehicles start avoiding the edges
    let desired = null;

    // Check if the vehicle is within the avoidance radius of any edge
    if (this.pos.x < avoidanceRadius) {
      desired = createVector(this.maxSpeed, this.vel.y); // Move right
    } else if (this.pos.x > width - avoidanceRadius) {
      desired = createVector(-this.maxSpeed, this.vel.y); // Move left
    }

    if (this.pos.y < avoidanceRadius) {
      desired = createVector(this.vel.x, this.maxSpeed); // Move down
    } else if (this.pos.y > height - avoidanceRadius) {
      desired = createVector(this.vel.x, -this.maxSpeed); // Move up
    }

    // If desired velocity is set, steer towards it to avoid the edge
    if (desired !== null) {
      desired.normalize();
      desired.mult(this.maxSpeed);
      let steer = p5.Vector.sub(desired, this.vel);
      steer.limit(this.maxForce);
      this.applyForce(steer);
    }

  }
}

function findIntersection(path1, path2) {
  for (let i = 0; i < path1.length - 1; i++) {
    for (let j = 0; j < path2.length - 1; j++) {
      let intersection = intersect(path1[i].x, path1[i].y, path1[i + 1].x, path1[i + 1].y, path2[j].x, path2[j].y, path2[j + 1].x, path2[j + 1].y);
      if (intersection.intersects) {
        return createVector(intersection.x, intersection.y);
      }
    }
  }
  return null;
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