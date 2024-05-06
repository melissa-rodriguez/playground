import peasy.*;
PeasyCam cam;

OpenSimplexNoise noise;

void setup() {
  size(2000, 2000, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 800);
  noiseSeed(1000);
  noise = new OpenSimplexNoise();
}


float count = 1;
float noiseMax = 1;
float numPoints = 400;
float t;
float r = 100;
void draw() {
  background(0);
  noFill();
  stroke(255);
  t+=.08;
  strokeWeight(10);

  //float phase;

  //for(float x = - width/2 + 2*r; x < width/2 - 2*r; x += r*2){
  // PVector pos = new PVector(x, 0);
  // phase = map(dist(x, 0, width/2, 0), 0, width/2, 0, PI);
  // drawCircle(pos, r, phase); 
  //}
  float scale = 1;
  float ires = 10*scale;
  float jres = 10*scale;
  float size = 100/scale;
  float dx = (width/ires);
  float dy = (height/jres);

  translate(-width/2, -height/2);

  for (int i = 0; i < ires; i++) {
    for (int j = 0; j < jres; j++) {
      //float x = map(i, 0, ires, -width/2 + mouseX, width/2-mouseX);
      //float y = map(j, 0, jres, -height/2+size, height/2-size);

      float x = i*dx;
      float y = j*dy;
      if (x>width/3 && x < width-width/3 && y > height/3 && y < height - height/3) {
        float d = dist(x, y, 0, 0);
        //println(d);
        float phase = map(d, 0, width/3, 0, PI);
        drawCircle(new PVector(x, y), size, phase);
      }
    }
  }
}


void drawCircle(PVector pos, float size, float phase) {
  beginShape();
  for (float a = 0; a <= TAU; a += TAU/numPoints) {
    float xoff = map(easeInElastic(sin(a+phase+t)), -1, 1, 0, noiseMax);
    float yoff = map(easeInElastic(sin(a)), -1, 1, 0, noiseMax);

    //float r = map(noise(xoff, yoff), 0, 1, 50, 100);
    float r = map((float)noise.eval(xoff*5, yoff*5), -1, 1, size/2, size);
    float x = (r)*(cos(a));
    float y = (r)*(sin(a));
    //float y = (r)*(sin(a))*easeInOutExpo(sin(a+t));
    curveVertex(pos.x + x, pos.y + y);
  }
  endShape(CLOSE);

  //saveFrame("output/gif###.png");
  
}

void mousePressed() {
  count ++;
  println(count);
}

//do sketchbook sundays post incomplete/in progress/experiments work + inspo
