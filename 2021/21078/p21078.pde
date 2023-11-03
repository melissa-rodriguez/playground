import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  rectMode(CENTER);
  //blendMode(DIFFERENCE);
  //cam = new PeasyCam(this, 100);
  sphereDetail(4);
}

float t, p, i, k = 100, r = 500, count;
boolean record = false;
void draw() {
  background(0);
  //println(mouseX,mouseY);
  //noFill();
  //stroke(255);
  //strokeWeight(2);
  noStroke();
  t+=0.02;
  translate(200, 0, -width/2);
  //rotate(PI/4);
  for (i = 0; i<k; i++) {
    p = (i+t)/k;
    for (float a = 0; a < TAU; a+=.008) {
      push();
      float x = r*cos(a);
      float y = r*sin(a);

      push();
      stroke(0);
      translate(width/3 + x+100*sqrt(p)*sin(TAU*p), 
        height/2+50 + y+100*cos(TAU*p), 
        -1000+5000*(p));
      box(10*p); //rings
      pop();

      push();
      //fill(255);
      stroke(0);
      translate(width/2-200, 
        height/2+40, 
        -1000+5000*(p));
      rotate(TAU*p);
      sphere(10*p); // sphere line
      pop();

      translate(width/3 + x+100*sqrt(p)*sin(TAU*p), 
        height-height/3 + y+100*cos(TAU*p), 
        -1000-5000*(p));
      //fill(255*map(-1000+5000*p, -1000, 50, .2, 1));
      fill(255*(p));


      rotate(sin(radians(55)*TAU*p));


      float d = map(dist(x, y, 0/2, 0/2), 0, r, 0, 2);
      push();
      translate(x*d, y, y*sin(TAU*p));

      box(10*p); //snake thing
      pop();

      push();
      box(10*p); //inner snake thing
      pop();

      pop();
    }
  }

  //if(frameCount<51){
  // saveFrame("output3/gif###.png"); 
  //}
  //else{exit();}
}


void mousePressed() {
  record = true;
  count++;
}
