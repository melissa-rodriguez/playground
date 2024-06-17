function setup() {
  createCanvas(1000, 1000);
}

function draw() {
  background(240);
  //origin(x,y), bottom corner
  let x = width / 2;
  let y = height / 2;
  //width and height of arc
  let w = 400;
  let h = 400;
  //rotate about corner
  let rotateAngle = 0;

  let numArcs = 4; 

  stroke(0);
  fill(0);
  strokeWeight(4);
  cutArc(x, y, w, h, rotateAngle, numArcs);



}

function cutArc(x, y, w, h, rotateAngle, numArcs) {
  push();
  translate(x, y);
  rotate(rotateAngle);
  let numPoints = 50;
  let arc1 = new LerpArc(w / 2, -h / 2, w, h, PI / 2, PI, numPoints);
  let line1 = new LerpLine(0, -h / 2, 0, 0, numPoints / 2);


  beginShape();
  line1.show();
  arc1.show();
  endShape(CLOSE);

  if (numArcs > 1) {
    beginShape();
    rotate(PI + PI / 2);
    line1.show();
    arc1.show();
    endShape();
  }

  if (numArcs > 2) {
    beginShape();
    rotate(PI);
    line1.show();
    arc1.show();
    endShape();

    beginShape();
    rotate(PI/2);
    line1.show();
    arc1.show();
    endShape();
  }

  pop();

}

class LerpArc {
  constructor(x_, y_, w_, h_, startAngle_, endAngle_, numPoints_) {
    this.x = x_;
    this.y = y_;
    this.w = w_ / 2;
    this.h = h_ / 2;
    this.startAngle = startAngle_;
    this.endAngle = endAngle_;
    this.numPoints = numPoints_;
  }

  show() {
    for (let i = 0; i <= this.numPoints; i++) {
      let theta = map(i, 0, this.numPoints, this.startAngle, this.endAngle);
      let xpos = this.x + this.w * cos(theta);
      let ypos = this.y + this.h * sin(theta);
      vertex(xpos, ypos);
    }


  }
}

class LerpLine {
  constructor(x1_, y1_, x2_, y2_, amtPoints_) {
    this.x1 = x1_;
    this.y1 = y1_;
    this.x2 = x2_;
    this.y2 = y2_;
    this.amtPoints = amtPoints_;
  }

  show() {
    for (let i = 0; i <= this.amtPoints; i++) {
      let x = lerp(this.x1, this.x2, i / this.amtPoints);
      let y = lerp(this.y1, this.y2, i / this.amtPoints);
      vertex(x, y);
    }
  }
}