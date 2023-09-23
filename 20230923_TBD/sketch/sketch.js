function setup(){
  createCanvas(1000, 1000); 
  blendMode(MULTIPLY); 
}

function draw(){
  clear();
  background(255); 
  noStroke();

  let r = 100; 
  let opacity = 255; 
  let c = 'cyan'; 
  let m = 'magenta'; 
  let y = 'yellow'; 
  fill(red(c), green(c), blue(c), opacity);
  ellipse(width/2-r/2, height/2, r*2); 

  fill(red(m), green(m), blue(m), opacity);
  ellipse(width/2+r/2, height/2, r*2); 

  fill(red(y), green(y), blue(y), opacity);
  ellipse(width/2, height/2+r, r*2); 
}