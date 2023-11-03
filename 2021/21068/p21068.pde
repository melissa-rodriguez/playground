
import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;
void settings() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
}
void setup() {
  noise = new OpenSimplexNoise();
  //cam = new PeasyCam(this, 100);
}
float t, i, p, a, c, r,x,y, k=100;
void draw() {
  t+=.005;
  background(0);
  //background(#FBF9F3);
  push();
  noStroke();
  lights();
  //fill(#F27272);
  //directionalLight(252, 255, 191, 0, 0, -1);
  //pointLight(242, 176, 53, 0, 0, mouseX);
  translate(width/2, height/2-height, 600-1e4);
  sphere(3000);
  pop();
  burton();
  
  //if(frameCount <=100){
  //  saveFrame("output3/gif###.png");
  //}
  
  
}

void burton(){
  
push();
  translate(r=540, r, r);
  for (i=0; i<k; i++) {
    p=(i-t)/k; 
    
    //fill(#123962);
    fill(0);
    //noFill();
    for (a=0; a<k; a+=.5) {
      push();
      x = 200*cos(c=a*TAU/(width/2));
      y = 200*sin(c);
      float dx = periodicFunction(t-offset(x, y), 0); // seed at 0
      float dy = 10.0*periodicFunction(t-offset(x, y), 123);
      stroke(215*map((float)noise.eval(x, y, t), -1, 1, 1, 0.6)); 
      //stroke(#123962);
     
      //stroke(124, 167, 191,100);
      rotate(25*p);
      translate(x, y, 500-p*1e4);
      rotateY((c+a)*TAU*(p));
      box(k, 100, 10);
      pop();
    }
  }
  pop();
}

float periodicFunction(float p, float seed)
{
  float radius = 1.3;
  return 1.0*(float)noise.eval(seed+radius*cos(TWO_PI*p), radius*sin(TWO_PI*p));
}

float offset(float x,float y)
{
  return 0.015*dist(x,y,width/2,height/2);
}
