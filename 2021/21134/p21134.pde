import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 800);
  rectMode(CENTER);
  sphereDetail(6);
}

float spacing = 10;
float h,t;
void draw() {
  background(0);
  background(240);
  strokeWeight(2);
  t+=0.02;
  rotateX(PI/2);
  rotateX(radians(35));
  println(mouseX);
  stroke(210);
  //stroke(40);
  //stroke(#D9D9D9);
  //noFill();
  fill(240);

  //square(0, 0, 300);

  //for (float y = height/2; y  > - height/2; y -= 10) {
  //    push();
  //    translate(0, 0, y);
  //    rotate(radians(map(dist(0, 0, y, 0, 0, height/2), 0, height, 0, 3*360*easeInOutExpo(abs(sin(t))))));
  //    //square(0, 0, 300);
  //    box(100, 100, 10);
  //    pop();

  //}
  //println(mouseX);
  

  
  for (float y = height/2; y  > - height/2; y -= 10) {
    push();
    rotate(-PI*t);
    translate(0, 0, y);
    rotate(radians(map(dist(0, 0, y, 0, 0, height/2), 0, height, 0, 3*360*easeInOutExpo(abs(sin(radians(30)))))));
    //square(0, 0, 300);
    box(200, 100, 10);
    
    
    push();
    stroke(100);
    //stroke(255);
    //stroke(#F2541B);
    strokeWeight(10);
    point(0, 75, 0);
    point(0, -75, 0);
    pop();
    pop();
  }
  
  
  
  
  //push();
  //rotate(-PI*t);
  //translate(0, 100, 0);
  
  //stroke(255);
  //point(0, 0, 0);
  //pop();
  //if(frameCount<=20){
  //saveFrame("output/gif###.png");
  //}
  
}
