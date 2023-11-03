import peasy.*;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  cam = new PeasyCam(this, 7000);
}


int n1 = 10;
int numPoints = 10;
int amp = 500; //amplitude
void draw() {
  background(240);
  translate(-width/2, -height/2);

  stroke(0);
  strokeWeight(4);



  for (int j = 0; j <= numPoints; j++) {
    beginShape(TRIANGLE_STRIP);
    //stroke(70);
    noFill();
    for (float a = 0; a <= 2*TAU; a+=TAU/numPoints) {
      PVector v = pVertex(j, a, 0);
      PVector v2 = pVertex(j+1, a, 6*TAU);
      vertex(v.x, v.y);
      vertex(v2.x, v2.y);
    }
    endShape();
  }
  
  
}

PVector pVertex(float j, float a, float phase) {
  float x = map(a, 0, TAU, -width/2, width/2);
  float y = map(j, 0, numPoints, 0, height)+amp*sin(a+phase);

  return new PVector(x, y);
}

void mousePressed(){
 //saveFrame("render###.png"); 
}
