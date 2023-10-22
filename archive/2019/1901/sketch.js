let gifLength = 300;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;

  // capturer.start();
}

var move = 20;
var angle = 90;
function draw(){
  frameRate(10);
  background(240);
  noFill();
  stroke_color = color('#57493B');
  fill_color = color('#C5D7D9');
  stroke(stroke_color);
  fill(fill_color);
  

  squigle_ball1();

  // push();
  // squigle_ball2();
  // pop();
  
  // if (frameCount < gifLength){
  //     capturer.capture(canvas);
  //   } else if (frameCount == gifLength) {
  //     capturer.stop();
  //     capturer.save();
  //   }
 
}

function squigle(){
  beginShape()
  for (let a = 0; a < TWO_PI; a += .2){
    let r = random(50,100);
    x = r * cos(a);
    y = r * sin(a);
    vertex(random(0,x),random(0,y));
    
  }
  endShape(CLOSE)
  
}

function squigle_ball1(){
  // translate(200,200);
  rotate_clockwise()
  for (let i = -width/2; i < width; i+= 15){
    squigle();
}
} 


function rotate_clockwise(){
  transx = 100*cos(radians(angle)) + width/2;
  transy = 100*sin(radians(angle)) + height/2;
  translate(transx, transy);


  angle +=5;

  return true;
}


function rotate_ccw(){
  transx = 100*cos(radians(-angle)) + width/2;
  transy = 100*sin(radians(-angle)) + height/2;
  translate(transx, transy);


  angle -=5;
}

function squigle_ball2(){
  rotate_ccw()
  for (let i = -width/2; i < width; i+= 15){
    squigle();
}
}

