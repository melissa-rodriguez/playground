function setup() {
  createCanvas(1000, 1000);
  background(240);

}

function draw() {
  background(230);
  fill(0);
  generateShape();
  noLoop();
}

let count = 0; 
function mousePressed() {
  count++;
  clear();
  background(230);
  noiseSeed(int(random(1000)));
  randomSeed(int(random(1000)))

  generateShape();
  save("gosted" + str(count) + ".png"); 
}

function generateShape() {
  let noiseMax = 0.8;

  for (let i = 0; i < 500; i++) {

    let theta = map(i, 0, 500, 0, TAU);

    let xoff = map(1 + cos(theta), 0, 1, 0, noiseMax);
    let yoff = map(1 + sin(theta), 0, 1, 0, noiseMax);
    let n = noise(xoff, yoff);

    // if (n > 0.4) {
    //   stroke(0)
    // } else {
    //   // stroke(220);
    //   stroke(255);
    // }


    let r = map(n, 0, 1, 100, 300);
    let x = width / 2 + r * cos(theta);
    let y = height / 2 + r * sin(theta);
    // ellipse(x, y, 20, 20);

    if (r > 200) {
      stroke(255);
    } else {
      stroke(0);
    }

    let v = new brushVertex(x, y);


    v.show();
  }
}



class brushVertex {
  constructor(xpos, ypos) {
    this.x = xpos;
    this.y = ypos;
  }

  show() {
    let amt = 1000;

    for (let i = 0; i < amt; i++) {
      let theta = random(map(i, 0, amt, 0, TAU));

      let xoff = 1 + cos(theta);
      let yoff = 1 + sin(theta);
      let n = noise(xoff, yoff);

      let maxR = 100;
      let r = (random(random(random(maxR)))) + map(n, 0, 1, -100, 200);
      // let r = (random(random(random(maxR))));
      let x = this.x + r * cos(theta);
      let y = this.y + r * sin(theta);

      point(x, y);
    }
  }

}