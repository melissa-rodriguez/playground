let shape;

function setup() {
  createCanvas(1000, 1000);

  shape = new CornerSquare();
}

function draw() {
  background(240);

  shape.show();
}

class CornerSquare {
  constructor() {
    this.pos = createVector(width / 2, height / 2);
    this.w = 200;
    this.h = 200;
    this.r = this.w / 3.5; //ellipse size

    //clockwise
    this.p1 = new squarePoint(this.pos.x - this.w / 2, this.pos.y - this.h / 2); //upper left pos
    this.p2 = new squarePoint(this.pos.x + this.w / 2, this.pos.y - this.h / 2); //upper right pos
    this.p3 = new squarePoint(this.pos.x + this.w / 2, this.pos.y + this.h / 2); //lower right pos
    this.p4 = new squarePoint(this.pos.x - this.w / 2, this.pos.y + this.h / 2); //lower left pos


    this.corners = [this.p1, this.p2, this.p3, this.p4];

    this.ellipseType = ["horizontal", "vertical"];

    //only pick two points
    let keepChecking = true; 
    let point1 = this.corners[int(random(this.corners.length))];
    point1.filled = true; 

    while (keepChecking) {
      let point2 = this.corners[int(random(this.corners.length))];
      if(point2.pos != point1.pos){
        point2.filled = true; 

        //valid point found!
        keepChecking = false; 
      }
    }
  }

  pickFromList(list) {
    //pick an item from a list
    return list[int(random(list.length))];
  }

  show() {
    strokeWeight(10);
    stroke('red');
    for (let i = 0; i < this.corners.length; i++) {
      let pt = this.corners[i];
      if (pt.filled) {
        point(pt.pos.x, pt.pos.y);
        ellipse(pt.pos.x, pt.pos.y, this.r * 2.5, this.r);
      }
    }

    //determine ellipsetype
  }
}

class squarePoint {
  constructor(x, y) {
    this.pos = createVector(x, y);
    this.filled = false;
  }
}