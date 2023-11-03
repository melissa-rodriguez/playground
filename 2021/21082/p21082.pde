import peasy.*;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  rectMode(CENTER);
  //blendMode(DIFFERENCE);
  cam = new PeasyCam(this, 800);
  sphereDetail(3);
}

float t, p, i, k = 100, r = 100;
boolean record = false;
void draw() {
  background(0);
  smooth(8);
  //println(mouseX);
  //noFill();
  //stroke(255);
  //strokeWeight(2);
  fill(0);
  //strokeWeight(2);
  stroke(255);
  t+=0.01;

  translate(200, 0, -width/2);
  //rotate(PI/4);
  for (i = 0; i<k; i++) {
    p = (i+t)/k;
    for (float a = 0; a < TAU; a+=.003) {
      push();
      float x = r*cos(a);
      float y = r*sin(a);
      translate(x+100*sqrt(p)*sin(TAU*p),
        y+100*cos(TAU*p),
        4000*(p));
      //fill(255*map(-1000+5000*p, -1000, 50, 0, 1));
      //fill(255*sin(TAU*(p)));



      //stroke(255);
      //rotate(sin(radians(mouseX)*TAU*p));

      //rotate(TAU*p);

      float d = map(dist(x, y, width/2, height/2), 0, r, 0, 8);
      //rotate(TAU*p);
      rotate(TAU*((p+d)+t));
      //rotateX(TAU*((p-t)-d));
      translate(x*d, y);
      rotateX(TAU*p);
      box(10*p, 80*p, 10*p);

      push();
      fill(255);
      noStroke();
      translate(random(x), random(y), random(y));
      sphere(2*sin(TAU*(p-t)));
      pop();
      //sphere(10*p);
      //rotate(6*TAU*p);
      //if(y*100*noise(x,y) < 0){
      //square(x*100*noise(x,y), y*100*noise(x,y), 10);
      //}
      //box(20*p);
      pop();
    }
  }

  //if(frameCount<101){
  // saveFrame("output3/gif###.png");
  //}
  //else{exit();}
}


void mousePressed() {
  record = true;
}
