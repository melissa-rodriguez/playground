let points = [];

function setup() {
  createCanvas(1000, 1000);



}

function draw() {
  background(240);
  // let col = color(0, 150, 255, 45);
  let col = color(0, 0, 255, 15);
  // let col = color(242, 92, 5, 40);
  noStroke();
  let radius =300; 

  fill(red(col), green(col), blue(col), 7);
  // ellipse(width / 2, height / 2, radius, radius + 300);


  let noiseMax = .5;
  let rMax =radius;
  let rMin = -rMax/4;
  let amt = 100;
  for (let i = 0; i < amt; i++) {
    beginShape();

    for (let a = 0; a <= TAU*2; a += radians(4)) {
      let xoff = map(cos(a), -1, 1, 0, noiseMax);
      let yoff = map(sin(a), -1, 1, 0, noiseMax);
      // let r = width / 2;
      let n = noise(xoff + i * 12345, yoff + i * 12345);
      let r = map(n, 0, 1, rMin, rMax);
      let transX = map(noise(xoff + a * random(12345), yoff + a * random(12345)), 0, 1, -100, 100);
      let transY = map(noise(xoff + a * random(12345), yoff + a * random(12345)), 0, 1, -100, 100);
      let x = (width / 2) + transX + r * cos(a);
      let y = height / 2 + transY + r*2 * sin(a);
      noFill();
      stroke(col);
      curveVertex(x, y)
    }
    endShape();

  }


  noLoop();

}