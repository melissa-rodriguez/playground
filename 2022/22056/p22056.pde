Grid grid; 
int gridWidth = 400; 
int gridHeight = 800; 
int resolution  = 100; 

ArrayList<Grid> grids; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  colorMode(HSB); 
  textAlign(CENTER, CENTER);
  textSize(15); 
  rectMode(CENTER);

  grids = new ArrayList<Grid>(); 

  int amt = 5; 
  for (int i = 0; i < amt; i++) {
    //every new grid has a new random seed/newline
    grids.add(new Grid(gridWidth, gridHeight, resolution));
  }
}


void draw() {
  background(240);  
  translate(width/2 - gridWidth/2, height/2-gridHeight/2); 

  //grid.displayGrid(); 
  //grid.drawLine("ydom"); 
  
  for(Grid grid : grids){
   //grid.displayGrid(); 
   grid.drawLine(); 
   grid.circleLine(); 
  }


  saveFrame("render.png"); 
  noLoop();
}

class Grid {
  // (200, 400, 50);
  int grid_w; 
  int grid_h; 
  int res; 

  int cols;
  int rows; 

  Cell[][] gridCells; //store grid cell objects

  Grid(int w, int h, int r) {
    grid_w = w; 
    grid_h = h; 
    res = r; 

    cols = grid_w/res; 
    rows = grid_h/res;

    gridCells = new Cell[cols+1][rows+1]; 

    init(); //initialize the gird
  }

  void init() {
    for (int i = 0; i <= cols; i++) {
      for (int j = 0; j <= rows; j++) {
        float randomValue = sqrt(random(1));
        float x = map(i, 0, cols, 0, grid_w); 
        float y = map(j, 0, rows, 0, grid_h); 
        gridCells[i][j] = new Cell(x, y, randomValue, res);
      }
    }
  }

  void displayGrid() {
    for (int i = 0; i <= cols; i++) {
      for (int j = 0; j <= rows; j++) {
        //display each object
        Cell gridPoint = gridCells[i][j];
        PVector pos = gridPoint.cellPos; 
        //circle(pos.x, pos.y, 20); 
        gridPoint.display();


        //for (float a = 0; a < TAU; a+=TAU/50) {
        //  float cx = 10*cos(a); 
        //  float cy = 10*sin(a); 
        //  float n = map(noise(cx*0.3, cy*0.3), 0, 1, 0, 2); 
        //  circle(pos.x+cx*n, pos.y+cy*n, 2); 
        //       }
      }
    }
  }

  void drawLine() { 
    PVector startPoint = gridCells[int(random(cols+1))][0].cellPos;
    PVector nextPoint = startPoint; 

    beginShape(); 
    noFill(); 
    for (int j = 0; j <= rows; j++) {

      //fill(155, 155, sqrt(random(1))*255);
      
      
      vertex(startPoint.x, startPoint.y); 
      //curveVertex(startPoint.x, startPoint.y); 

      float rand = floor(map((random(1)), 0, 1, -1, 2));         
      startPoint.add(rand*res, res); //make the starting point the next point

      

      if (startPoint.x>grid_w || startPoint.x < 0) {
        break;
      }
      
      //set cell filled = true
      int colIndex = constrain(int(startPoint.x/res), 0, gridCells.length); 
      int rowIndex = constrain(int(startPoint.y/res), 0, gridCells.length); 

      gridCells[colIndex][rowIndex].filled = true; 
      


      //startPoint.y+=res;
    }
    endShape(OPEN);
  }
  
  void circleLine(){
    PVector startPoint = gridCells[int(random(cols+1))][0].cellPos;
    PVector nextPoint = startPoint; 

    beginShape(); 
    //noStroke(); 
    noFill(); 
    for (int j = 0; j <= rows; j++) {
      //stroke(255*sqrt(random(1)), 155, sqrt(random(1))*255); 
      //fill(255*sqrt(random(1)), 155, sqrt(random(1))*255);

      float rand = floor(map((random(1)), 0, 1, -1, 2));  
      
      nextPoint = startPoint.copy(); //copy to be able to add next pos
      nextPoint.add(rand*res, res);  //set next point
      
      for(int c = 0; c < 50; c++){
       float cx = map(c, 0, 50, startPoint.x, nextPoint.x); 
       float cy = map(c, 0, 50, startPoint.y, nextPoint.y); 
       circle(cx, cy, 20); 
      }

       
      startPoint.add(rand*res, res); //make the starting point the next point

      

      if (startPoint.x>grid_w || startPoint.x < 0) {
        break;
      }

    }
    endShape(OPEN);
  }
}


class Cell {
  //store location on grid, directional value, size
  PVector cellPos; 
  float randomValue; 
  int direction; //a number 1 - 8; 
  int size; //size of each cell (depends on resolution of the grid)
  
  boolean filled = false; 


  Cell(float x, float y, float randomVal, int s) {
    cellPos = new PVector(x, y); 
    randomValue = randomVal; 
    direction = round(randomVal*3); 
    size = s;
  }

  void display() {
    //fill(randomValue*255); 
    stroke(0); 
    noFill(); 

    square(cellPos.x, cellPos.y, size);
  }
}

void mousePressed() {
  saveFrame("output01.png");
}
