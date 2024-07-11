let outlineShapes = [];
let allOutlinePoints = [];

class Ellipse {
  constructor(x, y, w, h, angle) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.angle = angle;
  }

  isPointInside(px, py) {
    let dx = px - this.x;
    let dy = py - this.y;
    let cosAngle = cos(-this.angle);
    let sinAngle = sin(-this.angle);
    let xRot = dx * cosAngle - dy * sinAngle;
    let yRot = dx * sinAngle + dy * cosAngle;
    return (4 * xRot * xRot) / (this.w * this.w) + (4 * yRot * yRot) / (this.h * this.h) <= 1;
  }

  getPoint(t) {
    let x = this.x + this.w * cos(t) / 2 * cos(this.angle) - this.h * sin(t) / 2 * sin(this.angle);
    let y = this.y + this.w * cos(t) / 2 * sin(this.angle) + this.h * sin(t) / 2 * cos(this.angle);
    return {
      x,
      y
    };
  }

  getSection(section) {
    let sectionX = this.x + section * (this.w / 3) * cos(this.angle);
    let sectionY = this.y + section * (this.w / 3) * sin(this.angle);
    return {
      x: sectionX,
      y: sectionY
    };
  }

  display() {
    push();
    noStroke();
    translate(this.x, this.y);
    rotate(this.angle);
    ellipse(0, 0, this.w, this.h);
    pop();
  }
}

class OutlineShape {
  constructor(xpos, ypos, size, amtShapes) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.size = size;
    this.amtShapes = amtShapes;
    this.ellipses = [];
    this.generateEllipses();
  }

  generateEllipses() {
    let baseWidth = this.size;
    let baseHeight = this.size / 1.5;
    let scaleAmt = [1, 3, 12];

    // First ellipse
    this.ellipses.push(new Ellipse(this.xpos, this.ypos, baseWidth, baseHeight, random(TAU)));

    for (let i = 1; i < this.amtShapes; i++) {
      let prevEllipse = this.ellipses[i - 1];
      let section = random([-1, 1]);
      let sectionPoint = prevEllipse.getSection(section);

      let randomOffset = random(0, PI / 2);
      let newAngle = prevEllipse.angle + PI / 2 + randomOffset;

      let offsetX = (baseHeight / 2) * cos(newAngle);
      let offsetY = (baseHeight / 2) * sin(newAngle);

      let newX = sectionPoint.x + offsetX;
      let newY = sectionPoint.y + offsetY;

      let adjustedPosition = this.adjustPositionToBounds(newX, newY, baseWidth, baseHeight, newAngle);
      newX = adjustedPosition.x;
      newY = adjustedPosition.y;

      let r = sqrt(random(1));
      if (r > 0.8) {
        this.ellipses.push(new Ellipse(newX, newY, baseHeight, baseHeight, newAngle));
      } else {
        this.ellipses.push(new Ellipse(newX, newY, baseWidth, baseHeight, newAngle));
      }
    }
  }

  adjustPositionToBounds(x, y, w, h, angle) {
    let corners = [{
        x: -w / 2,
        y: -h / 2
      },
      {
        x: w / 2,
        y: -h / 2
      },
      {
        x: w / 2,
        y: h / 2
      },
      {
        x: -w / 2,
        y: h / 2
      }
    ];

    let minX = Infinity,
      minY = Infinity,
      maxX = -Infinity,
      maxY = -Infinity;

    for (let corner of corners) {
      let rotatedX = corner.x * cos(angle) - corner.y * sin(angle) + x;
      let rotatedY = corner.x * sin(angle) + corner.y * cos(angle) + y;
      minX = min(minX, rotatedX);
      minY = min(minY, rotatedY);
      maxX = max(maxX, rotatedX);
      maxY = max(maxY, rotatedY);
    }

    let adjustedX = x;
    let adjustedY = y;

    if (minX < 0) adjustedX += -minX;
    if (minY < 0) adjustedY += -minY;
    if (maxX > width) adjustedX -= (maxX - width);
    if (maxY > height) adjustedY -= (maxY - height);

    return {
      x: adjustedX,
      y: adjustedY
    };
  }

  draw() {
    for (let i = 0; i < this.ellipses.length; i++) {
      this.drawSingleEllipseOutline(i);
    }

    for (let i = 0; i < this.ellipses.length; i++) {
      let e = this.ellipses[i];
      e.display();
    }
  }

  drawSingleEllipseOutline(index) {
    let drawing = false;

    for (let t = 0; t <= TWO_PI; t += 0.01) {
      let point = this.ellipses[index].getPoint(t);

      if (!this.isPointInAnyOtherEllipse(point.x, point.y, index)) {
        if (!drawing) {
          beginShape();
          drawing = true;
        }
        vertex(point.x, point.y);
      } else {
        if (drawing) {
          endShape();
          drawing = false;
        }
      }
    }

    if (drawing) {
      endShape();
    }
  }

  isPointInAnyOtherEllipse(px, py, excludeIndex) {
    for (let i = 0; i < this.ellipses.length; i++) {
      if (i !== excludeIndex && this.ellipses[i].isPointInside(px, py)) {
        return true;
      }
    }
    return false;
  }

  getBoundingBox() {
    let minX = Infinity,
      minY = Infinity,
      maxX = -Infinity,
      maxY = -Infinity;
    for (let ellipse of this.ellipses) {
      for (let t = 0; t < TWO_PI; t += 0.1) {
        let point = ellipse.getPoint(t);
        minX = min(minX, point.x);
        minY = min(minY, point.y);
        maxX = max(maxX, point.x);
        maxY = max(maxY, point.y);
      }
    }
    return {
      minX,
      minY,
      maxX,
      maxY
    };
  }
}

