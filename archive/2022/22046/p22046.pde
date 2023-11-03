Flowfield field; 
Particle p; 
OpenSimplexNoise noise; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  field = new Flowfield(1080, 1080);
  p = new Particle(800, 800);
  noise = new OpenSimplexNoise();
}

void draw() {
  background(240); 
  field.showField();
  p.render();
  p.follow(field);


  //field.drawCurve();
}

class Flowfield {
  float w, h; //width and height of flowfield 
  int res; //resolution 

  int cols, rows; 
  float[][] gridAngles;
  float defaultAngle;
  float numSteps = 100; 
  float stepLength = 8; 

  Flowfield(float gridWidth, float gridHeight) {
    w = gridWidth; 
    h = gridHeight; 
    res = 20; 

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
        stroke(0); 
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

  void drawCurve() {
    //starting point
    float x = 500; 
    float y = 100; 
    beginShape();
    for (int n = 0; n < numSteps; n++) {
      vertex(x, y); 

      int colIndex = int(x/res); //conversion from coordinate to index
      int rowIndex = int(y/res); 

      //check bounds
      if (colIndex < gridAngles.length && rowIndex < gridAngles.length) {
        float a = gridAngles[colIndex][rowIndex];
        float xStep = stepLength*cos(a); 
        float yStep = stepLength*sin(a);


        x+=xStep; 
        y+=yStep;
      }
    }
    endShape();
  }
}

class Particle {
  PVector pos, vel, acc; 
  float maxSpeed = 4; 
  int res; //lookup from flowfield
  float[][] gridAngles;
  float a;  
  float w, h; //w and h of flowfield grid
  Particle(float x, float y) {
    pos = new PVector(x, y); 
    vel = new PVector(0, 0); 
    acc = new PVector(0, 0);
  }

  void render() {
    circle(pos.x, pos.y, 20);
  }

  void follow(Flowfield field) {
    //look up the angle = vel(speed*cos(a), speed*sin(angle))
    //also check the bounds here, if they go out of the edges, 
    //there will be arrayindex outofbounds
    w = field.w; 
    h = field.h; 
    
    res = field.res; 
    gridAngles = field.gridAngles; 
    a = lookup(pos.x, pos.y);
    
    if (!outOfBounds(pos.x, pos.y)) {
      vel = new PVector(maxSpeed*cos((a)), maxSpeed*sin((a))); 
      pos.add(vel);
    }else if(pos.y > height - 20){ // out of ounds conditionals are not complete
      pos.y = pos.y - height+40; //still need to add all possible OOB conditions
    }else if(pos.x < 20){
      pos.x = pos.x + width-40; 
    }

    //println(a);
  }

  float lookup(float x, float y) {
    //reverse look up index to find out what angle is at current location 

    int colIndex = int(y/res); 
    int rowIndex = int(x/res);
    //println(colIndex, rowIndex); 
    return gridAngles[colIndex][rowIndex];
  }

  boolean outOfBounds(float x, float y) {
    if (pos.x >= w-20 || x < 0 || y < 0 || y >= h-20) {
      return true; //it is out of bounds
    } else {
      return false;
    }
  }
}

void mousePressed(){
 saveFrame("output.png");  
}
