Brush brush;

void setup(){
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  
  background(240); 
  
  colorMode(HSB); 
  
  brush = new Brush(100, 0.9); 
}

float speed = 2; 
float t; 
float x, y; 
void draw(){
  translate(width/2 + x+50*cos(t), y+50*sin(t)); 
  
  if(y > height/3){
   t+=radians(2);  
  }
  brush.render(); 
  y+=speed; 
  
}

class Brush{
 float size; //size of brush
 float r; 
 float res; //resolution of brush, number between 0 and 1
 int numPoints; 
 
 ArrayList<brushPoint> bPoints = new ArrayList<brushPoint>(); 
 
 Brush(float s, float resolution){
  size = s; 
  res = resolution; 
  numPoints = int(res*300); //300 being the max number of points
  
  initBrush(); 
 }
 
 void initBrush(){
  //create the brush made up of a set of brush points
  for(int i = 0; i < numPoints; i++){
   float theta = map(i, 0, numPoints, 0, TAU); 
   bPoints.add(new brushPoint(size, theta)); 
  }
 }
 
 void render(){
  for(brushPoint pt : bPoints){
   stroke(pt.col); 
   strokeWeight(pt.sw); 
   point(pt.pos.x, pt.pos.y);  
  }
 }
}

class brushPoint{
  //i want this class to store the position and color/stroke of each point
  PVector pos; 
  color col; 
  float sw; 
 brushPoint(float size, float theta){
   float r = size*sqrt(random(1)); 
   sw = 4*sqrt(random(1));
   pos = new PVector(r*cos(theta), r*sin(theta)); 
   //col = color(160, 255*map(mag(pos.x, pos.y), 0, size, 1, 0.1), 255); //blue
   col = color(160, 255*map(mag(pos.x, pos.y), 0, size, 1, 0.1), 255); //blue
   //col = color(20, 255*map(mag(pos.x, pos.y), 0, size, 1, 0.2), 255);
 }
}
