import peasy.*;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);
}


float spacing = 20;
float xspace = 5;
float k = 50;
float t;
//float i;
void draw() {
  background(0);
  strokeWeight(6);
  stroke(255);
  noFill();
  
 
 for(float i = 0; i < k; i++){
   float p = (i+t)/k;
   float a=0;
   float ypos = map(i, 0, k, -height/2, height/2);
  for(float x = -width/2; x < width/2; x+=spacing){
    float y = 100*sin(a+p);
    a+=2*TAU/spacing;
    point(x,ypos+y);
  }
  t+=0.01;
  
 }
  
  
  
  
  //if(frameCount<629){
  //saveFrame("output/gif###.png");
  //}
}
