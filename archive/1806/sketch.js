// TODO: have spots move when mouse hovers, and go back when it moves away
// have a gradient of blue or orange

var spot = {
  x: 100,
  y: 50
};

var col = {
  r: 150,
  g: 200,
  b: 0
};

function setup() {
  createCanvas(400, 400);
  background(0);
}

function draw() {
  spot.x = random(0, width);
  spot.y = random(0, height);
  col.r = random(100, 255);
  col.g = 0;
  col.b = random(100, 190);

  if (spot.x > width/2) {
    col.r = map(spot.x, width/2, width, 0, 150);
    col.g = map(spot.x, width/2, width, 150, 255);
    // ellipse(spot.x, spot.y, 24, 24);
    // fill(col.r, col.g, col.b, 190);
  }
  
   noStroke();
  fill(col.r, col.g, col.b, 190);
  ellipse(spot.x, spot.y, 24, 24);
}

function mousePressed() {
 background (0); 
}