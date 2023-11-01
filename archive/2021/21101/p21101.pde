import peasy.*;
PeasyCam cam;
dRing ring;

void setup() {
  size(900, 900, P3D);
  pixelDensity(2);
  ring = new dRing(0, 0, 0, 0,0,0);
  cam = new PeasyCam(this, 600); //peasy cam automatically does translate(width/2, height/2);
  sphereDetail(5);
}

float t = 0;

int k = 200;

void draw() {
  t += .01;
  background(0);
  noStroke();
  //rotateX(PI);
  //translate(300, 300);
  rotateX(PI);
  println(mouseX);
  for (int i=0; i<k; i++) {
    float p = (i+10*t)/k;
    ring.update(p);
    ring.display(p);
  }
  if(t>1)t=0;
  
  //if(t<1){
  // saveFrame("output/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
  
  
}
