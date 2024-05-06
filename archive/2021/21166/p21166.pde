import peasy.*;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 800);
}

float p, i, t, k1, k2; 
void draw() {
  background(0);
  t+=radians(1); 
  
  push();
  rotateY(PI/6);
  rotate(t);
  //translate(0,0,mouseX);
  
  drawWheels();
  drawFloor();
  pop();
  
}

void drawWheels(){
 float numPoints = 20;
  float r = 200;
  k1 = 10;
  
  strokeWeight(5);
  stroke(255);
  
  for(i = 0; i < k1; i++){
   //p = (i+t)/k1;
   for(float a = 0; a < numPoints; a+=TAU/numPoints){
     float scale = map(i, 0, k1, 0, 1);
     float x = r*scale*cos(a);
     float y = r*scale*sin(a);
     point(x, y, 0);
     point(x, y, -r/2);
   }
  } 
}

void drawFloor(){
  float numPoints = 20;
  float r = 200;
  k1 = 10;
  
  strokeWeight(5);
  stroke(255);
  
  for(i = 0; i < k1; i++){
   p = (i)/k1;
   for(float a = 0; a < numPoints; a+=TAU/numPoints){
     float scale = map(i, 0, k1, 0, 1);
     float x = r*cos(a);
     float y = r*sin(a);
     point(x, y, -p*r/2);
     //point(x, y, -r/2);
   }
  }  
}
