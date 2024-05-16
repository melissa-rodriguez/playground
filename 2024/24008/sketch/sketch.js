let colors = [];
let vehicles = [];


function setup() {
  createCanvas(1000, 1000);
  background(240);
  colors[0] = color(255, 0, 255);
  colors[1] = color(255, 255, 0);
  colors[2] = color(0, 255, 255);


  for (let i = 0; i < 100; i++) {
    for (let j = 0; j < 3; j++) {
    let theta = map(i, 0, 50, 0, TAU);
    let x = width / 2 + 200 * cos(theta);
    let y = width / 2 + 200 * sin(theta);
    let pt = createVector(x, y);
    let col = colors[j];
    // let col = color(0,0,0);
    let xoff = pt.x + random(-5, 5);
    let yoff = pt.y + random(-5, 5)
    let d = abs(dist(xoff,yoff, x, y));
    let r = map(d, 0, 20, 50, 12);
    let vehicle = new Vehicle(xoff, yoff, col, r);
    vehicles.push(vehicle);
    }
  }
}

function draw() {
  blendMode(BLEND);
  background(240);

  blendMode(MULTIPLY);
  for (let i = 0; i < vehicles.length; i++) {
    let v = vehicles[i];
    v.behaviors();
    v.update();
    v.show();
  }
}

class Vehicle {
  constructor(x, y, col_, r_) {
    this.home = createVector(x, y);
    this.pos = this.home.copy();
    this.target = createVector(x, y);
    this.vel = createVector(0, 0);
    this.acc = createVector();
    this.r = 8;
    this.originalR = r_;
    this.minR = 2;
    this.maxspeed = 10;
    this.maxforce = 1;
    this.col = col_;
    this.timeout = 0;
  }

  behaviors() {
    let mouse = createVector(mouseX, mouseY);
    this.updateRadius(mouse);
  }

  applyForce(f) {
    this.acc.add(f);
  }

  update() {
    this.pos.add(this.vel);
    this.vel.add(this.acc);
    this.acc.mult(0);
  }

  show() {
    stroke(this.col);
    strokeWeight(this.r);
    point(this.pos.x, this.pos.y);
  }

 

  updateRadius(target) {
    let d = p5.Vector.dist(this.pos, target);
    if (d < 100) {
      this.r = map(d, 0, 100, this.minR, this.originalR);
    } else {
      this.r = this.originalR;
    }
  }
}