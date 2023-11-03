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

  grid = new Grid(2); //create a grid with n amount of objects in it

  rectMode(CENTER);
}

void draw() {
  background(0);
  
  /*TODO: 
  - encapsulate 'calc grid, create objects, show grid' into one function 
  - use bezier instead of vertex
  - make a render arc function
  
  */
  
  grid.calcGrid(); // calculate the grid 
  grid.createObjects(); // create the objects that will be place in the grid 
  grid.showGrid();


 // render all the objects created 
  for (Object o : objects) {
    o.renderLine();
    //o.renderArc();
    //o.renderBezier();
  }



  //for (gridPoint pt : gridPoints) {
  //  PVector v = pt.pos;

  //  if (pt.filled == true) {

  //    println(v.x, v.y);
  //  }
  //  //point(v.x, v.y);
  //}




  // ------ clear the arraylist after each frame ------
  //for (int i = objects.size()-1; i >= 0; i--) {
  //  objects.remove(i);
  //}
  //saveFrame("renders2/res"+str(res)+".png");
  //saveFrame("output.png");

  noLoop();
}
