let gifLength = 300;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;

  // capturer.start();

}

function draw(){
  frameRate(10);
  background(240);
  translate(width/2, height/2);
  noFill();
  stroke_color = color('#57493B');
  fill_color = color('#C5D7D9');
  stroke(stroke_color);
  fill(fill_color);

  
  for (let i = -width/2; i < width; i+= 100){
    for (let j = -height/2; j < height; j += 100){
      squigle(i, j);
    }
  }
  // squigle();

  // if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
 
}

function squigle(i, j){
  beginShape()
  // for (let x = 0; x< innerWidth; x++){
  //   let y = height*noise(.03*x);
  //   vertex(x,y);
  // }
  
  for (let a = 0; a < TWO_PI; a += .1){
    let r = random(0,50);
    x = r * cos(a);
    y = r * sin(a);
    xpos = x+i;
    ypos = y + j;
    vertex(xpos,ypos);
    
  }
  endShape(CLOSE)
}

function mousePressed(){
  noLoop();
}

function mouseReleased(){
  loop();
}

