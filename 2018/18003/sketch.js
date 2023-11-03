let gifLength = 300;
let canvas;

//TODO: Add stars to appear at night


let sun;
let moon;
let xspeed;
let skycolor_g;
let skycolor_b;
let stars = [];


function setup() {
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;

  sun = new Sun();
  moon = new Moon(0, height / 2, 50);
  stars = new Star(150, 140, 2);

  // capturer.start();



}

function draw() {
  //background(0, 191, 255, 30);
  sun.display();
  sun.face();
  moon.display();
  moon.face();
  moon.move();

  // if (frameCount < gifLength){
  //     capturer.capture(canvas);
  //   } else if (frameCount == gifLength) {
  //     capturer.stop();
  //     capturer.save();
  //   }

}

class Sun {
  constructor() { // constructor is like the class's "setup()"
    this.x = 100;
    this.y = 100;

  }
  display() {
    //background(0, 191, 255, 30);
    fill(255, 255, 102);
    noStroke();
    ellipse(width / 2, height / 2, this.x, this.y);


  }

  face() {
    noFill();
    stroke(0)
    strokeWeight(3);
    arc(190, 200, 10, 10, PI, 0, OPEN);
    arc(210, 200, 10, 10, PI, 0, OPEN);
    arc(200, 210, 20, 20, 0, PI, OPEN);

    noStroke();
    fill(255, 192, 203);
    ellipse(175, 210, 15);
    ellipse(225, 210, 15);
  }
}

class Moon {
  constructor(x, y, r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  display() {
    fill(165);
    noStroke();
    ellipse(this.x, this.y, this.r * 2, this.r * 2);

  }


  move() {
    if (this.x < width / 2) {
      xspeed = map(this.x, 0, width / 2, 4, 1 / 16);
      skycolor_g = map(this.x, 0, width / 2, 191, 85);
      skycolor_b = map(this.x, 0, width / 2, 255, 125);
    }

    if (this.x > width / 2) {
      xspeed = map(this.x, width / 2, width, 1 / 16, 4);
      skycolor_g = map(this.x, width / 2, width + 100, 85, 191);
      skycolor_b = map(this.x, width / 2, width + 100, 125, 255);
    }

    if (this.x > width + 100) {
      setup();
    }
    this.x = this.x + xspeed;
    background(0, skycolor_g, skycolor_b, 30);
    //console.log(skycolor_g, skycolor_b);
  }

  face() {
    fill(0);
    noStroke();
    ellipse(this.x - 10, this.y, 10, 10);
    ellipse(this.x + 10, this.y, 10, 10, PI, 0, OPEN);
    arc(this.x, 211, 20, 20, 0, PI, OPEN);

    fill(255, 0, 0);
    arc(this.x, 219, 10, 8, PI, 0, OPEN);

    noStroke();
    fill(255, 192, 203);
    ellipse(this.x - 25, 210, 15);
    ellipse(this.x + 25, 210, 15);
  }
}

class Star {
  constructor(xStar, yStar, r) {
    // constructor(){
    this.x = xStar;
    this.y = yStar;
    this.r = r;

  }

  display() {
    fill(255);
    noStroke();
    ellipse(this.x, this.y, this.r * 2);

    fill(255, 255, 255, 10);
    noStroke();
    ellipse(this.x, this.y, (this.r * 2) + 7);

  }
}