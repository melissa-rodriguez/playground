class Flowfield {
  float w, h; //width and height of flowfield 
  int res; //resolution 

  int cols, rows; 
  float[][] gridAngles;
  float defaultAngle;
  int fieldNum = 18; 


  Flowfield(float gridWidth, float gridHeight, int gridRes) {
    w = gridWidth; 
    h = gridHeight; 
    res = gridRes; 

    cols = int(w/res); 
    rows = int(h/res); 
    //println(rows); 
    gridAngles = new float[cols+1][rows];
    init();
  }

  void init() { 
    for (int j = 0; j < cols; j++) {
      for (int i = 0; i < rows; i++) {
        //defaultAngle = (float(j)/float(cols))*PI; //where you initiate the angle/field
        defaultAngle = generateField(i, j, fieldNum);
        gridAngles[j][i] = defaultAngle;
      }
    }
  }

  float generateField(int i, int j, int fieldNum) {
    float angle = 0; 

    if (fieldNum == 1) {
      // ------- perlin noise field -------- 
      float x = map(i, 0, rows, 0, w); 
      float y = map(j, 0, cols, 0, h);
      angle = noise(x*0.003, y*0.003)*TAU;
    } else if (fieldNum == 2) {
      // ------- open simplex noise field -------- 
      float x = map(i, 0, rows, 0, w); 
      float y = map(j, 0, cols, 0, h);
      angle = (float)noise.eval(x*0.003, y*0.003)*TAU;
    } else if (fieldNum == 3) {
      // ------- arcs y axis -------- 
      angle = (float(j)/float(cols))*TAU;
    } else if (fieldNum == 4) {
      // ------- arcs x axis -------- 
      angle = (float(i)/float(rows))*TAU;
    } else if (fieldNum == 5) {
      // ------- distance from (0,0) -------- 
      float x = map(i, 0, rows, 0, w); 
      float y = map(j, 0, cols, 0, h);
      angle = map(dist(x, y, 0, 0), 0, w, 0, 1)*6*TAU;
    } else if (fieldNum == 6) {
      // ------- distance from (center,center) -------- 
      float x = map(i, 0, rows, 0, w); 
      float y = map(j, 0, cols, 0, h);
      angle = map(dist(x, y, w/2, h/2), 0, w/2, 0, 1)*6*TAU;
    } else if (fieldNum == 7) {
      // ------- rand sin cos func -------- 
      float x = map(i, 0, rows, 0, w); 
      float y = map(j, 0, cols, 0, h);
      angle = cos(radians(i))*PI + sin(radians(j))*TAU;
    } else if (fieldNum == 8) {
      // ------- cos i -------- 
      angle = cos(radians(i))*PI;
    } else if (fieldNum == 9) {
      // ------- cos j-------- 
      angle = cos(radians(j))*5*PI;
    } else if (fieldNum == 10) {
      // ------- sin j-------- 
      angle = sin(radians(j))*50*PI;
    } else if (fieldNum == 11) {

      float x = map(i, 0, rows, 0, w); 
      float y = map(j, 0, cols, 0, h);
      angle = (x/y)*TAU;
    } else if (fieldNum == 12) {

      angle = PI/2;
    } else if (fieldNum == 13) {
      
      float theta = map(i, 0, rows, 0, TAU); 
      float phi = map(j, 0, cols, 0, TAU);
      angle = cos(theta)*PI/4;
      
    } else if (fieldNum == 14) {
      
      float theta = map(i, 0, rows, 0, TAU); 
      float phi = map(j, 0, cols, 0, TAU);
      angle = cos(theta)*sin(phi)*PI/4;
      
    }else if (fieldNum == 15) {
      float theta = map(i, 0, rows, 0, TAU); 
      float phi = map(j, 0, cols, 0, TAU);
      angle =sin(phi)*PI/4;
      
    }else if (fieldNum == 16) {
      float theta = map(i, 0, rows, 0, TAU); 
      float phi = map(j, 0, cols, 0, TAU);
      float x = map(i, 0, rows, 0, w); 
      float y = map(j, 0, cols, 0, h);
      angle = map(x*cos(theta), 0, w, 0, 1)*PI;
      
    }else if (fieldNum == 17) {
      float theta = map(i, 0, rows, 0, TAU); 
      float phi = map(j, 0, cols, 0, TAU);
      float x = map(i, 0, rows, 0, w); 
      float y = map(j, 0, cols, 0, h);
      angle = map(y*sin(theta+phi), 0, w, 0, 1)*PI;
      
    }else if (fieldNum == 18) {
      float theta = map(i, 0, rows, 0, TAU); 
      float phi = map(j, 0, cols, 0, TAU);
      float x = map(i, 0, rows, 0, w); 
      float y = map(j, 0, cols, 0, h);
      float d = dist(x, y, 0, 0); 
      angle = radians(d)/4;
      
    }

    return angle;
  }

  void updateField() {
    for (int j = 0; j < cols; j++) {
      for (int i = 0; i < rows; i++) {
        //defaultAngle = (float(j)/float(cols))*PI; //where you initiate the angle/field
        float x = map(i, 0, rows, 0, w); 
        float y = map(j, 0, cols, 0, h); 
        defaultAngle = noise(x*0.003, y*0.003, frameCount*0.01)*TAU;
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
