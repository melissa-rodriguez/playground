void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  rectMode(CENTER);
  //blendMode(DIFFERENCE);
}

float t, p, i, k = 200, r = 400;
boolean record = false;
void draw() {
  background(0);
  //noFill();
  //stroke(255);
  //strokeWeight(2);
  noStroke();
  t+=0.02;

  for (i = 0; i<k; i++) {
    p = (i+t)/k;
    for (float a = 0; a < TAU; a+=.005) {
      push();
      float x = r*cos(a);
      float y = r*sin(a);
      translate(width/3 + x+200*sin(TAU*p), 
                height-height/3 + y+200*cos(TAU*p),
                -1000+5000*(p));
      fill(255*map(-1000+5000*p, -1000, 100, 0.2, 1));
      rotate(6*sin(TAU*p));

      //push();
      //fill(0);
      //square(0,y,20*p+5);
      //pop();
      circle(0, y, 30*(p)); 
      
      //square(x, 0, 10);
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
