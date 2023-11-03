//to capture for gif
let gifLength = 300;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;


  // capturer.start();
}


let weight = 0;
let color = 100;
let xpos = 200;
let speed = 50;
let display = true;

let spacing = 100;
function draw(){
  textFont('Lacquer');
  noStroke();
  textSize(50);
  textAlign(LEFT, CENTER)
  frameRate(4);
  background(240);
  rectMode(CENTER);

  
  
  middleBanner();

  
  tyrusHandy();

  if(xpos > 600){
    topBanner();
  }

  if(xpos > 800){
    bottomBanner();
  }

  if(xpos> 1000){
    comingSoon();
  }

  if(xpos > 1100||xpos<250){
    speed = -speed;
  }


  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }

  
}

function tyrusHandy(){
  push();
  textAlign(CENTER,CENTER);

  push()
  fill(0, 0, 0, 245);
  rect(xpos,height/2,300,100); 
  pop();

  push();
  fill(216, 204, 174, 245);
  text('tyrus handy', xpos, height/2);
  xpos+=speed;
  pop();
  pop();
}

function topBanner(){
  push()
  textAlign(CENTER, CENTER);
  
  push()
  stroke(0,0,0,50);
  fill(216, 204, 174, 245);
  rect(width/2,height/2-spacing,300,100);
  pop()

  text('more than', width/2, height/2-spacing);
  pop()
}

function middleBanner(){
  push()
  textAlign(CENTER, CENTER);

  push()
  stroke(0,0,0,50);
  fill(216, 204, 174, 245);
  rect(width/2,height/2,300,100);
  pop();

  text('a mixtape', width/2, height/2);
  pop()
}
function bottomBanner(){
  push()
  textAlign(CENTER, CENTER);

  push()
  stroke(0,0,0,50);
  fill(216, 204, 174, 245);
  rect(width/2,height/2 + spacing,300,100);
  pop();

  text('deluxe', width/2, height/2+spacing);
  pop()
}

function comingSoon(){
  push();
  textSize(17)
  textAlign(CENTER, CENTER);

  push()
  fill(0, 0, 0, 245);
  rect(width/2,height/2+(spacing/2) + spacing,100,30);
  pop()

  push()
  fill(216, 204, 174, 245);
  text('coming soon', width/2, height/2+(spacing/2)+spacing);
  pop()
  pop();
}



