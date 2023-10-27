void setup() {
  size(1080, 1080);
  pixelDensity(2);
}

float a; 
void draw() {
  background(0);
  float xinc = 50;
  float yinc = 30;

  
  //noFill();
  stroke(255);
  strokeWeight(2);
  fill(255);
  translate(width/2, height/2);
  for (float y = -height; y < height; y += yinc) {
    //stroke(255*map(abs(y), 0, height, 1, 0));
    beginShape();
    for (float x = -width; x < width; x += xinc) {
      float d = dist(x,y, 0,0);
      float md = map(d, 0, width, 15*(sin(radians(a-d))), 0);
      //circle(x,y+md, 2);
      if(d<400){
      
      curveVertex(x, y+md);}
      a+=0.001;
    }
    endShape();
  }
  println(mouseX);
  
  push();
  strokeWeight(10);
  rectMode(CENTER);
  noFill();
  rect(0, 0, 900,900,20);
  pop();
  //noLoop();
  //if(frameCount < 114){
  // saveFrame("output/gif###.png"); 
  //}
}
