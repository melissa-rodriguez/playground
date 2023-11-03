void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  rectMode(CENTER);
  //blendMode(DIFFERENCE);
}

float t, p, i, k = 300, r = 200;
boolean record = false;
void draw() {
  background(0);
  //println(mouseX);
  //noFill();
  //stroke(255);
  //strokeWeight(2);
  noStroke();
  t+=0.04;
  translate(200,0, -width/2);
  //rotate(PI/4);
  for (i = 0; i<k; i++) {
    p = (i+t)/k;
    for (float a = 0; a < TAU; a+=.008) {
      push();
      float x = r*cos(a);
      float y = r*sin(a);
      translate(width/3 + x+100*sqrt(p)*sin(3*TAU*p), 
                height-height/3 + y+100*cos(TAU*p),
                -1000+5000*(p));
      fill(255*map(-1000+5000*p, -1000, 1000, .2, 1));
   
      float d = map(dist(x,y, width/2, height/2), 0, r, 0, 2);
      //fill(#548cfe);
      //stroke(#9e4321);
      rotate(sin(radians(35)*TAU*p));
      rotateY(sin(radians(85)*TAU*p));
      //translate(x*d+150, y, 0);
      square(x*d, y, 10*p);
      //box(20*p);
      pop();
   
    }
  }

  //if(frameCount<26){
  // saveFrame("output4/gif###.png"); 
  //}
  //else{exit();}
}


void mousePressed() {
  record = true;
}
