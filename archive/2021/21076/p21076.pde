import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  rectMode(CENTER);
  //blendMode(DIFFERENCE);
  //cam = new PeasyCam(this, 100);
  sphereDetail(4);
}

float t, p, i, k = 300, r = 150;
float z;
boolean record = false;
void draw() {
  background(0);

  noStroke();
  t+=0.04;
  push();
  strokeWeight(5);
  
  stroke(255*map(z, 0, 1000, 1, 0));
  fill(0);
  //fill(86,141,254,255*map(z, 0, 1000, 1, 0));
  //stroke(156,64,31,255*map(z, 0, 1000, 1, 0));
  translate(width/4+z/5, height/2+height/5, 600-z);
  rotateY(PI*(t));
  rotateX(PI*(t));
  rotateZ(PI*(t));
  sphere(80);
 
  //makes crystal structure
  translate(0, 0, 30);
  sphere(80);
 
  
  pop();
  z+=20;
  //println(map(z, 0, - 500, 1, 0));

  for (i = 0; i<k; i++) {
    p = (i+t)/k;
    //push();
    //stroke(0);
    //rotate(TAU*p);
    //translate(width/4, height/2+height/4, -10000*p+200);
    //sphere(50);
    //pop();
    for (float a = 0; a < TAU; a+=.003) {
      push();
      float x = r*cos(a);
      float y = r*sin(a);
      translate(width/3 + x+100*sqrt(p)*sin(3*TAU*p), 
        height-height/3 + y+100*cos(TAU*p), 
        -1000+5000*(p));
      fill(255*map(-1000+5000*p, -1000, 1000, .2, 1));

      float d = map(dist(x, y, width/2, height/2), 0, r, 0, 2);
      //fill(#548cfe);
      //stroke(#9e4321);
      //rotate(sin(radians(35)*TAU*p));
      //rotateY(sin(radians(85)*TAU*p));
      //translate(x*d+150, y, 0);
      square(x, y, 10*p);


      //box(20*p);
      pop();
    }
  }

  //if(frameCount<51){
  // saveFrame("output4/gif###.png"); 
  //}
  //else{exit();}
}


void mousePressed() {
  record = true;
}
