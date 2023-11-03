import peasy.*;
PeasyCam cam;

Path p;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);


  cam = new PeasyCam(this, 800);
  p = new Path();
}


void draw() {
  background(0);
  stroke(255);
  strokeWeight(3);
  p.calcPoints();
}

class Path {
  int w, l;
  int rows, cols;
  int res; 
  float z1 = 0;


  Path() {
    res = 50;
    cols = width/res;
    rows = height/res;
    w = 200; //width of the wave (aka amplitude)
    l = 4000; //length of the wave
  }

  void calcPoints() {

    for (int i = 0; i < cols; i++) {
      float column = map(i, 0, cols, -w/2, w/2);
      beginShape();
      noFill();
      for (int j = 0; j < rows; j ++) {
        //for (int i = 0; i < cols; i++) {
        float z = map(j, 0, rows, -l/2, l/2);
        float x = column + sin(radians(z))*100;
        curveVertex(x, 0, z);
        //}
      }
      endShape();
    }
  }
}
