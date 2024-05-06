gridPoint[][] grid; 
int xres = 30; 
int yres = 30; 

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8); 
  grid = new gridPoint[xres+1][yres+1]; 
  colorMode(HSB); 



  for (int j = 0; j <= yres; j++) {
    for (int i = 0; i <= xres; i++) {
      PVector pos = calcPos(i, j); 
      boolean filled = false; //assume all grid points are not filled at initial
      //gridPoints.add(new gridPoint(pos, filled));
      grid[i][j] = new gridPoint(pos, filled);
    }
  }
}

PVector calcPos(int i, int j) {
  float x = map(i, 0, xres, 0, width); 
  float y = map(j, 0, yres, 0, height); 
  return new PVector(x, y);
}



void draw() {
  background(155,155,20); 

  //strip(20); 
  
  //translate(20,5); 
  //strip(color(0, 255, 255)); 
  int amt = 10;
  for(int i = 0; i < amt; i++){
    float y = map(i, 0, amt, 0, height-100); 
    push();
    translate(0, y); 
    strip(color(155, random(155), 255)); 
    pop(); 
  }

  noLoop();
}

void strip(color col){
  int len = 20; // how many segments 
  int iIndex = floor(5); 
  int jIndex = floor(3); 
  gridPoint startPoint = grid[iIndex][jIndex]; 
  gridPoint nextPoint = grid[iIndex][jIndex]; 
  noFill(); 
  strokeWeight(2); 
  stroke(col); 

  beginShape(); 
  
  for (int l = 0; l < len; l++) {
    strokeWeight(20*map(sin(map(l, 0, len, 0, random(2*TAU))), -1, 1, 0.1, 1));
    int direction = int(random(1, 9)); 
    iIndex++; 
    //jIndex++; 

    if (direction == 1) {
      //right
      nextPoint = grid[iIndex+1][jIndex];
    } else if (direction == 2) {
      //upRight
      nextPoint = grid[iIndex+1][jIndex-1];
    } else if (direction == 3) {
      //up
      nextPoint = grid[iIndex][jIndex-1];
    } else if (direction == 4) {
      //upLeft
      nextPoint = grid[iIndex-1][jIndex-1];
    } else if (direction == 5) {
      //left
      nextPoint = grid[iIndex-1][jIndex];
    } else if (direction == 6) {
      //downLeft
      nextPoint = grid[iIndex-1][jIndex+1];
    } else if (direction == 7) {
      //down
      nextPoint = grid[iIndex][jIndex+1];
    } else if (direction == 8) {
      //downRight
      nextPoint = grid[iIndex+1][jIndex+1];
    }
    //startPoint.render(); 
    //nextPoint.render();
    curveVertex(nextPoint.pos.x, nextPoint.pos.y); 
    curveVertex(startPoint.pos.x, startPoint.pos.y); 
    
    startPoint = nextPoint; 
    //println(nextPoint.pos); 
  }
  endShape(); 
}


class gridPoint {
  PVector pos;
  boolean filled; 
  gridPoint(PVector p, boolean f) {
    pos = p; 
    filled = f; 

    strokeWeight(5);
  }

  void render() {
    point(pos.x, pos.y);
  }
}

void mousePressed(){
 saveFrame("output###.png");  
}
