var angle = 0.0;
var jitter = 0.0;

function setup() {
  createCanvas(400, 400);
  rectMode(CENTER);
  //angleMode(DEGREES);
}

function draw() {
  background(240);

  translate(200, 200);
  //rotate(45);
  if (second() % 2 == 0) {
    jitter = random(-0.1, 0.1);
  }
  angle = angle + jitter;
  var c = cos(angle);
  rotate(c)

  for (var a = -width; a <= width; a += 50) {
    for (var b = -width; b <= width; b += 50) {
      stroke(20, 50);
      diamond(a, b);
    }
  }

  //rotate(45);
  for (var c = -width; c <= width; c += 50) {
    for (var d = -width; d <= width; d += 50) {
      pit(c, d);
    }
  }
}

function diamond(x, y) {

  fill(255);
  rect(x, y, 50, 50, 10);
}

function pit(x, y, long) {

  fill(0);
  ellipse(x, y, 10, long);

}

//print();
