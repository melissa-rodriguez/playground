//TODO: Fix order of operations, filling the overlapping shape is broken. 

function setup() {
  createCanvas(1000, 1000);
  background(240);
  noFill();
  stroke(0);
  strokeWeight(3);

  // Ellipse parameters: center (x1, y1), width (w1), height (h1), and rotation angle (angle1)
  let x1 = width/2 + 50, y1 = height/2, w1 = 400, h1 = 200, angle1 = PI / 6;
  let x2 = width/2 - 50, y2 = height/2, w2 = 400, h2 = 200, angle2 = -PI / 6;

  // Draw the first ellipse outline
  drawEllipseOutline(x1, y1, w1, h1, angle1, x2, y2, w2, h2, angle2);

  // Draw the second ellipse outline
  drawEllipseOutline(x2, y2, w2, h2, angle2, x1, y1, w1, h1, angle1);
}

// Function to draw the outline of an ellipse excluding the overlapping part
function drawEllipseOutline(x1, y1, w1, h1, angle1, x2, y2, w2, h2, angle2) {
  let drawing = false;
  beginShape();
  for (let t = 0; t <= TWO_PI; t += 0.01) {
    // Calculate the rotated point on the ellipse
    let x = x1 + w1 * cos(t) / 2 * cos(angle1) - h1 * sin(t) / 2 * sin(angle1);
    let y = y1 + w1 * cos(t) / 2 * sin(angle1) + h1 * sin(t) / 2 * cos(angle1);

    // Check if the point is outside the other ellipse
    if (!isPointInEllipse(x, y, x2, y2, w2, h2, angle2)) {
      if (!drawing) {
        beginShape();
        drawing = true;
      }
      vertex(x, y);
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

// Function to check if a point (px, py) is inside an ellipse centered at (ex, ey) with width (ew), height (eh), and rotation (angle)
function isPointInEllipse(px, py, ex, ey, ew, eh, angle) {
  let dx = px - ex;
  let dy = py - ey;

  // Rotate point to align with the ellipse's axis
  let cosAngle = cos(-angle);
  let sinAngle = sin(-angle);
  let xRot = dx * cosAngle - dy * sinAngle;
  let yRot = dx * sinAngle + dy * cosAngle;

  // Check if the rotated point is inside the ellipse
  return (4 * xRot * xRot) / (ew * ew) + (4 * yRot * yRot) / (eh * eh) < 1;
}
