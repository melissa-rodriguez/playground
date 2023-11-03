int grid_w = 1080; 
int grid_h = 1080; 
int res = 50; 

int cols = grid_w/res; 
int rows = grid_h/res; 
Cell[][] grid;


void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  textAlign(CENTER, CENTER);
  textSize(15); 
  rectMode(CENTER); 

  grid = new Cell[cols+1][rows+1]; 

  for (int i = 0; i <= cols; i++) {
    for (int j = 0; j <= rows; j++) {
      float randomValue = sqrt(random(1));
      float x = map(i, 0, cols, 0, grid_w); 
      float y = map(j, 0, rows, 0, grid_h); 
      grid[i][j] = new Cell(x, y, randomValue, res);
    }
  }
}


void draw() {
  background(240);  
  for (int i = 1; i < cols; i++) {
    for (int j = 1; j < rows; j++) {
      //display each object
      Cell gridPoint = grid[i][j];
      int direction = gridPoint.direction; 
      PVector startPoint = gridPoint.cellPos; 
      PVector endPoint; 
      if (i > 1 && i < cols-1 && j > 1 && j < rows-1) {
        //clockwise
        if (direction == 1) {
          //0 deg
          endPoint = grid[i+1][j].cellPos;
        } else if (direction == 2) {
          //45 deg
          endPoint = grid[i+1][j+1].cellPos;
        } else if (direction == 3) {
          //90 deg
          endPoint = grid[i][j+1].cellPos;
        } else if (direction == 4) {
          //135 deg
          endPoint = grid[i-1][j+1].cellPos;
        } else if (direction == 5) {
          //180 deg
          endPoint = grid[i-1][j].cellPos;
        } else if (direction == 6) {
          //225 deg
          endPoint = grid[i-1][j-1].cellPos;
        } else if (direction == 7) {
          //270 deg
          endPoint = grid[i][j-1].cellPos;
        } else if (direction == 8) {
          //315 deg
          endPoint = grid[i+1][j-1].cellPos;
        } else {
          endPoint = startPoint;
        }
         
        
        beginShape();
        stroke(0); 
        //vertex(startPoint.x, startPoint.y);
        //vertex(endPoint.x, endPoint.y); 
        stroke(255, 0, 10); 
        //fill(255, 0, 10);
        noFill(); 
        line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);  
        endShape();
      }


      //gridPoint.display();
    }
  }
}


class Cell {
  //store location on grid, directional value, size
  PVector cellPos; 
  float randomValue; 
  int direction; //a number 1 - 8; 
  int size; //size of each cell (depends on resolution of the grid)
  Cell(float x, float y, float randomVal, int s) {
    cellPos = new PVector(x, y); 
    randomValue = randomVal; 
    direction = round(randomVal*8); 
    size = s;
  }

  void display() {
    //fill(randomValue*255); 
    fill(0); 
    stroke(0); 
    //text(direction, cellPos.x, cellPos.y); 
    noFill(); 
    square(cellPos.x, cellPos.y, size);
  }
}

void mousePressed() {
  saveFrame("output03.png");
}
