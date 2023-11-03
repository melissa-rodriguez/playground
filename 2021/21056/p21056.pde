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
  float mouse = map(mouseX, -width/2, width/2, -12, 12);
  translate(width/2, height/2);
  for (float y = -height; y < height; y += yinc) {
    //stroke(255*map(abs(y), 0, height, 1, 0));
    beginShape();
    for (float x = -width; x < width; x += xinc) {
      float d = dist(x,y, 0,0);
      float md = map(d, 0, width,20*easeInElastic(sin(radians(a-d))), 0);
      //circle(x,y+md, 2);
      if(d<300){
      
      push();
      curveVertex(x%52, y+md);
      pop();
            
    }
 
      a+=0.001;
      
    }
    endShape();
  }
  println(mouseX);
  //noLoop();
  //if(frameCount < 70){
   //saveFrame("output/gif###.png"); 
  //}
}
