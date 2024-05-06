//GRID CLASS AND GRID POINT CLASS 
class Grid {
  PVector pos; //position of the grid (center)
  int res;  //resolution
  int cols, rows;  //amt of columns and rows (based on resolution)
  int w, h; //width and height of the grid
  int r; 
  boolean filled; //has the spot on the grid already been filled? 
  int objAmt; //the amount of objects each grid will have

  Grid(int amt) {
    pos = new PVector(0, 0);
    //res = int(100*random(0.1, 1)); 
    res = 100;
    objAmt = amt;
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


  void createObjects() {
    for (int i = 0; i < objAmt; i++) {
      objects.add(new Object(res));
    }
  }
}

class gridPoint {
  //allows you to store the grid point locations and if those points are filled
  boolean filled; //will the given point be filled (t/f)
  PVector pos;
  gridPoint(PVector position, boolean fillValue) {
    pos = position;
    filled = fillValue;
  }
}
