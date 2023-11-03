class Particle {
  PVector pos, vel, acc; 
  float maxSpeed = 4; 
  int res; //lookup from flowfield
  float[][] gridAngles;
  float a;  
  float w, h; //w and h of flowfield grid
  int cols, rows; //cols and rows of grid

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
    cols = field.cols; 
    rows = field.rows; 

    gridAngles = field.gridAngles; 
    a = lookup(pos.x, pos.y);

    vel = new PVector(maxSpeed*cos((a)), maxSpeed*sin((a))); 
    pos.add(vel);

  }

  float lookup(float x, float y) {
    //reverse look up index to find out what angle is at current location 

    int colIndex = int(y/res); 
    int rowIndex = int(x/res);
    
    
    //check to see if you are in bounds, if not, pick a new random location
    if(colIndex >= cols-1 || colIndex <= 0 || rowIndex >= rows-1 || rowIndex <= 0){
      pos = new PVector(random(w), random(h));
    }

    return gridAngles[colIndex][rowIndex];
  }
 
}
