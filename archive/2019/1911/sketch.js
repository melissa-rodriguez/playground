//to capture for gif
let gifLength = 300;
let canvas;

let phase = 0;
let noiseMax = 1;
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

  eyes(0,0);


  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }

  
}


function eyes(xpos, ypos){
  let r2 = 5;
  beginShape();
  for(let a = 0; a<40; a+=.2){
    let xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
    let yoff = map(sin(a), -1, 1, 0, noiseMax);
    let r = map(noise(xoff, yoff), 0, 1, 10, 20);
    
    let x = r*cos(a);
    let y = r*sin(a);
    // vertex(x+xpos,y);
    

  stroke(70);

  if(r2 < 100){
    ellipse(-147,y+ypos,r2);
    }
  if(r2 < 100){
    ellipse(147,y+ypos,r2);
    }
  if(r2 < 200){
    ellipse(0,y+ypos,r2);
    }
  r2 += 5;

  }
  endShape(CLOSE);
  phase += .2;
  
}
