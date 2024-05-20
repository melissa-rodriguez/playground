let shape;

function setup() {
  createCanvas(1000, 1000);
  let w = 300;
  let h = 300;
  let x = width / 2 - w / 2;
  let y = height / 2 - h / 2;

  shape = new quadShape(x, y, w, h);
}

function draw() {
  background(240);
  stroke(0);
  shape.show();

}

class quadShape {
  constructor(x, y, quadWidth, quadHeight) {
    //origin is top left corner
    this.pos = createVector(x, y);
    this.w = quadWidth;
    this.h = quadHeight;
    this.lines = [];

    this.init();
  }

  init() {
    let amtPoints = 5; //amt points for lerp line (resolution)
    this.lines.push(new LerpLine(this.pos.x, this.pos.y, this.pos.x + this.w, this.pos.y, amtPoints));
    this.lines.push(new LerpLine(this.pos.x + this.w, this.pos.y, this.pos.x + this.w, this.pos.y + this.h, amtPoints));
    this.lines.push(new LerpLine(this.pos.x + this.w, this.pos.y + this.h, this.pos.x, this.pos.y + this.h, amtPoints));
    this.lines.push(new LerpLine(this.pos.x, this.pos.y + this.h, this.pos.x, this.pos.y, amtPoints));
  }

  show() {
    for (let i = 0; i < this.lines.length; i++) {
      let lerpLine = this.lines[i];
      beginShape(POINTS);
      strokeWeight(5);
      lerpLine.show();
      endShape();
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