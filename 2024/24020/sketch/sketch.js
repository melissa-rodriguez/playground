let customShapes = [];
let outlinePoints = [];

function setup() {
  createCanvas(1000, 1000);

  let numShapes = 5;

  for (let i = 0; i < numShapes; i++) {
    let w = 200;
    let h = 400;
    let xpos = random(width / 2 - w, width / 2 + w);
    let ypos = random(height / 2 - w, height / 2 + w);
    // let ypos = height/2;

    let angle = random(TAU);
    shape = new CustomShape(xpos, ypos, w, h, angle);
    customShapes.push(shape);
  }

  // Generate outline points
  outlinePoints = generateOutlinePoints();
}

function draw() {
  background(240);

  // Draw custom shapes
  for (let shape of customShapes) {
    shape.display();
  }

  // Draw outline
  drawOutline();

  noLoop();
}

function generateOutlinePoints() {
  let allPoints = [];

  // Sample points from all shapes
  for (let shape of customShapes) {
    for (let t = 0; t < TWO_PI; t += 0.1) {
      let x = shape.xpos + shape.w * cos(t) / 2 * cos(shape.angle) - shape.h * sin(t) / 2 * sin(shape.angle);
      let y = shape.ypos + shape.w * cos(t) / 2 * sin(shape.angle) + shape.h * sin(t) / 2 * cos(shape.angle);
      allPoints.push(createVector(x, y));
    }
  }

  // Use convex hull algorithm to find outline points
  return convexHull(allPoints);
}

function drawOutline() {
  push();
  noFill();
  stroke(255, 0, 0);
  strokeWeight(10);
  beginShape();
  for (let i = 0; i < outlinePoints.length; i++) {
    curveVertex(outlinePoints[i].x, outlinePoints[i].y);
  }
  // Add the first few points again to close the shape smoothly
  for (let i = 0; i < 3; i++) {
    curveVertex(outlinePoints[i].x, outlinePoints[i].y);
  }
  endShape();
  pop();
}

// Convex Hull algorithm (Graham scan)
function convexHull(points) {
  // Find the point with the lowest y-coordinate (and leftmost if tie)
  let start = points[0]; // Start with the first point as our initial lowest point

  // Loop through all points to find the lowest
  for (let i = 1; i < points.length; i++) {
    let currentPoint = points[i];

    // Check if this point is lower than our current lowest
    if (currentPoint.y < start.y) {
      // If it's lower, make it our new lowest point
      start = currentPoint;
    }
    // If it's at the same height, check if it's more to the left
    else if (currentPoint.y === start.y && currentPoint.x < start.x) {
      // If it's more to the left, make it our new lowest point
      start = currentPoint;
    }
  }

  // Sort points by polar angle with respect to start point
  points.sort((a, b) => {
    let angle = atan2(a.y - start.y, a.x - start.x) - atan2(b.y - start.y, b.x - start.x);
    
    return angle || ((a.x - start.x) ** 2 + (a.y - start.y) ** 2) - ((b.x - start.x) ** 2 + (b.y - start.y) ** 2);
  });

  // Build convex hull
  let hull = [start];
  for (let p of points) {
    while (hull.length > 1 && !isLeftTurn(hull[hull.length - 2], hull[hull.length - 1], p)) {
      hull.pop();
    }
    hull.push(p);
  }

  return hull;
}

function isLeftTurn(a, b, c) {
  return ((b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)) > 0;
}

class CustomShape {
  constructor(xpos, ypos, w, h, angle) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.w = w;
    this.h = h;
    this.angle = angle;
  }

  display() {
    push();
    noFill();
    fill(0);
    stroke(240);
    // noStroke();

    beginShape();
    for (let t = 0; t < TWO_PI; t += 0.01) {
      let x = this.xpos + this.w * cos(t) / 2 * cos(this.angle) - this.h * sin(t) / 2 * sin(this.angle);
      let y = this.ypos + this.w * cos(t) / 2 * sin(this.angle) + this.h * sin(t) / 2 * cos(this.angle);
      vertex(x, y);
    }
    endShape(CLOSE);
    pop();
  }
}