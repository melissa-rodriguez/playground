//to capture for gif
let gifLength = 119;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;
  // capturer.start();

  rectMode(CENTER);
  // noLoop();
}

let angle = 0;
let jitter = 0.05;
function draw(){  
  background(240);

  noStroke();
  fill(70);

  angle += jitter;
  let c = cos(angle);

  for(let i = 45; i < width-10; i += 50){
    for(let j = 60; j < height; j += 70){
      push();
        translate(i, j);
        rotate(c);
        rect(0,0, 5, 50);
      pop();
    }
  }

  push()
    fill(240);
    rect(195, 200, 50,50);
  pop();

  push();
    translate(195,200);
    rotate(-c);
    rect(0,0, 5, 50);
  pop();
  



  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
  
  


  
}

