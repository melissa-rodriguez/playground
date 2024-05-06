Torus torus; 

import peasy.*;
PeasyCam cam;


void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);

  torus = new Torus(100, 200, 30); 


  cam = new PeasyCam(this, 800);
}

void draw() {
  background(0);
  
  rotateX(radians(30)); 
  torus.render(); 
  torus.update(); 
  
  if(frameCount<=180){
   //saveFrame("output/gif###.png");  
  }
}
