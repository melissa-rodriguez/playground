let brushes = [];

function setup() {
  createCanvas(1000, 1000);
  colorMode(HSB);

  let pos = createVector(width / 2, height / 2);
}


function draw() {
  // background(240, 5, 80);
  background(0, 0, 95);
  fill(0);
  for (let theta = 0; theta < TAU; theta += radians(20)) {
    let xoff = map(theta, 0, TAU, -300, 300);
    let x = width / 2 + xoff;

    let y = height / 2 + 100 * sin(3 * theta);

    let pos = createVector(x, y);
    let brush = new Brush(pos, 100, 1, 3, color(0, 0, 0));
    // ellipse(x,y,2);
    brushes.push(brush); 

  }

  for(let i = 0; i < brushes.length; i++){
    let b = brushes[i]; 
    let theta = map(i, 0, brushes.length/2, 0, TAU); 
    push();
    translate(b.pos.x, b.pos.y);
    rotate(theta); 
    b.show();
    pop();
  }
  // brush.show();
  noLoop();

}

class Brush {
  constructor(pos_, size_, w_, h_, col_) {
    this.pos = pos_;
    this.size = size_;
    this.scaleWidth = w_;
    this.scaleHeight = h_;
    this.col = col_;
    this.points = [];

    this.createBrush();
  }

  createBrush() {
    let radius = this.size;
    let noiseMax = .5;
    let rMax = radius;
    let rMin = -rMax / 5;
    let amt = 50;
    for (let i = 0; i < amt; i++) {

      for (let a = radians(1); a <= TAU * 2; a += radians(4)) {
        let xoff = map(cos(a), -1, 1, 0, noiseMax);
        let yoff = map(sin(a), -1, 1, 0, noiseMax);
        // let r = width / 2;
        let n = noise(xoff + i * 12345, yoff + i * 12345);
        let r = map(n, 0, 1, rMin, rMax);
        let transX = map(noise(xoff + a * random(12345), yoff + a * random(12345)), 0, 1, -100, 100);
        let transY = map(noise(xoff + a * random(12345), yoff + a * random(12345)), 0, 1, -100, 100);
        let x = 0 + transX + r * this.scaleWidth * cos(a);
        let y = 0 + transY + r * this.scaleHeight * sin(a);
        noFill();
        // curveVertex(x, y);
        this.points.push(createVector(x, y));
      }

    }
  }

  show() {
    let col = color(random(240,340), 100, 100);

    for (let i = 0; i < this.points.length - 3; i++) {
      // stroke(0);
      if (random(1) < 0.7) {
        stroke(hue(col), saturation(col), brightness(col), .05);
      } else {
        stroke(0, 0, 75 + random(0, 100), .05);
      }

      beginShape();
      let pt = this.points[i];
      let pt2 = this.points[i + 1];
      let pt3 = this.points[i + 2];
      let pt4 = this.points[i + 3];

      curveVertex(pt.x, pt.y);
      curveVertex(pt2.x, pt2.y);
      curveVertex(pt3.x, pt3.y);
      curveVertex(pt4.x, pt4.y);
      endShape();

    }

  }
}