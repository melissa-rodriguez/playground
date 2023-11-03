//to capture for gif
let gifLength = 300;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  // canvas = p5Canvas.canvas;
  // capturer.start();
}

let cut = false;
function draw(){
  background(240);
  textFont('Ubuntu');
  textSize(100);
  upperCut();


  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
  
  


  
}

let cutPosX = 250;
let cutPosY = 185;
let cutSpeed = 10;
let waitTime = 0;
let cutWord = true;
function upperCut(){
  textAlign(CENTER, CENTER);
  text("OUT", width/2, height/2);
  rectMode(CENTER);

  push();
  beginShape();
    fill(240);
    noStroke();
    vertex(cutPosX-230,height/2 - 15);
    vertex(cutPosX-230, cutPosY);
    vertex(cutPosX + 85, height/2);
    vertex(cutPosX+85, height/2);
  endShape();
  pop();

  if(cutPosY> 210 && cutWord == true){
    cutSpeed = 0;
    cutWord = false
  }

  if(waitTime >= 50 && cutWord == true){
    cutPosY+= cutSpeed;
  }

  if(waitTime>120 && cutWord == false){
    console.log('here');
    cutSpeed = -5;
    cutPosY+= cutSpeed;
  }

  if(cutPosY < 185){
    cutSpeed = 5;
    cutPosY+= cutSpeed;
    cutWord = true;
    waitTime = 0;
  }

  waitTime++;
}


