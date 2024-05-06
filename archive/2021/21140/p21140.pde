import peasy.*;
PeasyCam cam;
int res = 1;
int cols = 40/res; 
int rows = 40/res;


PVector surface(int i, int j, float a) {
  float x = map(i, 0, cols, -width/4, width/4);
  float y = map(j, 0, rows, -height/4, height/4)*sin(a);
  float z = 100*sin(a);
  
  return new PVector(x,y,z);
}

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  cam = new PeasyCam(this, 1000);
}


float rand;
void draw() {
  //clear();
  background(10);
  rand = mouseX;
  //noFill();
  rotateX(PI/2);
  rotateY(PI/2);
  fill(10);
  stroke(#F2B138);
  //noStroke();
  //#F25C05 orange
  //#F2B138 //yellow
  strokeWeight(3);
  float a=0;
  for (int j = 0; j < rows-1; j++) {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++) {
      PVector v = surface(i, j, a);
      PVector v2 = surface(i, j+1, a);
      vertex(v.x, v.y, v.z);
      vertex(v2.x, v2.y, v2.z);
      
      a+=2*TAU/rand;
    }
    endShape();
  }
  
  strokeWeight(1);
   stroke(10);
   for (int j = 0; j < rows-1; j++) {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++) {
      PVector v = surface(i, j, a);
      PVector v2 = surface(i, j+1, a);
      vertex(v.x, v.y, v.z);
      //vertex(v2.x, v2.y, v2.z);
      
      a+=2*TAU/rand;
    }
    endShape();
  }
  
  if(mousePressed){
   saveFrame("output"+str(rand)+".png"); 
  }
  //noLoop();
  
}
