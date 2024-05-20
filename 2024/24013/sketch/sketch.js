let shape;
let fillShape; 
let seed;

function setup() {
  createCanvas(1000, 1000);
  let w = 300;
  let h = 300;
  let x = width / 2 - w / 2;
  let y = height / 2 - h / 2;
  let fillColl1 = color(240, 240, 240); 
  let fillColl2 = color(0, 0, 240); 
  shape = new quadShape(x, y, w, h, fillColl1);
  fillShape = new quadShape(x, y, w, h, fillColl2);
}

function draw() {
  background(240);
  stroke(0);

  seed = 1234; //shape and fill shape have different seeds (for noise) so they dont overlap
  shape.show();

  seed = 100;
  fillShape.show();
}

class quadShape {
  constructor(x, y, quadWidth, quadHeight, col) {
    //origin is top left corner
    this.pos = createVector(x, y);
    this.w = quadWidth;
    this.h = quadHeight;
    this.fillCol = col; 
    this.lines = [];

    this.init();
  }

  init() {
    let amtPoints = 50; //amt points for lerp line (resolution)
    this.lines.push(new LerpLine(this.pos.x, this.pos.y, this.pos.x + this.w, this.pos.y, amtPoints));
    this.lines.push(new LerpLine(this.pos.x + this.w, this.pos.y, this.pos.x + this.w, this.pos.y + this.h, amtPoints));
    this.lines.push(new LerpLine(this.pos.x + this.w, this.pos.y + this.h, this.pos.x, this.pos.y + this.h, amtPoints));
    this.lines.push(new LerpLine(this.pos.x, this.pos.y + this.h, this.pos.x, this.pos.y, amtPoints));
  }

  show() {
    beginShape();
    for (let i = 0; i < this.lines.length; i++) {
      let lerpLine = this.lines[i];
      // noFill();
      fill(this.fillCol);
      strokeWeight(5);
      lerpLine.show();
    }
    endShape(CLOSE);

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
    let noiseMax = 0.3;
    for (let i = 0; i <= this.amtPoints; i++) {
      let a = map(i, 0, this.amtPoints, 0, TAU);
      let xoff = map(cos(a), -1, 1, 0, noiseMax);
      let yoff = map(sin(a), -1, 1, 0, noiseMax);
      let n = noise(xoff + seed, yoff + seed); //edit seeds --------------
      let xMaxDisp = 50;
      let yMaxDisp = 50;

      let dx = map(n, 0, 1, -xMaxDisp, xMaxDisp);
      let dy = map(n, 0, 1, -yMaxDisp, yMaxDisp);

      let x = lerp(this.x1, this.x2, i / this.amtPoints) + dx;
      let y = lerp(this.y1, this.y2, i / this.amtPoints) + dy;
      curveVertex(x, y);
    }
  }
}