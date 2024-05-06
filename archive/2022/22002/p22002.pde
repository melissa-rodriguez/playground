ArrayList<Shape> shapes;
OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);

  noise = new OpenSimplexNoise();

  rectMode(CENTER);
  colorMode(HSB);

  shapes = new ArrayList<Shape>();
  
  int amt = 10; 
  for(int i = 0; i <= amt; i++){
   float x = map(i, 0, amt, -width/2, width/2);
   float y = 0; 
   PVector pos = new PVector(x,y); 
   int direction = round(random(0,1)); 
   float noiseFactor = constrain(0.3*randomGaussian(), 0.001, 0.01); 
   shapes.add(new Shape(direction, pos, noiseFactor));
  }
  

}


void draw() {
  background(240); 
  translate(width/2, height/2-65, - 700);
  rotate(PI/2);
  println(mouseX);

  for (Shape s : shapes) {
    s.show();
  }

  strokeWeight(1.5);
 
}

class Shape {
  int ires;
  int r; 
  float startAngle1, startAngle2, stopAngle; //start and stop angle of the arc
  float start, stop; 
  float sw; //strokeweight
  PVector shapePos; 

  int direction; 
  
  float scale; //noise variation amount

  Shape(int d, PVector p, float s) {
    ires = 888;
    r = 200;
    startAngle1 = -PI;
    startAngle2 = -PI/2;
    
    shapePos = p; 

    direction = d; 
    
    scale = s; 

    //startAngle1 = constrain((-PI)*randomGaussian(), -TAU, TAU);
    //startAngle2 = constrain((-PI/2)*randomGaussian(),-TAU, TAU);
  }

  void show() {
    noFill();
    push();
    translate(shapePos.x, shapePos.y);

    for (int i = 0; i < ires; i++) {
      float a = map(i, 0, ires, 0, TAU); 
      float x = 300*cos(a);
      float y = 300*sin(a); 
      
      float n = (float)noise.eval(x*scale, y*scale); 
      stopAngle = map(n, -1, 1, 0, PI/4);
      float noiseRadius = map(n, -1, 1, 0, 1);
      //float start = -PI;
      //float stop = -PI/2;

      start = map(i, 0, ires, startAngle1, startAngle1 + stopAngle + TAU);
      stop = map(i, 0, ires, startAngle2, startAngle2  + stopAngle + TAU);
      if (direction == 0) {
        r = int(map(i, 0, ires, 5*noiseRadius, 400*noiseRadius));
      } else if (direction == 1) {
        r = int(map(i, 0, ires, 400*noiseRadius, 5*noiseRadius));
      }
      stroke(map(i, 0, ires, 0, 100),100); 
      arc(x+r/2, y, r, r/2, start, stop);
      //circle(x, y, 20);
    }
    pop();
  }
}

void mousePressed(){
 saveFrame("render.png"); 
}
