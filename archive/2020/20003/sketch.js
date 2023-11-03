//to capture for gif
let gifLength = 300;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  // canvas = p5Canvas.canvas;
  // capturer.start();

  

}

let yoff = 0.0;
let test1 = 1;
let y;
let speed = 1;
let charging =  true;
let percent = 0;
function draw() {
  background(240);
  noiseSeed(7);

  

  
 
  textAlign(CENTER, CENTER);
  textSize(100);
  noFill();
  stroke(0);
  textFont('Balsamiq Sans');
  // text(str(floor(percent)) + '%', width/2, height/2);
  
  dispBattery();
  
  push();
  fillAnimation();
  pop();


  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
}

function dispBattery(){
  a = select(".neumorphism-2");
  a.position(65,0);
}

function fillAnimation(){
  noStroke();
  fillColor=color(9, 179, 66,alpha);

  fill(fillColor);

  // We are going to draw a polygon out of the wave points
  beginShape();

  


  let xoff = 0; // Option #1: 2D Noise
  // let xoff = yoff; // Option #2: 1D Noise

  // Iterate over horizontal pixels
  for (let x = 0; x <= width; x += 20) {

    // Calculate a y value according to noise, map to

    // Option #1: 2D Noise
    y = map(noise(xoff, yoff), 0, 1, 300, 400);
    

    // Option #2: 1D Noise
    // let y = map(noise(xoff), 0, 1, 200,300);
    
    y -= speed;

    if(y <= -20 || y >= 420){
      charging = !charging;
    }
    // Set the vertex
    vertex(x, y);
    

    // Increment x dimension for noise
    xoff += 0.05;

    if (charging == true){
      speed += .02;
    }
    
    else if(charging == false){
      speed -= .02;
    }

    
  }
  // increment y dimension for noise
  yoff += 0.008;
  percent = map(y, 400,0, 0, 100);
  if(percent > 100){
    percent = 100;
  }
  if(percent < 0){
    percent = 0;
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

}


  


  


  




