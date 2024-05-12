function setup() {
  createCanvas(600, 600);
  randomSeed(1);
  background(240);
}

function draw() {
  // background(240);

  for (let i = 0; i < 10; i++) {
    fill('red');
    noStroke();
    ellipse(map(i, 0, 10, width/2 - 100, width/2 + 100), height / 2, 200);


  let amt = 2;
  let pxSize = 1;
  for (let x = 0; x < width; x += amt) {
    for (let y = 0; y < width; y += amt) {
      let rectSize = pxSize;
      noStroke();
      fill(240);

      if (sqrt(random(1)) < 0.3) {
        rect(x, y, rectSize, rectSize);
      }
    }
  }

}


  noLoop();
}