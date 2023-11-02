import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 650);
  rectMode(CENTER);
  sphereDetail(6);
}

float spacing = 10;
float h,t;
float delta,r;
float size = 300;
void draw() {
  background(0);
  //background(240);
  strokeWeight(3);
  t+=0.01;
  rotateX(PI/2);
  rotateX(radians(35));
  rotateX(radians(111));
  println(mouseX);
  //stroke(210);
  stroke(255);
  //stroke(#D9D9D9);
  //noFill();
  fill(0);

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
  

  
  for (float y = height/2; y  > - height/2; y -= spacing) {
    push();
    //rotate(-PI*t);
    translate(0, 0, y);
    r = map(dist(0, 0, y, 0, 0, height/2), 0, height, 0, size*easeInOutExpo(abs(sin((30)))));
    delta = map(dist(0, 0, y, 0, 0, height/2), 0, height, 0, 360*easeInOutExpo(abs(cos(60))));
    rotate(radians(delta)+t);
    rect(0, 0, size+r,size+r,r);
    //box(200, 100, 10);
    
    pop();
  }
  
  
  //if(frameCount<=79){
  //saveFrame("output/gif###.png");
  //}
  
}
