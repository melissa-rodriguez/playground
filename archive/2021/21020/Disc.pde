class Disc {
  float xpos, ypos,zpos, xvel, yvel, zvel, r;
  Disc(float x, float y,float z, float xvel, float yvel, float zvel, float radius) {
    xpos = x;
    ypos = y;
    xvel = xvel;
    yvel = yvel;
    r = radius;
  }
  
  void display(){
    fill(0);
   ellipse(xpos, ypos, r, r); 
  }
}
