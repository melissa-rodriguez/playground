function setup() {
  createCanvas(500, 500);
}

function draw() {
  back();
  
  strokeWeight(4);
  line(75,0,75,285);
  line(75, 285, 450, 285);
  
  
  line(75, 85, 300, 85);
  fill(255);
  rect(300, 85, 30, 165);
  line(300, 85, 300, 250);
  line(300, 250, 450, 250);
  
  line(75, 50, 450, 50);
  line(450, 50, 450, height);
  
  rect(380, 78, 30, 30);
  
  fill(255,215,0);
  noStroke();
  rect(77, 87, 221, 196);
  rect(295, 252, 153, 31);
  rect(77, 10, 438, 38);
  rect(452, 40, 63, 220);
  
  
  fill(255);
  rect(0, 50, 75, 35);
  rect(width-75, 250, 75, 37);
  
  stroke(255)
  fill(255,0, 0);
  ellipse(145, 140, 75,75);
  
  fill(255);
  rect(100, 145, 50,50);
  
  
  
  
}

function back(){
  background(65,105,225);
  noFill();
  stroke(255);
  strokeWeight(20);
  rect(0,0,width,height);
}
