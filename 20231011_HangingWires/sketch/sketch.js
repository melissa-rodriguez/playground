let customArcs = [];

function setup() {
  createCanvas(1000, 1000);

  let x = width / 2;
  let y = height / 2;
  let w = 400;
  let h = 600;
  let startAngle = 0;
  let endAngle = PI;
  let numPoints = 50;

  for (let i = 0; i < 20; i++) {
    customArcs.push(new LerpArc(x, y, w, h, startAngle, endAngle, numPoints));
  }
}

function draw() {
  background(240);

  for (let i = 0; i < 20; i++) {
  customArcs[i].show();
  }
}

class LerpArc {
  constructor(x_, y_, w_, h_, startAngle_, endAngle_, numPoints_) {
    this.x = x_;
    this.y = y_;
    this.w = w_ / 2;
    this.h = h_ / 2 + random(-h_/5, h_/5);
    this.startAngle = startAngle_;
    this.endAngle = endAngle_;
    this.numPoints = numPoints_;
    this.phaseOffset = random(-PI / 6, PI / 6);
    // this.sw = int(random(8, 10));
    this.sw = 10;

  }

  show() {
    stroke(0);
    // line(this.x1, this.y1, this.x2, this.y2);
    noFill();
    strokeWeight(4);
    ellipse(this.x + this.w, this.y, 20, 20);
    ellipse(this.x - this.w, this.y, 20, 20);


    strokeWeight(this.sw);
    beginShape();
    for (let i = 0; i <= this.numPoints; i++) {
      // let x = lerp(this.x1, this.x2, i / this.numPoints);
      // let y = lerp(this.y1, this.y2, i / this.numPoints);

      let theta = map(i, 0, this.numPoints, this.startAngle, this.endAngle);
      let xpos = map(i, 0, this.numPoints, this.x - this.w, this.x + this.w);
      let ypos = this.y + this.h * sin(theta);
      let phase = map(ypos, this.y, this.y + this.h, 0, this.phaseOffset);
      theta += phase;
      ypos = this.y + this.h * sin(theta);
      

      curveVertex(xpos, ypos);
    }
    endShape(OPEN);


  }
}