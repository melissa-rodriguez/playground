//to capture for gif
let gifLength = 320;
let canvas;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;
  // capturer.start();
}

let speed = 1;
let y = 0;
let word = 'NEW YORK';
let down = true;
function draw(){
  background(240);
  textFont('Oswald');
  textAlign(CENTER, CENTER);
  textSize(50);

  scroll();









  

  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
  
  


  
}

function scroll(){
  
  if(down == true){
    background(240);
    fontColor = 'black';
    fill(fontColor);
    coverUp(fontColor);
  }
  if(down == false){
    background('black');
    fontColor = 240;
    fill(fontColor);
    coverUp(fontColor)
  }
  for(let letter = 0; letter <= word.length; letter++){
    if(word[letter]=='N'){
      for(let ypos = -10; ypos < 400; ypos+=60){
        text(word[letter], 112, ypos+y);
      }
    }
    if(word[letter]=='E'){
      for(let ypos = -10; ypos < 400; ypos+=60){
        text(word[letter], 137, ypos+(y*.7));
      }
    }
    if(word[letter]=='W'){
      for(let ypos = -10; ypos < 400; ypos+=60){
        text(word[letter], 165, ypos+(y*.8));
      }
    }
  
    if(word[letter]=='Y'){
      for(let ypos = -10; ypos < 400; ypos+=60){
        text(word[letter], 207, ypos+(y*.9));
      }
    }
  
    if(word[letter]=='O'){
      for(let ypos = -10; ypos < 400; ypos+=60){
        text(word[letter], 232, ypos+(y));
      }
    }
  
    if(word[letter]=='R'){
      for(let ypos = -10; ypos < 400; ypos+=60){
        text(word[letter], 261, ypos+(y*.6));
      }
    }
  
    if(word[letter]=='K'){
      for(let ypos = -10; ypos < 400; ypos+=60){
        text(word[letter], 288, ypos+(y*.8));
      }
    }
  }
    y+=speed;
    
    if(y>=130||y<-60){
      down = !down;
      speed = -speed;
    }

    if(down == true){
      coverUp(fontColor);
      // border(fontColor);
    }
    if(down == false){
      coverUp(fontColor)
      // border(fontColor);
    }
    
    

    
}

function coverUp(fontColor){
  if(fontColor == 'black'){
    push();
      noStroke();
      fill(240);
      rect(0,0,width,100);
      rect(0,300,width,height);
    pop();
  }
  else{
    push();
      noStroke();
      fill(0);
      rect(0,0,width,100);
      rect(0,300,width,height);
    pop();
  }
}

function border(strokeColor){
  push()
  stroke(strokeColor);
  noFill();
  rect(101,100,200,200);
  pop();
}

