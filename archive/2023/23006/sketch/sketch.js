let l = [];

function setup() {
  createCanvas(1000, 1000);
  // rectMode(CENTER);
  for (let i = 0; i < 5; i++) {
    l.push(new StripedLine(width / 2 - 200, 100 + 200 * i, width / 2 + 200, 100 + 200 * i));
  }

}

function draw() {
  background(240);

  for (let i = 0; i < l.length; i++) {
    l[i].show();
  }

  noLoop();
}

class StripedLine {
  constructor(x1_, y1_, x2_, y2_) {
    this.x1 = x1_;
    this.y1 = y1_;
    this.x2 = x2_;
    this.y2 = y2_;

    this.sw_main = 100;
    this.sw_stripe = round(random(1,50));
    // this.spacing = map(this.sw_stripe, 1, 50, 10, 0);
    this.spacing = round(random(10));
  }

  show() {
    strokeWeight(1);
    noFill();
    rect(this.x1, this.y1 - this.sw_main / 2, this.x2 - this.x1, this.sw_main);

    let numLines = int((this.sw_main-this.sw_stripe) / (this.sw_stripe + this.spacing))
    // fill(0);
    // text(numLines, width/2, height/2);

    for (let i = 0; i <= numLines; i++) {
      stroke(random(200), random(200), random(200));
      strokeWeight(this.sw_stripe);
      strokeCap(SQUARE);
      line(this.x1, (this.y1 - this.sw_main / 2 + this.sw_stripe / 2) + (this.spacing + this.sw_stripe) * i, this.x2, (this.y2 - this.sw_main / 2 + this.sw_stripe / 2) + (this.spacing + this.sw_stripe) * i);
    }

  }
}