class FlowField {
  PVector[][] field; //declare 2d array of pvectors
  int cols, rows;
  int resolution; //res of grid relative to window width and height in pixels

  FlowField() {
    //set up flow field data structure
    resolution = 10;
    cols = width/resolution;
    rows = height/resolution;
    field = new PVector[cols][rows];
  }

  float zoff = 0;
  void init() {
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        //PVector v = PVector.random2D();
        //field[i][j] = v;
        n = (float) noise.eval(xoff, yoff, zoff);
        //float n = noise(xoff, yoff, zoff);
        float theta = map(n, 0, 1, 0, TWO_PI);
        PVector v = new PVector(cos(theta), sin(theta));
        field[i][j] = v;

        float x = i * resolution;
        float y = j * resolution;
        
        
        v.setMag(10);
        //line(x, y, x + v.x, y + v.y);
        //drawVector(field[i][j], x, y);
        yoff+=0.1;
      }
      xoff+=0.1;
    }
    zoff += 0.01;
  }

  void drawVector(PVector v, float x, float y) {
    translate(x, y);
    //println(x*resolution, y*resolution);
    ellipse(0, 0, 20, 20);
    line(0, 0, v.x, v.y);
  }
  
  PVector lookup(PVector lookup){
    int column = int(constrain(lookup.x/resolution, 0, cols -1));
    int row = int(constrain(lookup.y/resolution, 0, rows -1));
    return field[column][row].get(); //return copy of pvector
  }
}
