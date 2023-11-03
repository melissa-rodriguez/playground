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
