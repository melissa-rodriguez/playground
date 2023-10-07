let customLine;

function setup() {
  createCanvas(1000, 1000);
  customLine = new LerpLine(200, height / 2, width - 200, height / 2, 10);

}

function draw() {
  background(240);

  customLine.show();

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
    stroke(0);
    // line(this.x1, this.y1, this.x2, this.y2);
    noFill();
    strokeWeight(0.5);
    ellipse(this.x1, this.y1, 20); 
    ellipse(this.x2, this.y2, 20); 


    strokeWeight(4);

    for (let i = 0; i <= this.amtPoints; i++) {
      let x = lerp(this.x1, this.x2, i / this.amtPoints);
      let y = lerp(this.y1, this.y2, i / this.amtPoints);
      point(x, y);
    }
  }
}