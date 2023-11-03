import peasy.*;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  rectMode(CENTER);
  //blendMode(DIFFERENCE);
  cam = new PeasyCam(this, 1000);
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
  t+=0.02;
  push();
  drawEyes(-50/1.4, 100, 50, t);
  pop();
  
  push();
  drawEyes(50/1.4, 100, 50, t);
  pop();
  
  translate(200,0, -width/2);
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
      fill(255*map(-1000+5000*p, -1000, 50, 0, 1));
      
      
      //stroke(255);
      //rotate(sin(radians(mouseX)*TAU*p));
      
      //rotate(TAU*p);
     
      float d = map(dist(x,y, width/2, height/2), 0, r, 0, 2);
      //rotateY(TAU*p);
      translate(x*d, y);
      //rotate(TAU*p);
      box(10*p);
      //rotate(6*TAU*p);
      //if(y*100*noise(x,y) < 0){
      //square(x*100*noise(x,y), y*100*noise(x,y), 10);
      //}
      //box(20*p);
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
}

void drawEyes(float x, float y, float r, float t){
  push();
  fill(255, 40);
  ellipse(x,y, r, r*1.5);
  push();
  fill(0);
  ellipse(x-(r/4)*easeInOutBack(abs(cos(TAU*t))),y,r/2, (r/2)*1.5);
  pop();
  pop();
}
