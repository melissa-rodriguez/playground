let gifLength = 300;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;

  // capturer.start();

  // saveFrames('yinYangNoise', 'png', 5, 25);
  
}


function draw(){
  background(240);
  frameRate(60);
  translate(width/2, height/2);
  noFill();
  
  
  drawCirlce();
  noiseLoop1();
  noiseLoop2()

  // if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
  
}


function drawCirlce(){
  fill(0);
  // ellipse(0,0,200);
  arc(0,0, 200, 200, 0, PI);
  fill(240);
  stroke(0);
  arc(0,0, 200, 200, PI, TWO_PI);

}


let phase = 0;
let noiseMax = 2;
function noiseLoop1(){
  circleRad = 200;
  // fill(0);
  stroke(0);
  noFill();
  let y = 0;
  beginShape();
  for(let a = 0; a<circleRad+10; a += circleRad/20){
    
    let x = (a)-circleRad/2;
    let y = (140*noise(a+phase)-75);
    constrain(y,-circleRad/2, circleRad/2);
    
    curveVertex(x,y);
    // point(x,y);
  }
  phase +=.003;
  endShape(); 
}

// this entire function is just to have the white on black/ there are two loops offset
//by very little. you can see this by either chaning the 73 in y or stroke to another color
function noiseLoop2(){
  circleRad = 200;
  // fill(0);
  stroke(0);
  noFill();
  stroke(240);
  let y = 0;
  beginShape();
  for(let a = 0; a<circleRad+10; a += circleRad/20){
    
    let x = (a)-circleRad/2;
    let y = (140*noise(a+phase)-73);
    constrain(y,-circleRad/2, circleRad/2);
    
    curveVertex(x,y);
    // point(x,y);
  }
  phase +=.003;
  endShape(); 
}
