import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  cam = new PeasyCam(this, 200);
  sphereDetail(3);
}

float radius = 300;
float t, i, p, k=50;
boolean record = false;
void draw() {
  //clear();
  background(0, 7);
  t+=0.01;
  noStroke();
  lights();
  fill(255);
  rotateY(-PI/2 - PI/6);

  directionalLight(88, 141, 255, -1, 0, 0);
  //directionalLight(88,141,255, 0, 1, 0);
  //directionalLight(255,255,255, -1, 0, 0);
  //directionalLight(154,60,30, -1, 0, 0);


  //fill(85,140,255,255);
  //strokeWeight(4);
  //stroke(155,62,30,100);
  //translate(0, -radius, 0);

  //rotateX(radians(60));
  //println(60);
  //translate(0, 1000*p, 0);
  //rotate((TAU*p));

  //for (float j = 0; j< 10; j++) {
  //  float y = radius/j;
  //fill(85,140,255,255);
  //stroke(150,60,31,255);
  //strokeWeight(8);
  for (i=0; i<k; i++) {
    p=(i-t)/k;
    float y = 1200*(p);
    push();
    float d = map(dist(y, 0, 0, 0), 0, 1000, TAU/6, 0);
    rotate((p)*d);
    for (float a = 0; a < 6; a+= 1) {
      float c = a*TAU/6;
      push();
      translate((radius*(p))*cos(c), (radius*(p))*sin(c), y);
      rotate(c);
      //rotateX(c-t);
      //fill(255*map(y, );
      //sphere(radius/6);
      box(2, radius*(p), radius*(p));
      //box(5, radius/2, radius/2);
      //radius += 0.1;
      pop();
    }
    pop();
  }

  //if(record){
  // saveFrame("output/gif###.png");
  //}

  //}
}
void keyPressed() {
  if (keyPressed) {
    record = true;
  }
}
