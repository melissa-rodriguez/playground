
import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  cam = new PeasyCam(this, 100);
}

float p, i, t, k = 30;
void draw() {
  //background();
  background(0);
  t+=0.01;
  strokeWeight(8);

  fill(0, 20);
  //noFill();
  float numPoints = 3;
  for (i = 0; i<k; i++) {
    p = (i+t)/k;
    for (float a = 0; a < TAU; a += TAU/numPoints) {
      stroke(255);
      push();
      rotate(a);
      translate(0, 300*(1-p), 0);
      rotateX(PI/2);
      rotateX(PI*p);
      circle(0, 0, 400*p);
      pop();
    }
  }
  
  //for (i = 0; i<k; i++) {
  //  p = (i+t)/k;
  //  PVector v = PVector.random2D();
  //  point(v.x, v.y);
  //}

  if (t>1) {
    t=0;
  }
  
  //if(t<1){
  // saveFrame("output/gif###.png"); 
  //}else{
  // exit(); 
  //}

  //rec();
}
