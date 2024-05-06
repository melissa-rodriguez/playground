let palette = ['#134184', '#222222', '#BFA21B', '#99281B'];
let grid;

function setup() {
  createCanvas(1000, 1000);

  grid = new circleGrid(width/2, height/2, 200, 5, 2); 
}

function draw() {
  background(240);

  grid.show(); 


  noLoop();
}

class circleGrid {
  constructor(x_, y_, innerR, numCircles_, segLength) {
    this.center = createVector(x_, y_);
    this.innerRadius = innerR;
    this.numCircles = numCircles_;
    this.segmentLength = segLength;
    this.spacingBetween = 50; 

    this.circles = [];
    this.init(); 

  }

  init(){
    for (let i = 0; i <= this.numCircles; i++) {
      this.spacingBetween = int(200*sqrt(random(1)));
      let c = new Circle(width / 2, height / 2, this.innerRadius + this.spacingBetween * i);
      this.circles.push(c);
      // c.show();
  
    }
  }

  show(){
    for (let j = 0; j < this.circles.length - 1; j++) {
      let currentCircle = this.circles[j];
      let nextCircle = this.circles[j + 1];
      let segmentLength = 3;
  
      // noFill(); 
      for (let k = 0; k < currentCircle.circleVertices.length - segmentLength; k += segmentLength) {
        let currentAngle = currentCircle.circleVertices[k].angle;
        let nextAngle = nextCircle.circleVertices[k].angle;
  
        if (currentAngle == nextAngle) {
          let x1 = currentCircle.circleVertices[k].x;
          let y1 = currentCircle.circleVertices[k].y;
          let x2 = nextCircle.circleVertices[k].x;
          let y2 = nextCircle.circleVertices[k].y;
  
          let x3 = nextCircle.circleVertices[k + segmentLength].x;
          let y3 = nextCircle.circleVertices[k + segmentLength].y;
          let x4 = currentCircle.circleVertices[k + segmentLength].x;
          let y4 = currentCircle.circleVertices[k + segmentLength].y;
  
  
          beginShape();
          noFill();
          fill(palette[int(random(palette.length))]);
          stroke(240);
          strokeWeight(10);
          vertex(x1, y1);
          vertex(x2, y2);
  
          for (let between = 1; between < segmentLength - 1; between++) {
            let betx1 = nextCircle.circleVertices[k + between].x;
            let bety1 = nextCircle.circleVertices[k + between].y;
  
            let betx2 = nextCircle.circleVertices[k + between + 1].x;
            let bety2 = nextCircle.circleVertices[k + between + 1].y;
            // ellipse(betx2, bety2, 15); 
  
            vertex(betx1, bety1);
            vertex(betx2, bety2);
  
          }
  
          vertex(x3, y3);
          vertex(x4, y4);
  
  
          for (let between = segmentLength - 1; between > 0; between--) {
            let betx1 = currentCircle.circleVertices[k + between].x;
            let bety1 = currentCircle.circleVertices[k + between].y;
  
            let betx2 = currentCircle.circleVertices[k + between - 1].x;
            let bety2 = currentCircle.circleVertices[k + between - 1].y;
            // ellipse(betx2, bety2, 15); 
  
            vertex(betx1, bety1);
            vertex(betx2, bety2);
  
          }
          endShape(CLOSE)
  
  
        }
  
      }
  
  
    }
  }
}

class Circle {
  constructor(centerX, centerY, size) {
    this.center = createVector(centerX, centerY);
    this.r = size / 2;

    // this.numPoints = int(this.r / 2);
    this.numPoints = 30;

    this.circleVertices = [];
    this.saveVertices();
  }

  saveVertices() {
    for (let a = 0; a < TAU; a += TAU / this.numPoints) {
      let x = this.center.x + this.r * cos(a);
      let y = this.center.y + this.r * sin(a);

      let v = new Vertex(x, y, a);

      this.circleVertices.push(v);
    }
  }

  show(col) {
    // for (let a = 0; a < TAU; a += TAU / this.numPoints) {
    //   let x = this.center.x + this.r * cos(a);
    //   let y = this.center.y + this.r * sin(a);

    //   ellipse(x, y, 5);
    // }
    beginShape();
    noFill();
    for (let i = 0; i < this.circleVertices.length; i++) {
      let pt = this.circleVertices[i];
      // fill(map(i, 0, this.circleVertices.length, 0, 200));
      // fill(col);
      // ellipse(pt.x, pt.y, 5);
      curveVertex(pt.x, pt.y);

    }
    endShape(CLOSE);
  }
}

class Vertex {
  constructor(x_, y_, angle_) {
    this.x = x_;
    this.y = y_;
    this.angle = int(degrees(angle_));
  }
}