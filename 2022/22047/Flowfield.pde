class Flowfield {
  float w, h; //width and height of flowfield 
  int res; //resolution 

  int cols, rows; 
  float[][] gridAngles;
  float defaultAngle;
  float numSteps = 100; 
  float stepLength = 8; 

  Flowfield(float gridWidth, float gridHeight, int gridRes) {
    w = gridWidth; 
    h = gridHeight; 
    res = gridRes; 

    cols = int(w/res); 
    rows = int(h/res); 
    //println(rows); 
    gridAngles = new float[cols][rows];
    init();
  }

  void init() { 
    for (int j = 0; j < cols; j++) {
      for (int i = 0; i < rows; i++) {
        //defaultAngle = (float(j)/float(cols))*PI; //where you initiate the angle/field
        float x = map(i, 0, rows, 0, w); 
        float y = map(j, 0, cols, 0, h); 
        defaultAngle = noise(x*0.003, y*0.003)*TAU;
        gridAngles[j][i] = defaultAngle;
      }
    }
  }

  void showField() {
    for (int j = 0; j < cols; j++) {
      for (int i = 0; i < rows; i++) {
        beginShape(); 
        noFill(); 
        stroke(0, 255, 255); 
        strokeWeight(2); 
        float angle = gridAngles[j][i]; 
        float x = map(i, 0, rows, 0, w); 
        float y = map(j, 0, cols, 0, h); 
        PVector v = new PVector(x, y); 
        push(); 
        translate(v.x, v.y); 
        rotate(angle); 
        line(-5, 0, 5, 0); 

        pop();
      }
    }
  }
}
