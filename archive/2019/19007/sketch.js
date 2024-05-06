//to capture for gif
let gifLength = 300;
let canvas;

function setup(){
    var p5Canvas = createCanvas(400, 400);
    canvas = p5Canvas.canvas;
  
    // capturer.start();
    
  }
  
  let noiseMax = 10;
  let phase = 0;
  let length = 300;
  function draw(){
    background(240);
  
    translate(width/2, height/2);
    noFill();
    
    
    drawCirlce();

//      //to capture for gif
//   if (frameCount < gifLength){
//     capturer.capture(canvas);
//   } else if (frameCount == gifLength) {
//     capturer.stop();
//     capturer.save();
//   }
    
  }
  
  let xo = 50;
  let yo = width/2;
  function drawCirlce(){
    beginShape();
    for(let a = 0; a<length; a += .1){
      let xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
      let yoff = map(sin(a), -1, 1, 0, noiseMax);
  
      // aquire the perlin noise value at position (xoff,yoff), make that value the radius of the cirlce
    //   let r = map(noise(xoff,yoff), 0, 1, 100,200);   
    //   let x = r*cos(a);
    //   let y = r*sin(a);
      strokeWeight(2);
      let y = noiseMax*sin(xoff-yoff)
      line(-15*xoff,y,-15*xoff, 10*y);
      line(15*xoff,y,15*xoff, 10*y);

      

    //   vertex(x,y);
    }
    endShape();
    phase += .05;
    
    
  }

  function circlRec(){
      
  }
  