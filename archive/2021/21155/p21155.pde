import peasy.*;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);


  cam = new PeasyCam(this, 3200);
}

float p, i, t, a, k = 20;
float count = 1;
float res, r;
void draw() {
  background(0);
  t+=radians(1)*20;

  stroke(255);
  strokeWeight(5);
  noFill();
  r = 100;
  res = 15;
  //placeThing(r);
  
  placeGridSwirls();
  
  //saveFrame("output/gif###.png");
}

void placeGridSwirls() {
  for (float n1 = 0; n1 < res; n1++) {
    for (float n2 = 0; n2 < res; n2++) {
      float x = map(n1, 0, res, -width*2, width*2);
      float y = map(n2, 0, res, -height*2, height*2);
      float a = map(n1, 0, res, 0, TAU);
      float phase = map(mag(x, y), 0, width*2, 0, 6*TAU);

      if (mag(x, y)<1500) {
        push();
        translate(x, y);
        placeSwirl(r, phase);
        pop();
      }
    }
  }
}

void placeSwirl(float r, float phase) {
  beginShape();
  for (i = 0; i<k; i++) {
    p = (i+t)/k;
    float x = (r)*easeInExpo(sin(p*(PI/2)+phase));
    float dim = map(easeInExpo(sin(p*(PI/2)+phase)), 0, 1, 0.2, 1);
    //stroke(255*dim);
    vertex(x*cos(a), x*sin(a));
    a= map(i, 0, k, 0, TAU);
  }
  endShape();
}

void mousePressed() {
  count++;
  println(count);
}
