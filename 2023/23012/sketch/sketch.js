let circleR = 0;
let grow = false;
let col = 0;

function setup() {
  createCanvas(1000, 1000);
  colorMode(HSB);
  background(240, 255, 255);

}

function draw() {
  blendMode(DIFFERENCE);

  if (circleR > width*2) {
    grow = false;
    noLoop();
    circleR = 0;
  }

  if (grow) {
    noStroke();
    fill(col)
    ellipse(mouseX, mouseY, circleR * 2, circleR * 2);
    circleR += 5;
  }
}

function mousePressed() {
  // col = color(random(255), random(255), 100);
  col = color(80, random(100, 255), 255); 
  grow = true;
  loop();
}

function keyPressed(){
  if(keyCode === LEFT_ARROW){
    save("output.png"); 
  }
}