import peasy.*;
PeasyCam cam;

Grid grid; 
ArrayList<Object> objects = new ArrayList<Object>(); //store all the objects you draw
ArrayList<gridPoint> gridPoints = new ArrayList<gridPoint>(); // store all grid points

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  cam = new PeasyCam(this, 800);

  grid = new Grid();

  rectMode(CENTER);
}

void draw() {
  background(0);
  grid.calcGrid();
  grid.createObject();


  for (Object o : objects) {
    o.render();
  }



  for (gridPoint pt : gridPoints) {
    PVector v = pt.pos;

    if (pt.filled == true) {

      println(v.x, v.y);
    }
    //point(v.x, v.y);
  }




  // ------ clear the arraylist after each frame ------
  //for (int i = objects.size()-1; i >= 0; i--) {
  //  objects.remove(i);
  //}
  //saveFrame("renders2/res"+str(res)+".png");
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
  int objAmt; //the amount of objects each grid will have

  Grid() {
    pos = new PVector(0, 0);
    //res = int(100*random(0.1, 1)); 
    res = 100;
    objAmt = 3;
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
        //gridPoints.add(pt);

        //println(gridPoints[i*j]);


        //if (random(1) > 0.86) { //50/50 chance an object will be placed 
        //  objects.add(new Object(x, y, res)); //add object to arraylist
        //} else {
        //  filled = false;
        //}
        //println(filled);
        point(x, y);
        circle(x, y, r);
      }
    }
  }

  void calcGrid() {
    stroke(255);
    strokeWeight(2);
    noFill();

    for (int j = 0; j <= rows; j++) {
      for (int i = 0; i <= cols; i++) {
        float x = map(i, 0, cols, -w/2, w/2);
        float y = map(j, 0, rows, -h/2, h/2);
        PVector pt = new PVector(x, y);
        gridPoints.add(new gridPoint(pt, false)); //assume every point is not filled at start
      }
    }
  }


  void createObject() {
    for (int i = 0; i < 3; i++) {
      objects.add(new Object(res));
    }
  }
}




class Object {
  //PVector pos; //pos of vertices?
  float len; //amt of points/vertices each line will have (limit = resolution of grid)
  int res; //resolution of the grid
  Object(int res) {
    //pos = new PVector(0, 0);
    len = 4;
  }

  void render() {
    beginShape();
    int count = 0;
    for (int i = 0; i < gridPoints.size(); i++) { //go through every point in the grid

      if (count < len) { //as long as the count is less than the length (vertex amt) :
        int index = int(random(gridPoints.size())); //get a random index from the grid

        if (gridPoints.get(index).filled == false) { //if the random position is not filled :

          PVector pos = gridPoints.get(index).pos; //get the position from the random index
          gridPoints.get(index).filled = true; //mark the positions as filled
          //println(pos);
          vertex(pos.x, pos.y);
          //point(pos.x, pos.y);
        }
      } else {
        break;
      }
      count++;
    }
    endShape();
  }
}
  


class gridPoint {
  boolean filled; //will the given point be filled (t/f)
  PVector pos;
  gridPoint(PVector position, boolean fillValue) {
    pos = position;
    filled = fillValue;
  }
}
