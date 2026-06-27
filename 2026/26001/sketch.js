// 2026001
// melissa-rodriguez
// 2026-06-27

let strips = [];
let repeller;

function setup() {
  createCanvas(1000, 1000);

  let res = 5;
  let cols = width * (res / width);

  for (let j = 0; j < cols; j++) {
    let w = (width / res);
    let sw = w; //strokeweight for line
    let stripRes = 0.5; //0.1 - 1 
    // let strip = new LerpLine(w / 2 + w * j, 0, w / 2 + w * j, height, (height / 10) * stripRes, sw);
    let strip = new LerpLine(w / 2 + w * j, 200, w / 2 + w * j, height, (height / 10) * stripRes, sw);

    strips.push(strip);
  }

  repeller = new Repeller(mouseX, mouseY);


}

function draw() {
  background(240);
  // ellipse(width / 2, height / 2, 200);

  // repeller.position = createVector(width/2, height/2);
  repeller.position = createVector(mouseX, mouseY);

  repeller.show();

  for (let i = 0; i < strips.length; i++) {
    let strip = strips[i];
    strip.reset();
    strip.applyRepeller(repeller)
    strip.show();

  }

}


class Particle {
  constructor(x, y) {
    this.home = createVector(x, y); //home/original pos of particle
    this.position = createVector(x, y); //to be updated with forces/repeller
  }

  show() {
    // ellipse(this.position.x, this.position.y, 1);
    curveVertex(this.position.x, this.position.y);
  }

  debug(){
    ellipse(this.position.x, this.position.y, 1);
  }

  reset() {
    this.position.set(this.home);
  }

}

class LerpLine {
  constructor(x1_, y1_, x2_, y2_, amtPoints_, sw_) {
    this.x1 = x1_;
    this.y1 = y1_;
    this.x2 = x2_;
    this.y2 = y2_;
    this.amtPoints = amtPoints_;
    this.sw = sw_;

    this.particles = [];

    this.init();
  }

  init() {
    for (let i = 0; i <= this.amtPoints; i++) {
      let x = lerp(this.x1, this.x2, i / this.amtPoints);
      let y = lerp(this.y1, this.y2, i / this.amtPoints);
      // vertex(x, y);

      let particle = new Particle(x, y);
      this.particles.push(particle);
    }
  }

  applyRepeller() {
    for (let i = 0; i < this.particles.length; i++) {
      let particle = this.particles[i]; 
      repeller.repel(particle);

    }
  }

  reset() {
    for (let i = 0; i < this.particles.length; i++) {
      let particle = this.particles[i];
      particle.reset();
    }
  }


  show() {
    push();
    strokeWeight(this.sw);
    stroke(0, 50);
    noFill();
    beginShape();
    for (let i = 0; i <= this.particles.length - 1; i++) {
      let particle = this.particles[i];
      particle.show();
    }
    endShape();
    pop();

    for (let i = 0; i <= this.particles.length - 1; i++) {
      let particle = this.particles[i];
      particle.debug();
    }
    
  }
}

class Repeller {
  constructor(x, y) {
    this.position = createVector(x, y);
    this.radius_of_influence = 200;
    this.strength = this.radius_of_influence*.5;
  }

  repel(particle) {
    let dist = p5.Vector.dist(this.position, particle.position);
    let dir = (particle.position.x - this.position.x) / dist;

    if (dist < this.radius_of_influence) {
      let force = this.calculateFalloff(dist);
      particle.position.x += dir * force * this.strength;
    }
  }

  calculateFalloff(dist) {
    return 1 - (dist / this.radius_of_influence); //linear
  }

  show(){
    push();
    noFill();
    stroke('red');
    ellipse(this.position.x, this.position.y, this.radius_of_influence); 
    pop();
  }
}