let customArc;

function setup() {
  createCanvas(1000, 1000);

  let x = width / 2;
  let y = height / 2;
  let w = 400;
  let h = 400;
  let startAngle = 0;
  let endAngle = PI;
  let numPoints = 10;

  customArc = new LerpArc(x, y, w, h, startAngle, endAngle, numPoints);

}

function draw() {
  background(240);

  customArc.show();

}

class LerpArc {
  constructor(x_, y_, w_, h_, startAngle_, endAngle_, numPoints_) {
    this.x = x_;
    this.y = y_;
    this.w = w_/2;
    this.h = h_/2;
    this.startAngle = startAngle_;
    this.endAngle = endAngle_;
    this.numPoints = numPoints_;
  }

  show() {
    stroke(0);
    // line(this.x1, this.y1, this.x2, this.y2);
    noFill();
    strokeWeight(4);
    ellipse(this.x + this.w, this.y, 20, 20); 
    ellipse(this.x - this.w, this.y, 20, 20); 


    strokeWeight(10);

    for (let i = 0; i <= this.numPoints; i++) {
      // let x = lerp(this.x1, this.x2, i / this.numPoints);
      // let y = lerp(this.y1, this.y2, i / this.numPoints);

      let theta = map(i, 0, this.numPoints, this.startAngle, this.endAngle);
      let xpos = this.x + this.w * cos(theta);
      let ypos = this.y + this.h * sin(theta);
      point(xpos, ypos); 
    }

    
  }
}