import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 800);
  smooth(8);
}

float p, i, t, k = 80;
float a;
float r = 300;
void draw() {
  background(0);
  t+=2;
  float numpoints = 10;
  strokeWeight(20);
  stroke(255);
  for (i = 0; i<k; i++) {
    p = (i-t)/k; 
    for(float a = 0; a<TAU; a+=TAU/numpoints){
      float x = r*cos(a+sin(p));
      float y = r*sin(a+cos(p));
      float z = r*cos(a);
      push();
      translate(x, y, 0);
      //strokeWeight(10*map(mag(x, y), 0, r, .3, 1));
      //circle(0, 0, 20);
      point(0,0,0);
      pop();
    }
  }
  
  //if(frameCount<360){
  // saveFrame("output/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}
