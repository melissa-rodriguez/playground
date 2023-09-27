let shapes = [];
// let shape;
function setup() {
  createCanvas(1000, 1000);
  // randomSeed(1); //horiz
  // randomSeed(3); //back diag
  // randomSeed(6); //vertical
  // randomSeed(39); //forward diag
  // shape = new CornerSquare(width/2, height/2, 100, 100);

  let cols = 4;
  let rows = 4;
  let spacing = 150;

  let boxW = (width - cols * spacing) / cols;
  let boxH = (height - rows * spacing) / rows;
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      let xpos = (boxW + spacing) / 2 + (boxW + spacing) * i;
      let ypos = (boxH + spacing) / 2 + (boxH + spacing) * j;
      // rect(xpos, ypos, boxW, boxH);
      let shape = new CornerSquare(xpos, ypos, boxW, boxH);
      shapes.push(shape);
    }
  }



}

function draw() {
  background(240);
  for (let i = 0; i < shapes.length; i++) {
    let shape = shapes[i];
    shape.show();
  }

  // shape.show();



  noLoop();
}

class CornerSquare {
  constructor(x, y, w_, h_) {
    // this.pos = createVector(width / 2, height / 2);
    this.pos = createVector(x, y);
    this.w = w_;
    this.h = h_;
    this.r = this.w / 3.5; //ellipse size

    let ellipseTypes = ["horizontal", "vertical"];
    this.ellipseType = ellipseTypes[round(random(1))];

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
  }

  pickFromList(list) {
    //pick an item from a list
    return list[int(random(list.length))];
  }

  show() {
    strokeWeight(20);
    strokeCap(SQUARE);
    // stroke('red');
    // noFill();


    if (this.ellipseType == "horizontal") {
      let holeWidth = this.r * 2.5;
      let holeHeight = this.r;
      this.horizontalRender(holeWidth, holeHeight);
    } else if (this.ellipseType == "vertical") {
      let holeWidth = this.r;
      let holeHeight = this.r * 2.5;
      if (this.connectionType != "diagonal_forward" && this.connectionType != "diagonal_backward") {
        this.verticalRender(holeWidth, holeHeight);
      }
    }


  }

  verticalRender(holeWidth, holeHeight) {
    //----ELLIPSE----
    noStroke();
    fill(0);
    for (let i = 0; i < this.corners.length; i++) {
      let pt = this.corners[i];
      if (pt.filled) {
        ellipse(pt.pos.x, pt.pos.y, holeWidth, holeHeight);
      }
    }

    //-----CONNECTING LINES-----
    stroke('red');
    noFill();
    let arcDiameter = this.w;
    let chooseRandom = random(1);

    if (this.connectionType == "vertical") {
      if (this.p1.filled || this.p4.filled) {
        if (chooseRandom > 0.5) {
          //right
          arc(this.p1.pos.x - holeWidth/2, (this.p1.pos.y + this.p4.pos.y) / 2, arcDiameter, arcDiameter, PI + PI / 2, TAU + PI / 2);
        } else {
          //left
          arc(this.p1.pos.x + holeWidth/2, (this.p1.pos.y + this.p4.pos.y) / 2, arcDiameter, arcDiameter, PI / 2, PI + PI / 2);
        }
      } else {
        if (chooseRandom > 0.5) {
          //right
          arc(this.p2.pos.x - holeWidth/2, (this.p2.pos.y + this.p3.pos.y) / 2, arcDiameter, arcDiameter, PI + PI / 2, TAU + PI / 2);
        } else {
          //left
          arc(this.p2.pos.x + holeWidth/2, (this.p2.pos.y + this.p3.pos.y) / 2, arcDiameter, arcDiameter, PI / 2, PI + PI / 2);
        }
      }
    } else if (this.connectionType == "horizontal") {
      if (this.p1.filled || this.p2.filled) {
        line(this.p1.pos.x - holeWidth/2, this.p1.pos.y, this.p2.pos.x + holeWidth/2, this.p2.pos.y);
      } else {
        line(this.p4.pos.x - holeWidth/2, this.p4.pos.y, this.p3.pos.x + holeWidth/2, this.p3.pos.y);
      }
    }
  }

  horizontalRender(holeWidth, holeHeight) {
    //----ELLIPSE----
    noStroke();
    fill(0);
    for (let i = 0; i < this.corners.length; i++) {
      let pt = this.corners[i];
      if (pt.filled) {
        ellipse(pt.pos.x, pt.pos.y, holeWidth, holeHeight);
      }
    }

    //----CONNECTING LINES-----
    stroke('red');
    noFill();
    let chooseRandom = random(1);
    let arcDiameter = this.w;


    if (this.connectionType == "diagonal_backward") {

      if (chooseRandom > 0.5) {
        //go over
        line(this.p3.pos.x, this.p3.pos.y + holeHeight/2, this.p3.pos.x, this.p1.pos.y + holeHeight/2);
        arc(this.p3.pos.x - arcDiameter / 2, this.p1.pos.y + holeHeight/2, arcDiameter, arcDiameter, PI, 0);
      } else {
        //go under
        line(this.p1.pos.x, this.p1.pos.y - holeHeight/2, this.p1.pos.x, this.p3.pos.y - holeHeight/2);
        arc(this.p1.pos.x + arcDiameter / 2, this.p3.pos.y - holeHeight/2, arcDiameter, arcDiameter, 0, PI);

      }
      //determine ellipsetype
    } else if (this.connectionType == "diagonal_forward") {

      if (chooseRandom > 0.5) {
        //go over
        line(this.p4.pos.x, this.p4.pos.y + holeHeight/2, this.p4.pos.x, this.p2.pos.y + holeHeight/2);
        arc(this.p4.pos.x + arcDiameter / 2, this.p2.pos.y + holeHeight/2, arcDiameter, arcDiameter, PI, TAU);
      } else {
        //go under
        line(this.p2.pos.x, this.p2.pos.y - holeHeight/2, this.p2.pos.x, this.p4.pos.y - holeHeight/2);
        arc(this.p2.pos.x - arcDiameter / 2, this.p4.pos.y - holeHeight/2, arcDiameter, arcDiameter, 0, PI);

      }
    } else if (this.connectionType == "vertical") {
      if (this.p1.filled || this.p4.filled) {
        line(this.p1.pos.x, this.p1.pos.y - holeHeight/2, this.p4.pos.x, this.p4.pos.y + holeHeight/2);
      } else {
        line(this.p2.pos.x, this.p2.pos.y - holeHeight/2, this.p3.pos.x, this.p3.pos.y + holeHeight/2);
      }
    } else if (this.connectionType == "horizontal") {
      if (this.p1.filled || this.p2.filled) {
        if (chooseRandom > 0.5) {

          arc((this.p2.pos.x + this.p1.pos.x) / 2, this.p1.pos.y + holeHeight/2, arcDiameter, arcDiameter, PI, TAU);
        } else {

          arc((this.p2.pos.x + this.p1.pos.x) / 2, this.p1.pos.y - holeHeight/2, arcDiameter, arcDiameter, 0, PI);
        }
      } else {
        if (chooseRandom > 0.5) {
          arc((this.p4.pos.x + this.p3.pos.x) / 2, this.p4.pos.y + holeHeight/2, arcDiameter, arcDiameter, PI, TAU);
        } else {

          arc((this.p4.pos.x + this.p3.pos.x) / 2, this.p4.pos.y - holeHeight/2, arcDiameter, arcDiameter, 0, PI);
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