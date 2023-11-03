void setup() {
  size(1080, 1080);
  pixelDensity(2);
}

float a; 
void draw() {
  background(0);
  float xinc = 30;
  float yinc = 30;

  
  noFill();
  stroke(255);
  strokeWeight(2);
  //fill(0);
  translate(width/2, height/2);
  for (float y = -height; y < height; y += yinc) {
    //stroke(255*map(abs(y), 0, height, 1, 0));
    beginShape();
    for (float x = -width; x < width; x += xinc) {
      float d = dist(x,y, 0,0);
      float offset = 50*(sin(radians(a-d)));
      float mapdist = map(d, 0, width/4, offset, 0);
      //circle(x,y+md, 2);
      
      curveVertex(x, y+mapdist);
      a+=0.001;
    }
    endShape();
  }
  //saveFrame("output/gif###.png");
  //noLoop();
}
