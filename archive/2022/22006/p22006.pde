//ALL I AM VARYING IS THE XSIZE, YSIZE AND WHETHER X*N OR Y*N
ArrayList<Box> boxes; 
OpenSimplexNoise noise;
import peasy.*;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);

  noise = new OpenSimplexNoise();

  cam = new PeasyCam(this, 1500);
  boxes = new ArrayList<Box>();

  //int amt = 5; 
  float ysize = 200; 
  float xsize = 500; 
  for (float x = -width/2; x <= width/2; x+=xsize) {
    for (float y = -height/2; y <= height/2; y+= ysize) {
      boxes.add(new Box(new PVector(x/2, y), xsize, ysize));
    }
  }



  rectMode(CENTER);
}

void draw() {
  background(240);
  //translate(50,0); 

  for (Box b : boxes) {
    //b.outline();
    b.dots();
  }
}

class Box {
  float w, h; 
  PVector pos; 
  Box(PVector p, float w_, float h_) {
    pos = p; 
    w = w_; 
    h = h_;
  }

  void outline() {
    push();
    noFill();
    stroke(0); 
    //strokeWeight(2); 
    rect(pos.x, pos.y, w, h);
    pop();
  }

  void dots() {
    push();
    float sw = map(pos.y, -height/2, height/2, 1, 4); 
    strokeWeight(sw); 

    int ires = int(w/10); 
    int jres = int(h/10); 
    translate(pos.x, pos.y); 
    for (int i = 0; i <= ires; i++) {
      for (int j = 0; j <= jres; j++) {
        float x = map(i, 0, ires, -w/2, w/2);
        float y = map(j, 0, jres, -h/2, h/2); 
        //float n = map((float)noise.eval(x*0.01,y*0.01), -1, 1, 0, 1);
        float n = (float)noise.eval(x*0.01, y*0.01);
        point(x*n+y*n, y);
      }
    }

    pop();
  }
}

void mousePressed(){
 saveFrame("render.png");  
}
