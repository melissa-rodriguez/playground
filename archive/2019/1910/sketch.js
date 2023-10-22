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
  
  bobTheBlob();
  eyes(-25,-5);
  eyes(25,-5);
  mouth();

  push();
  shaddow();
  pop();

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
// function eyes(xpos, ypos){
  
//   beginShape();
//   for(let a = 0; a<TWO_PI; a+=.3){
//     let xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
//     let yoff = map(sin(a), -1, 1, 0, noiseMax);
//     let r = map(noise(xoff, yoff), 0, 1, 5, 20);
    
//     let x = r*cos(a);
//     let y = r*sin(a);
//     // vertex(x+xpos,y);
//     ellipse(x+xpos,y+ypos,10);
  
//   }
//   endShape(CLOSE);
//   phase += .05;
// }

// function eyes(){
//   ellipse(-25, -10, 20);
//   ellipse(25, -10, 20);
// }

function mouth(){
  push();
  beginShape();
  noiseMax = .5;
  for(let a = 0; a<PI; a+=.05){
    let xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
    let yoff = map(sin(a+phase*.2), -1, 1, 0, noiseMax);
    let r = map(noise(xoff, yoff), 0, 1, 10, 15);
    
    let x = r*cos(a);
    let y = r*sin(a);
    vertex(x,y+10);
  }
  endShape(CLOSE);
  
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
  for(let a = PI; a<TWO_PI; a+=.2){
    floor(a);
    let xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
    let r = map(noise(xoff, yoff), 0, 1, 10, 80);
    let xShaddow = r*cos(a)+35;
    if(a==PI){
    let ellipseX = 75+xoff*30
    stretch = constrain(ellipseX, 75, 90);

    noStroke();
    shadowColor = color(0,0,0,30);
  
    fill(shadowColor);
    
    ellipse(xShaddow*.05+2, 75, stretch, 10);
  }
  // console.log(xShaddow);
  }
  

}