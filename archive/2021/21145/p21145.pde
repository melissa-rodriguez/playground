import peasy.*;
PeasyCam cam;

OpenSimplexNoise noise;

void setup() {
  size(1080, 1080, P3D);
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
  t+=.04;
  strokeWeight(10);
  
  float phase;
  
  //for(float x = - width/2 + 2*r; x < width/2 - 2*r; x += r*2){
  // PVector pos = new PVector(x, 0);
  // phase = map(dist(x, 0, width/2, 0), 0, width/2, 0, PI);
  // drawCircle(pos, r, phase); 
  //}
  
  drawCircle(new PVector(0, 0), 350, 0);
  
 

}

void drawCircle(PVector pos, float size,float phase){
   beginShape();
  for (float a = 0; a <= TAU; a += TAU/numPoints) {
      float xoff = map(easeInOutExpo(sin(a+t)), -1, 1, 0, noiseMax);
      float yoff = map(sin(a+phase), -1, 1, 0, noiseMax);

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
