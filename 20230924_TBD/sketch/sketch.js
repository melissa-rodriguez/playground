let shape;

function setup() {
  createCanvas(1000, 1000);
  // randomSeed(1); //horiz
  // randomSeed(3); //back diag
  // randomSeed(6); //vertical
  // randomSeed(39); //forward diag
  shape = new CornerSquare();

}

function draw() {
  background(240);

  shape.show();

  noLoop();
}

class CornerSquare {
  constructor() {
    this.pos = createVector(width / 2, height / 2);
    this.w = 200;
    this.h = 200;
    this.r = this.w / 3.5; //ellipse size

    let ellipseTypes = ["horizontal", "vertical"];
    this.ellipseType = ellipseTypes[0];

    //clockwise
    this.p1 = new squarePoint(this.pos.x - this.w / 2, this.pos.y - this.h / 2); //upper left pos
    this.p2 = new squarePoint(this.pos.x + this.w / 2, this.pos.y - this.h / 2); //upper right pos
    this.p3 = new squarePoint(this.pos.x + this.w / 2, this.pos.y + this.h / 2); //lower right pos
    this.p4 = new squarePoint(this.pos.x - this.w / 2, this.pos.y + this.h / 2); //lower left pos


    this.corners = [this.p1, this.p2, this.p3, this.p4];

    this.connectionType = "";

    //only pick two points
    let keepChecking = true;
    let point1 = this.corners[int(random(this.corners.length))];
    point1.filled = true;

    while (keepChecking) {
      let point2 = this.corners[int(random(this.corners.length))];
      if (point2.pos != point1.pos) {
        point2.filled = true;

        //valid point found!
        keepChecking = false;
      }
    }

    /* types of connections: diagonal, vertical, horizontal */
    if ((this.p1.filled && this.p3.filled)) {
      this.connectionType = "diagonal_backward";
    } else if (this.p2.filled && this.p4.filled) {
      this.connectionType = "diagonal_forward"
    } else if ((this.p1.filled && this.p4.filled) || this.p2.filled && this.p3.filled) {
      this.connectionType = "vertical";
    } else {
      this.connectionType = "horizontal";
    }
    console.log(this.connectionType);
  }

  pickFromList(list) {
    //pick an item from a list
    return list[int(random(list.length))];
  }

  show() {
    strokeWeight(10);
    stroke('red');
    noFill();
    let holeWidth = this.r * 2.5;
    let holeHeight = this.r;

    if(this.ellipseType == "horizontal"){
      this.horizontalEllipseRenders(holeWidth, holeHeight); 
    }


  }

  horizontalEllipseRenders(holeWidth, holeHeight) {
    //----ELLIPSE----
    for (let i = 0; i < this.corners.length; i++) {
      let pt = this.corners[i];
      if (pt.filled) {
        point(pt.pos.x, pt.pos.y);
        ellipse(pt.pos.x, pt.pos.y, holeWidth, holeHeight);
      }
    }

    //----CONNECTING LINES-----
    let chooseRandom = random(1);
    let arcDiameter = this.w;


    if (this.connectionType == "diagonal_backward") {

      if (chooseRandom > 0.5) {
        //go over
        line(this.p3.pos.x, this.p3.pos.y, this.p3.pos.x, this.p1.pos.y);
        arc(this.p3.pos.x - arcDiameter / 2, this.p1.pos.y, arcDiameter, arcDiameter, PI, 0);
      } else {
        //go under
        line(this.p1.pos.x, this.p1.pos.y, this.p1.pos.x, this.p3.pos.y);
        arc(this.p1.pos.x + arcDiameter / 2, this.p3.pos.y, arcDiameter, arcDiameter, 0, PI);

      }
      //determine ellipsetype
    } else if (this.connectionType == "diagonal_forward") {

      if (chooseRandom > 0.5) {
        //go over
        line(this.p4.pos.x, this.p4.pos.y, this.p4.pos.x, this.p2.pos.y);
        arc(this.p4.pos.x + arcDiameter / 2, this.p2.pos.y, arcDiameter, arcDiameter, PI, TAU);
      } else {
        //go under
        line(this.p2.pos.x, this.p2.pos.y, this.p2.pos.x, this.p4.pos.y);
        arc(this.p2.pos.x - arcDiameter / 2, this.p4.pos.y, arcDiameter, arcDiameter, 0, PI);

      }
    } else if (this.connectionType == "vertical") {
      if (this.p1.filled || this.p4.filled) {
        line(this.p1.pos.x, this.p1.pos.y, this.p4.pos.x, this.p4.pos.y);
      } else {
        line(this.p2.pos.x, this.p2.pos.y, this.p3.pos.x, this.p3.pos.y);
      }
    } else if (this.connectionType == "horizontal") {
      if (this.p1.filled || this.p2.filled) {
        if (chooseRandom > 0.5) {

          arc((this.p2.pos.x + this.p1.pos.x) / 2, this.p1.pos.y, arcDiameter, arcDiameter, PI, TAU);
        } else {

          arc((this.p2.pos.x + this.p1.pos.x) / 2, this.p1.pos.y, arcDiameter, arcDiameter, 0, PI);
        }
      } else {
        if (chooseRandom > 0.5) {
          arc((this.p4.pos.x + this.p3.pos.x) / 2, this.p4.pos.y, arcDiameter, arcDiameter, PI, TAU);
        } else {

          arc((this.p4.pos.x + this.p3.pos.x) / 2, this.p4.pos.y, arcDiameter, arcDiameter, 0, PI);
        }
      }
    }
  }
}



class squarePoint {
  constructor(x, y) {
    this.pos = createVector(x, y);
    this.filled = false;
  }
}