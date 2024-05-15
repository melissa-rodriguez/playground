function setup() {
  createCanvas(1000, 1000);
  background(240);
}

function draw() {
  if (frameCount <= 1) {
    background(240);

    noFill();
    let noiseMax = .5;
    let amt = 1;
    let r = 100;
    let rMin = r / 2;
    let rMax = r * 2;
    for (let i = 0; i < amt; i++) {
      for (let a = 0; a < TAU; a += radians(1)) {
        let xoff = map(cos(a), -1, 1, 0, noiseMax);
        let yoff = map(sin(a), -1, 1, 0, noiseMax);
        // let r = map(noise(xoff + a * 12345, yoff + a * 12345), 0, 1, rMin, rMax);
        r = constrain(random(random(((1)))) * 300, 300 / 2, 300);
        // r = random(random(((1)))) * 200;
        // let xo = map(noise(xoff + i * 12345, yoff + i * 12345), 0, 1, -xShift, xShift);
        let x = (width / 2) + r * cos(a);
        let y = height / 2 + r * sin(a);
        let seed = int(random(12345));
        stroke(0, 0, 0, 100*sqrt(random(1)));
        customVert(x, y, seed);
      }
    }
  }


  // noLoop();
}

function customVert(centerX, centerY, seed) {
  let noiseMax = .5;
  let r = 10;
  let rMin = r / 2;
  let rMax = r * 2;
  let amt = 3;
  let xShift = 50;

  for (let i = 0; i < amt; i++) {
    beginShape();
    for (let a = 0; a < TAU; a += radians(2)) {
      let xoff = map(cos(a), -1, 1, 0, noiseMax);
      let yoff = map(sin(a), -1, 1, 0, noiseMax);
      let r = map(noise(xoff + i * seed, yoff + i * seed), 0, 1, rMin, rMax);
      let xo = map(noise(xoff + i * seed, yoff + i * seed), 0, 1, -xShift, xShift);
      let x = (centerX + xo) + r * cos(a);
      let y = centerY + r * 2 * sin(a);
      vertex(x, y);
    }
    endShape(CLOSE);
  }
}