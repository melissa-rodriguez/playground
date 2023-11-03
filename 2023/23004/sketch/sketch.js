let palette = ['#134184', '#222222', '#BFA21B', '#99281B'];
let grid;

function setup() {
  createCanvas(2000, 2000);

  grid = new circleGrid(width / 2, height / 2, 200, 10, 4);
}

function draw() {
  background(240);

  grid.show();
  // grid.customShapes[int(random(grid.customShapes.length))].show();

  for (let i = 0; i < grid.customShapes.length; i++) {
    let rand = sqrt(random(1));
    let scribble, solidFill; 

    if (rand >= 0.5) {
      scribble = true; 
      solidFill = false; 
      grid.customShapes[i].show(solidFill, scribble);
    }else{
      scribble = false; 
      solidFill = true; 
      grid.customShapes[i].show(solidFill, scribble)
    }
  }
  // console.log(grid.customShapes); 

  noLoop();
}

class circleGrid {
  constructor(x_, y_, innerR, numCircles_, segLength) {
    this.center = createVector(x_, y_);
    this.innerRadius = innerR;
    this.numCircles = numCircles_;
    this.segmentLength = segLength;
    this.spacingBetween = 100;

    this.circles = [];
    this.init();

    this.customShapes = [];

  }

  init() {
    for (let i = 0; i <= this.numCircles; i++) {
      // this.spacingBetween = int(200 * sqrt(random(1)));
      let c = new Circle(width / 2, height / 2, this.innerRadius + this.spacingBetween * i);
      this.circles.push(c);
      // c.show();

    }
  }

  show() {
    for (let j = 0; j < this.circles.length - 1; j++) {
      let currentCircle = this.circles[j];
      let nextCircle = this.circles[j + 1];
      // let segmentLength = int(random(1, this.segmentLength));
      let segmentLength = this.segmentLength;
      // noFill(); 
      for (let k = 0; k < currentCircle.circleVertices.length - segmentLength; k += segmentLength) {
        let currentAngle = currentCircle.circleVertices[k].angle;
        let nextAngle = nextCircle.circleVertices[k].angle;

        let shapeVertices = [];

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
          noFill();
          // // fill(palette[int(random(palette.length))]);
          stroke(240);
          
          // // stroke(palette[int(random(palette.length))]);
          // strokeWeight(5);

          vertex(x1, y1);
          vertex(x2, y2);

          // shapeVertices.push(createVector(x1, y1));
          // shapeVertices.push(createVector(x2, y2));

          shapeVertices.push(currentCircle.circleVertices[k]);
          shapeVertices.push(nextCircle.circleVertices[k]);



          for (let between = 1; between < segmentLength - 1; between++) {
            let betx1 = nextCircle.circleVertices[k + between].x;
            let bety1 = nextCircle.circleVertices[k + between].y;

            let betx2 = nextCircle.circleVertices[k + between + 1].x;
            let bety2 = nextCircle.circleVertices[k + between + 1].y;
            // ellipse(betx2, bety2, 15); 

            vertex(betx1, bety1);
            vertex(betx2, bety2);

            // shapeVertices.push(createVector(betx1, bety1));
            // shapeVertices.push(createVector(betx2, bety2));

            shapeVertices.push(nextCircle.circleVertices[k + between]);
            shapeVertices.push(nextCircle.circleVertices[k + between + 1]);

          }

          vertex(x3, y3);
          vertex(x4, y4);

          // shapeVertices.push(createVector(x3, y3));
          // shapeVertices.push(createVector(x4, y4));

          shapeVertices.push(nextCircle.circleVertices[k + segmentLength]);
          shapeVertices.push(currentCircle.circleVertices[k + segmentLength]);


          for (let between = segmentLength - 1; between > 0; between--) {
            let betx1 = currentCircle.circleVertices[k + between].x;
            let bety1 = currentCircle.circleVertices[k + between].y;

            let betx2 = currentCircle.circleVertices[k + between - 1].x;
            let bety2 = currentCircle.circleVertices[k + between - 1].y;
            // ellipse(betx2, bety2, 15); 

            vertex(betx1, bety1);
            vertex(betx2, bety2);

            // shapeVertices.push(createVector(betx1, bety1));
            // shapeVertices.push(createVector(betx2, bety2));

            shapeVertices.push(currentCircle.circleVertices[k + between]);
            shapeVertices.push(currentCircle.circleVertices[k + between - 1]);


          }
          endShape(CLOSE);

          this.customShapes.push(new customShape(shapeVertices));
        }

      }

    }
  }
}

class customShape {
  constructor(shapeVertices) {
    this.vertices = shapeVertices; // array of 4 vertices to connect
  }

  show(solidFill, scribble) {

    if (solidFill) {
      beginShape();
      fill(0);
      stroke(240);
      for (let i = 0; i < this.vertices.length; i++) {
        let v = this.vertices[i];

        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    }

    let v1 = this.vertices[0];
    let v2 = this.vertices[1];
    let v3 = this.vertices[2];
    let v4 = this.vertices[int((this.vertices.length - 1) / 2)];

    if (scribble) {
      beginShape();
      noFill();
      for (let j = 0; j < this.vertices.length * 2; j++) {
        let randV1 = this.vertices[int((this.vertices.length) * sqrt(random(1)))];
        let randV2 = this.vertices[int((this.vertices.length) * sqrt(random(1)))];
        stroke(0);
        strokeWeight(map(j, 0, this.vertices.length, 0.05, 0.3));
        // line(randV1.x, randV1.y, randV2.x, randV2.y);
        curveVertex(randV1.x, randV1.y);
        curveVertex(randV2.x, randV2.y);
      }
      endShape();
    }
  }
}

class Circle {
  constructor(centerX, centerY, size) {
    this.center = createVector(centerX, centerY);
    this.r = size / 2;

    // this.numPoints = int(this.r / 2);
    this.numPoints = 50; //resolution (how many divisons there are)

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