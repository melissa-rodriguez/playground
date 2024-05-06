//COOL TEXTURE OVERLAY

let grid;
let lineTypes = ["horizontal", "vertical"]

function setup() {
  createCanvas(1000, 1000);

  grid = new Grid(createVector(0, 0), 100, 1000);
}

function draw() {
  background(240);
  ellipse(width / 2, height / 2, 200);

  // grid.showGrid();
  let segments = random(3, grid.res/1.5); // line length

  for (let i = 0; i < 5; i++) {
    let type = lineTypes[int(random(lineTypes.length))];
    // let segments = random(2, grid.res / 2); // line length
    grid.insertLine(type, segments);
  }

  // console.log(grid.lines);
  for (let j = 0; j < grid.lines.length; j++) {
    //go thru each line and connect each point to each line
    let currentLine = grid.lines[j];
    for (let z = 0; z < grid.lines.length; z++) {
      let nextLine = grid.lines[z];


      let shortestLine = currentLine;

      if (nextLine.length < currentLine.length) {
        shortestLine = nextLine;
      }


      for (let k = 0; k < shortestLine.length; k++) {
        let x1 = currentLine[k].x;
        let y1 = currentLine[k].y;

        let x2 = nextLine[k].x;
        let y2 = nextLine[k].y;

        strokeWeight(0.2);
        stroke(150 * sqrt(random(1)));
        // line(x1, y1, x2, y2);
        let l = new Line(x1, y1, x2, y2, 1);
        l.show();

      }
    }
  }
  noLoop();
}

class Grid {
  constructor(pos, resolution, size) {
    this.origin = pos;
    this.res = resolution; //amt cols/rows
    this.gridWidth = size;
    this.gridHeight = size;

    this.cols = this.res - 1;
    this.rows = this.res - 1;

    this.lines = [];

    this.gridPoints = [];
    this.saveGridPoints();
  }

  saveGridPoints() {
    for (let j = 0; j <= this.rows; j++) {
      let y = map(j, 0, this.rows, 0, this.gridHeight);
      this.gridPoints[j] = [];
      for (let i = 0; i <= this.cols; i++) {
        let x = map(i, 0, this.cols, 0, this.gridWidth);

        this.gridPoints[j][i] = new Vertex(x, y);
      }
    }
  }

  insertLine(lineType, segments) {
    let amtSegments = segments;
    let randY = int(random(this.rows - amtSegments)); //to prevent out of index
    let randX = int(random(this.cols - amtSegments));
    let lineVertices = [];


    for (let index = 0; index < amtSegments; index++) {
      let pt = this.gridPoints[randY][randX + index];

      if (lineType == "horizontal") {
        pt = this.gridPoints[randY][randX + index];
      } else if (lineType == "vertical") {
        pt = this.gridPoints[randY + index][randX];
      }

      pt.isFilled = true;

      push();
      fill('red');
      noStroke();
      // ellipse(pt.x, pt.y, 10);
      pop();

      lineVertices.push(createVector(pt.x, pt.y));

      // if(randX + index > this.vertices[rows][cols])
    }

    this.lines.push(lineVertices);

    // console.log(this.lineVertices); 
  }

  showGrid() {
    // console.log(this.vertices)
    for (let j = 0; j <= this.rows; j++) {
      for (let i = 0; i <= this.cols; i++) {
        let pt = this.gridPoints[j][i];
        fill(0);
        circle(pt.x, pt.y, 5);
      }
    }
  }
}

class Vertex {
  constructor(x_, y_) {
    this.x = x_;
    this.y = y_;
    this.isFilled = false; //false (empty) default
  }
}

class Line {
  constructor(x1_, y1_, x2_, y2_, amtNoise_) {
    this.amtNoise = amtNoise_
    this.x1 = x1_;
    this.y1 = y1_;
    this.x2 = x2_;
    this.y2 = y2_;

    this.xoff = 0;
    this.yoff = 0;
  }

  show() {
    let numVertices = 5;
    for (let i = 0; i < numVertices; i++) {

      for (let j = 0; j < numVertices; j++) {
        let x = map(i, 0, numVertices, this.x1, this.x2);
        let y = map(j, 0, numVertices, this.y1, this.y2);

        let n = noise(x * 0.001, y * 0.001);
        strokeWeight(n);
        point(x + x * n, y + y * n);
        this.yoff += 0.01;

      }
      this.xoff = 0.01;

    }
  }

}