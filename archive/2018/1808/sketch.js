let gifLength = 300;
let canvas;
  
  var x=200;
  var black = 0;
  var white = 255;
  var color;

function setup() {
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;

  noStroke();
  noCursor();

  // capturer.start();

}


function draw() {
    background(240);
    drawRect();



    if (mouseOverLeft()){     //if the rectangle is over the left half of the circle
      color = white;          //the circle will turn white like an x-ray
    }
    else{
      color = black;
    }
    noFill();
    stroke(color);
    arc(width/2, height/2, 180, 180, PI/2, 3*PI/2);
    // console.log(mouseX);

    if(mouseOverRight()){     //if the rectangle is over the right half of the circle
      color = white;          //the circle will turn white like an x-ray
    }
    else{
      color = black
    }
    stroke(color);
    arc(width/2, height/2, 180, 180, 3*PI/2, PI/2);

  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
  }

function drawRect(){
  constrain(mouseX,100,300);
  x = lerp(x, mouseX, 0.2);
  fill(60);
  noStroke();
  rectMode(CENTER);
  rect(x, height/2, 100, 200);
  strokeWeight(7);
}

//check to see if the mouse is on the left half of the circle
function mouseOverLeft(){
  if (mouseX >60 && mouseX < (width/2)+50){
    return true;
  }
  else { return false;}
}

//check to see if the mouse is on the right half of the cirlce
function mouseOverRight(){
  if(mouseX>150 && mouseX < 345){
    return true;
    }
    else {return false;}
}
