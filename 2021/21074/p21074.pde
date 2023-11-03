void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  rectMode(CENTER);
  //blendMode(DIFFERENCE);
}

float t, p, i, k = 100, r = 100;
boolean record = false;
void draw() {
  background(0);
  //println(mouseX);
  //noFill();
  //stroke(255);
  //strokeWeight(2);
  noStroke();
  t+=0.01;
  translate(200,0, -width/2);
  //rotate(PI/4);
  for (i = 0; i<k; i++) {
    p = (i+t)/k;
    for (float a = 0; a < TAU; a+=.008) {
      push();
      float x = r*cos(a);
      float y = r*sin(a);
      translate(width/3 + x+100*sqrt(p)*sin(TAU*p), 
                height-height/3 + y+100*cos(TAU*p),
                -1000-5000*(p));
      fill(255*map(-1000+5000*p, -1000, 50, .2, 1));
      //stroke(255);
      //rotate(sin(radians(mouseX)*TAU*p));
      
      //rotate(TAU*p);
     
      float d = map(dist(x,y, width/2, height/2), 0, r, 0, 2);
      square(x*d, y, 10*p);
      //rotate(6*TAU*p);
      //if(y*100*noise(x,y) < 0){
      square(x*100*noise(x,y), y*100*noise(x,y), 10);
      //}
      //box(20*p);
      pop();
    }
  }

  //if(frameCount<51){
  // saveFrame("output2/gif###.png"); 
  //}
  //else{exit();}
}


void mousePressed() {
  record = true;
}
