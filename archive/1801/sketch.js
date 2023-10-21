let gifLength = 300;
let canvas;

function setup() {
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;

  // capturer.start();

    //create class dot
    dots = new Dot(width/2, height/2);
    strayDot = new Stray((width/2), height/2);


}


function draw() {
    background(240);

    strayDot.draw();
    strayDot.move();

    dots.draw();
    dots.move();

  // if (frameCount < gifLength){
  //     capturer.capture(canvas);
  //   } else if (frameCount == gifLength) {
  //     capturer.stop();
  //     capturer.save();
  //   }
}

var jitter = 2;
class Dot {
  constructor(x,y){
    this.x = x;
    this.y = y;
  }

  draw(){
    noStroke();
    fill(51);
    for(this.y = 50; this.y < height-200; this.y += 50){
    ellipse(this.x, this.y, 20)
    }

    for(this.y = 250; this.y < height-50; this.y += 50){
      ellipse(this.x, this.y, 20);
    }
  }

  move(){
    frameRate(30);

    this.x = this.x + jitter;

    if(this.x > (width/2)+2 || this.x < (width/2)-2){
      jitter = -jitter;
    }
  }
}

var shake = 2;
class Stray{
  constructor(x,y){
    this.x = x;
    this.y = y;
  }

  draw(){
    noStroke();
    fill(51);
    ellipse(this.x, this.y, 20)
  }

  move(){

    this.x = this.x - shake;

    if(this.x > (width/2)+2 || this.x < (width/2)-2){
      shake = -shake;
    }

  }

}
