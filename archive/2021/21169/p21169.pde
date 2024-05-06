void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
}


int w;
int h;
int res;

int cols;
int rows;

void draw() {
  background(0);
  stroke(255);
  strokeWeight(3);


  w = width;
  h = height;
  res = 100;

  cols = w/res;
  rows = h/res; 

  //line(width/2-100, height/2, width/2+100, height/2);

  
  for (int j = 0; j < rows; j++) {
    beginShape();
    noFill();
    for (int i = 0; i < cols; i++) {
      

      //PVector v2 = new PVector();
      if (i == rows-1 && j%2==0) {
        PVector v1 = pt(i, j);
        PVector v2 = pt(i, j+1);
        vertex(v1.x, v1.y);
        vertex(v2.x, v2.y);
      } 
      else if (i <= 0 && j%2!=0) {
        //circle(v1.x, v1.y, 10);
        PVector v1 = pt(i, j);
        PVector v2 = pt(i, j+1);
        vertex(v2.x, v2.y);
        vertex(v1.x, v1.y);
        
      } 
      else {
        PVector v1 = pt(i, j);
        vertex(v1.x, v1.y);
      }
    }
    endShape();
  }


  color col = 0;
  for (int j = 0; j < rows; j++) {
    noFill();
    for (int i = 0; i < cols; i++) {
      PVector v1 = pt(i, j);

      //PVector v2 = new PVector();
      if (i == rows-1 && j%2==0) {
        PVector v2 = pt(i, j+1);
        col = color(255, 0, 0);
      } else if (i <= 0 && j%2!=0) {
        //circle(v1.x, v1.y, 10);
        PVector v2 = pt(i, j+1);
        col = color(0, 255, 0);
      } else {
        col = color(255, 255, 255);
      }
      push();
      stroke(col);
      circle(v1.x, v1.y, 25);
      pop();
    }
  }
}

PVector pt(int i, int j) {
  float x = map(i, 0, cols, 100, width-100);
  float y = map(j, 0, rows, 100, height - 100);

  return new PVector(x, y);
}

void mousePressed(){
 saveFrame("debug.png"); 
}
