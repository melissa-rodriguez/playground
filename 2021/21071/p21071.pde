
import peasy.*;

PeasyCam cam;

boolean record = false;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  cam = new PeasyCam(this, 3000);
}
float t, i, p, a, c, k=80;
void draw() {
  t+=.005;
  background(0);
  noStroke();
  //fill(255*(1-p));
  //translate(300, 300);
  for (i=0; i<k; i++) {
    p=(i-5*t)/k;
    //for (a=0; a<6; a+=1) {
      c=a*TAU/6;
      push();
      translate(0, 0, 500-p*1e3);
      //rotate(c);
      //box(20, 20, 200);
      
      boxRow();
      pop();
    //}
  }
  
  if(record){
   //saveFrame("output3/gif###.png"); 
  }
}

void boxRow(){
  for(float amt = 0; amt <= 100; amt ++){
    //push();
    rotate(sin(PI*p));
    translate(20, 0, 0);
    box(20, 5, 2);
    //pop();
  }
}

void mousePressed(){
 record = true; 
}
