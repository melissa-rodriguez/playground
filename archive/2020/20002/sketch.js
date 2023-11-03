//to capture for gif
let gifLength = 300;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;
  // capturer.start();
}

function draw(){
  background(240);
  noFill();
  stroke(217, 150, 167);
  strokeWeight(20);

  eyelid();

  push();
  ellipse(width/2, height/2, 200);
  pop()

  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
  
  


  
}

let lidpos = 200;
let speed = 1;
let phase = 0;
let stopped = false;
let waitTime = 0;
let reverse = false;
let baseline = true;
let irisposX = 200;
let irisSpeed = 5;
let irisposY = lidpos;
function eyelid(){

  arcpos = map(lidpos,170,211,10,400);
  irisposY = map(lidpos,170,216,160,216);
  //EYEBALL
  push();
  fill('white');
  // console.log(lidpos);
  noStroke();
  arc(200, 200, 200, 200, 0-PI/arcpos, PI+PI/arcpos, CHORD);
  pop();

  
  //EYELID AND COLOR
  push()
  fill(242, 182, 193);
  noStroke();
  arc(200, 200, 200, 200, PI+0-PI/50, PI+PI+PI/50, CHORD);
  pop();

  //EYEBALL
  push();
  strokeWeight(1);
  noStroke();
  fill('white');
  rect(width/2-100, lidpos+5, 200, 32);
  pop();

  //IRIS
  push();
  noStroke();
  fill(118, 98, 114)
  arc(irisposX,irisposY,109,109,0,PI,OPEN);
  pop();

  
  line(width/2-95, lidpos,width/2+95, lidpos);
    

  if(stopped == false&&baseline==true&&phase == 0){
    lidpos+=speed;
    // console.log('downstroke')
  }
 
  if(stopped == false&&baseline==false&&(phase==1||phase==2 || phase ==3)){
    // console.log('upstroke')
    lidpos-=speed;
  }

  
  
  //first down move
  if (lidpos > 215){
    stopped = true;
    baseline = false;
    phase = 1;
    waitTime ++;
  }

  //wait a second before going back up
  if (phase == 1 && waitTime >= 50){
    stopped = false;   
    phase = 2; 
    waitTime = 0;
  }

  // //eyelid back at base position
  if(lidpos <= height/2 && phase == 2){
    stopped = true;
    baseline=true;
    waitTime ++;
  }

  // //initiate eyeroll
  if(phase== 2 && waitTime >=50){
    waitTime = 0;
    stopped = false;
    baseline = false;
    speed = 2*speed;
    phase = 3;
    irisposY = 10;
  }


  //IRIS MOVEMENT
  if((phase == 3 || phase == 4) && stopped == false){
    irisposX += irisSpeed;

    if(irisposX >= 234){
      irisSpeed = -irisSpeed;
    }

    if(irisposX <= 150){
      irisSpeed = 0;
      waitTime ++;
      // console.log(waitTime);
    }
  }

  if(phase == 4 && stopped == true && waitTime >= 80){
    irisSpeed = 4;
    irisposX += irisSpeed ;
    if(irisposX >= 200){
      irisposX = 200;
    }
  }


  if(lidpos < 170){
    // stopped = true;
    phase = 4;

  }

  if(phase == 4&&stopped ==false){
    lidpos += speed;
  }

  if(phase == 4 && lidpos>=200){
    stopped = true;
    waitTime++;
  }




  

}

