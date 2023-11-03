//to capture for gif
let gifLength = 180;
let canvas;

let img;
function preload(){
  img = loadImage('BLM.png');
}

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;

  // capturer.start();
}


function draw(){
  background(240);

  blm();

  //hide lettering
  push();
    fill(240);
    noStroke();
    rect(0,0,width,150);
  pop();

  raiseFist();

  push();
    stroke(0);
    noFill();
    rectMode(CENTER);
    strokeWeight(8);
    rect(200,200,300,300,2);
  pop();
  // blackLivesMatter();


  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
  
  


  
}


let w = 0;
let h = 150;
function centerHighlight(xpos, ypos, width, height){
  rectMode(CENTER);

  w = lerp(w, width, 0.07);
  rect(xpos, ypos, w, height,2);
}

function rightHighlight(xpos, ypos, width, height){
  w = lerp(w, width, 0.05);
  rect(xpos, ypos, w, height,3);
}

let waitTime = 0;
function raiseFist(){
  

  waitTime++;
  image(img, 150,h,80,100);

  if(waitTime >= 100){
    h = lerp(h, 70, 0.05);
  }
  
  if(waitTime>=210){
    fill(234, 124, 114);
    noStroke();
    centerHighlight(190, 180, 155,7);
  }
}




function blackLivesMatter(){
  fill(240);
  stroke(0);
  textFont('Roboto');
  textSize(90);

  push();
    // noFill();
    fill(0);
    rightHighlight(10,150, 240,75);

    fill(240);
    noStroke();
    text('LIVES', 10, 220);

  pop()

  text('BLACK', 10, 120);
  
  text('MATTER', 10, 320);

}

let blmY = 50;
let spacing = 45;
function blm(){
  fill(0);
  stroke(0);
  textFont('Roboto');
  textSize(50);
  waitTime++;


  if(waitTime > 100){
    blmY = lerp(blmY, 230, 0.05);
  }


  text('BLACK', 110, blmY);
  text('LIVES', 110, blmY+spacing);  
  text('MATTER', 110, blmY+(2*spacing));
}
