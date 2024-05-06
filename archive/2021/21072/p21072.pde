void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  rectMode(CENTER);
  //blendMode(DIFFERENCE);
}

float t, p, i, k = 40;
boolean record = false;
void draw() {
  background(0);
  noFill();
  stroke(255);
  strokeWeight(2);
  t+=0.005;
  for (i = 0; i<k; i++) {
    p = (i+t)/k;
    for (float x = width/3; x < width-width/3; x += 10) {
      push();

      translate(x, width/2, -1000+5000*sin(TAU*p));
      stroke(255*map(-1000+5000*sin(TAU*p), -1000, 200, 0.2, 1));
      square(0, 0, 1000*p); 
      pop();
    }
  }
  
  //if(record){
  // saveFrame("output/gif###.png"); 
  //}
}


void mousePressed(){
 record = true; 
}
