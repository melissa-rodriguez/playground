let gifLength = 300;
let canvas;

var xsize = 50;
var ysize = 50;
var morph = 2;
var morphSpeed = 2;
var growth = 3;

function setup() {
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;

  // capturer.start();
}

function draw() {
  //background(75);
  background(240);
  displayRect();
  shapeShift();

  // if (frameCount < gifLength){
  //     capturer.capture(canvas);
  //   } else if (frameCount == gifLength) {
  //     capturer.stop();
  //     capturer.save();
  //   }
}

function displayRect() {
  translate(50, 50);
  rectMode(CENTER);

  noFill();
  //stroke(204,204,0);
  stroke(0);
  strokeWeight(3);
  for (var x = 0; x < width; x += 100) {
    for (var y = 0; y < height; y += 100) {
      rect(x, y, xsize, ysize, morph);
    }
  }
}

function shapeShift() {
  if (morph > 100 || morph < 2) {
    morphSpeed = morphSpeed * -1;
    growth = growth * -1;
  }


  morph = morph + morphSpeed;
  xsize = xsize + growth;
  ysize = ysize + growth;
}
