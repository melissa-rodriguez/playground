void setup(){
  size(1080, 1080, P2D);
  pixelDensity(2);
  //colorMode(HSB); 
  background(240); 
}

float a, r;
int count = 0; 
void draw(){
  //background(240); 
  translate(width/2, height/2); 
  noStroke();
  
  if(a > TAU){
    a = 0; 
    count++;
  }
  println(count); 
  //stroke(#C33E16); 
  
  r = 20*map(sin(a), -1, 1, 0, 1); 
  float x = (300-(r+5)*count)*cos(a); 
  float y = (300-(r+5)*count)*sin(a); 
  
  
  
  
  fill(#F7926C);
  //stroke(#C33E16);
  strokeWeight(2); 
  square(x-r/2, y, r); 
  
  fill(#C33E16); 
  //stroke(#F7926C);
  strokeWeight(2); 
  square(x+r/2, y, r); 
  
  a+=radians(0.1); 
  
  if(frameCount == 360*10){
   saveFrame("render.png");  
  }
 
}

void mousePressed(){
 saveFrame("render.png");  
}
