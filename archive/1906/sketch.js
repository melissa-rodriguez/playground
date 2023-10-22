//to capture for gif
let gifLength = 300;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;

  // capturer.start();
  
}

let noiseMax = .7;
let phase = 0;
function draw(){
  background(240);

  translate(width/2, height/2);
  noFill();
  
  for (let yHeight = 0; yHeight < 5; yHeight += 2){
    drawCirlce(yHeight);
  }


  //to capture for gif
  // if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
}

function drawCirlce(yHeight){
  beginShape();
  for(let a = 0; a<TWO_PI; a += 0.1){
    let xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
    let yoff = map(sin(a), -1, 1, 0, noiseMax);

    // aquire the perlin noise value at position (xoff,yoff), make that value the radius of the cirlce
    let r = map(noise(xoff,yoff), 0, 1, 100,200);   
    let x = r*cos(a);
    let y = r*sin(yHeight);
    vertex(x,y);
  }
  endShape(CLOSE);
  phase += .005;

}
