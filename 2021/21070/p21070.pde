float inc = 0.1;
int scl = 10;
float zoff = 0;

int cols;
int rows;

int noOfPoints = 2000;

Particles[] particles = new Particles[noOfPoints];
PVector[] flowField;

OpenSimplexNoise noise;

import peasy.*;

PeasyCam cam;
PGraphics pg;
PShader blur;

void settings() {
  size(1080, 1080, P3D);
}

void setup() {
  noise = new OpenSimplexNoise();
  cam = new PeasyCam(this, 1300);
  pg = createGraphics(1080, 1080, P3D);
  background(0);
  blur = loadShader("blur.glsl"); 
  
  //hint(DISABLE_DEPTH_MASK);

  cols = floor(width/scl);
  rows = floor(height/scl);

  flowField = new PVector[(cols*rows)];

  for (int i = 0; i < noOfPoints; i++) {
    particles[i] = new Particles();
  }
}
int loops = 100;
void draw() {
  //clear();
  //rect(0,0,width,height);
  noFill();
  //filter(blur);
  //for (int l = 0; l < loops; l++) {
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        int index = (x + y * cols);

        float angle = (float)noise.eval(xoff, yoff, zoff) * TWO_PI;
        PVector v = PVector.fromAngle(angle);
        //v.setMag(0.01);
        v.normalize();

        flowField[index] = new PVector(round(v.x), round(v.y), round(v.z)).mult(3);

        stroke(0, 50);

        //pushMatrix();

        //translate(x*scl, y*scl);
        //rotate(v.heading());
        //line(0, 0, scl, 0);

        //popMatrix();

        xoff = xoff + inc;
      }
      yoff = yoff + inc;
    }
    zoff = zoff + (inc / 50);

    //if(frameCount < 360){
    for (int i = 0; i < particles.length; i++) {
      particles[i].follow(flowField);
      particles[i].update();
      particles[i].edges();
      particles[i].show();
    //}
    }
    
    //if(frameCount<380){
    //saveFrame("output/gif###.png");
    //}
    //else{exit();}
  //}
}
