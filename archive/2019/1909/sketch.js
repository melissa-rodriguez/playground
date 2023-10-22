//to capture for gif
let gifLength = 300;
let canvas;

let noiseMax = 1;
let phase = 0;
function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;
  // capturer.start();
}

function draw(){
  noiseSeed(3);
  background(240);
  translate(width/2, height/2);
  stroke(70);
  noFill();
  
  push();
  noStroke();
  bobTheBlob();
  eyes(-25,-15);
  eyes(25,-15);
  mouth();
  pop();
  shaddow();

  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }

  
}

function bobTheBlob(){
  beginShape();
  for(let a = 0; a<TWO_PI; a+=.2){
    let xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
    let yoff = map(sin(a), -1, 1, 0, noiseMax);
    let r = map(noise(xoff, yoff), 0, 1, 50, 100);
    
    let x = r*cos(a);
    let y = r*sin(a);
    vertex(x,y);
  }
  endShape(CLOSE);
  phase += 0.05;
}

let xoff = 0;
let yoff = 0;


function mouth(){
  push();
  beginShape();
  noiseMax = .5;
  for(let a = 0; a<PI; a+=.05){
    let xoff = map(cos(a+phase*.2), -1, 1, 0, noiseMax);
    let yoff = map(sin(a), -1, 1, 0, noiseMax);
    let r = map(noise(xoff, yoff), 0, 1, 10, 80);
    
    let x = r*cos(a);
    let y = r*sin(a);
    vertex(x,y);
  }
  endShape(OPEN);
  phase += 0.005;
  pop();
}

function eyes(xpos, ypos){
  push();
  beginShape();
  for(let a = PI; a<TWO_PI; a+=.2){
    let xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
    let yoff = map(sin(a), -1, 1, 0, noiseMax);
    let r = map(noise(xoff, yoff), 0, 1, 10, 20);
    
    let x = r*cos(a);
    let y = r*sin(a);
    vertex(x+xpos,y+ypos);
  }
  endShape(OPEN);
  phase += 0.005;
  pop();
}

let xShaddow = 0;
function shaddow(){
  for(let a = PI; a<TWO_PI; a+=.05){
  let xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
  let r = map(noise(xoff, yoff), 0, 1, 10, 80);
  let xShaddow = r*cos(a);
  ellipse(xShaddow, xShaddow, 200, 20);
  // console.log(xShaddow);
  }
  

}