function setup() {
  createCanvas(1000, 1000);
  background(0);
  noFill();
  stroke(240);
  strokeWeight(3);

  let wordLength = 2;
  for (let i = 0; i < wordLength; i++) {
    let size = 300;
    let x = (size) + size * i;
    let amtInternalShapes = int(random(2, 7));
    let wordShape = new OutlineShape(x, height / 2, size, amtInternalShapes);
    outlineShapes.push(wordShape);
  }

  // Calculate the bounding box of all shapes
  let minX = Infinity,
    minY = Infinity,
    maxX = -Infinity,
    maxY = -Infinity;
  for (let shape of outlineShapes) {
    let bb = shape.getBoundingBox();
    minX = min(minX, bb.minX);
    minY = min(minY, bb.minY);
    maxX = max(maxX, bb.maxX);
    maxY = max(maxY, bb.maxY);
  }

  // Calculate the center of the composition
  let centerX = (minX + maxX) / 2;
  let centerY = (minY + maxY) / 2;

  // Calculate the offset to center the composition
  let offsetX = width / 2 - centerX;
  let offsetY = height / 2 - centerY;

  // Reposition all shapes
  for (let shape of outlineShapes) {
    for (let ellipse of shape.ellipses) {
      ellipse.x += offsetX;
      ellipse.y += offsetY;
    }
  }

  // Collect points from all shapes for the outline
  for (let shape of outlineShapes) {
    for (let ellipse of shape.ellipses) {
      for (let t = 0; t < TWO_PI; t += 0.1) {
        let point = ellipse.getPoint(t);
        allOutlinePoints.push(createVector(point.x, point.y));
      }
    }
  }

  // Generate the convex hull for all points
  allOutlinePoints = convexHull(allOutlinePoints);
}

function draw() {
  background(240);

  fill(240);
  stroke(0);
  strokeWeight(5);
  for (let i = 0; i < outlineShapes.length; i++) {
    let wordShape = outlineShapes[i];
    wordShape.draw();
  }

  // Draw the overall outline
  drawOverallOutline();
}

function drawOverallOutline() {
  push();
  noFill();
  stroke(255, 0, 0);
  strokeWeight(2);
  beginShape();
  for (let i = 0; i < allOutlinePoints.length; i++) {
    curveVertex(allOutlinePoints[i].x, allOutlinePoints[i].y);
  }
  // Add the first few points again to close the shape smoothly
  for (let i = 0; i < 3; i++) {
    curveVertex(allOutlinePoints[i].x, allOutlinePoints[i].y);
  }
  endShape(CLOSE);
  pop();
}

function convexHull(points) {
  let start = points[0];
  for (let i = 1; i < points.length; i++) {
    if (points[i].y < start.y || (points[i].y === start.y && points[i].x < start.x)) {
      start = points[i];
    }
  }

  points.sort((a, b) => {
    let angle = atan2(a.y - start.y, a.x - start.x) - atan2(b.y - start.y, b.x - start.x);
    return angle || ((a.x - start.x) ** 2 + (a.y - start.y) ** 2) - ((b.x - start.x) ** 2 + (b.y - start.y) ** 2);
  });

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