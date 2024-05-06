
import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  cam = new PeasyCam(this, 500);
}

float p, i, t, k = 10;
float size = 80;
void draw() {
  //background(240);
  background(0);
  rectMode(CENTER);
  strokeWeight(3);
  t+=0.01;
  stroke(255);
  rotateY(PI/4);
  rotateX(PI/4);
  
  push();
  rotateX(PI/2);
  translate(size, 0, 0);
  for (i = 0; i < k; i++) {
    p = (i+t)/k;
    push();
    rotateX(PI/2);

    rotateY(TAU*p);
    translate(0, 0, size*2);
    
    fill(0);
    square(0, 0, size);
    line(0, -size/4, 0, size/4);
    line(-size/4, 0, size/4, 0);
    pop();
    
    for(float a = 0; a < TAU; a +=.1){
    push();
    rotateX(PI/2);

    rotateY(TAU*p);
    translate(0, 0, size*2);
    rotateX(sin(a));
    
    fill(0);
    square(0, 0, size);
    line(0, -size/4, 0, size/4);
    line(-size/4, 0, size/4, 0);
    pop();
    }
  }
  pop();
  
  
  push();
  for (i = 0; i < k; i++) {
    p = (i+t)/k;
    push();
    rotateX(PI/2);

    rotateY(TAU*p);
    translate(0, 0, size*2);
    
    fill(0, 20);
    square(0, 0, size);
    line(0, -size/4, 0, size/4);
    line(-size/4, 0, size/4, 0);
    pop();
    
    for(float a = 0; a < TAU; a +=.1){
    push();
    rotateX(PI/2);

    rotateY(TAU*p);
    translate(0, 0, size*2);
    rotateX(sin(a));
    
    fill(0, 20);
    square(0, 0, size);
    line(0, -size/4, 0, size/4);
    line(-size/4, 0, size/4, 0);
    pop();
    }
  }
  pop();
  
  if(t>1){
   t=0; 
  }
  
  //if(t<1){
  // saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
}
