import peasy.*;
PeasyCam cam;

Grid grid; 
ArrayList<Object> objects = new ArrayList<Object>(); //store all the objects you draw


void setup() {
  size(1080, 1080, P3D);
  smooth(8);
  cam = new PeasyCam(this, 800);

  grid = new Grid();
  rectMode(CENTER);
}

void draw() {
  clear();

  //grid = new Grid();
  grid.showGrid();
  int res = grid.res;
  for (Object o : objects) {
    o.show();
  }
  
  
  // ------ clear the arraylist after each frame ------
  for(int i = objects.size()-1; i >= 0; i--){
   objects.remove(i); 
  }
  //saveFrame("renders/res"+str(res)+".png");
  //saveFrame("output.png");

  noLoop();
}

class Grid {
  PVector pos; //position of the grid (center)
  int res;  //resolution
  int cols, rows;  //amt of columns and rows (based on resolution)
  int w, h; //width and height of the grid
  int r; 
  boolean filled; //has the spot on the grid already been filled? 
  Grid() {
    pos = new PVector(0, 0);
    res = int(100*random(0.1, 1)); 
    //res = 100;
    //println(res);
    w = 500;
    h = 500;
    rows = h/res; 
    cols = w/res;
    r = res; //the radius of the circle for the grid should equal the resolution
    filled = false; //assume grid location has not been filled
  }


  void showGrid() {
    stroke(255);
    strokeWeight(2);
    noFill();
    for (int j = 0; j <= rows; j++) {
      for (int i = 0; i <= cols; i++) {
        float x = map(i, 0, cols, -w/2, w/2);
        float y = map(j, 0, rows, -h/2, h/2);
        PVector pt = new PVector(x, y);

        if (random(1) > 0.5) { //50/50 chance an object will be placed 
          objects.add(new Object(x, y, res)); //add object to arraylist
        }


        //point(x, y);
        //circle(x, y, r);
      }
    }
    
  }
}

class Object {
  PVector pos;
  float size;
  Object(float x, float y, int res) {
    pos = new PVector(x, y);
    size = res;
  }

  void show() {
    square(pos.x, pos.y, size);
  }
}
