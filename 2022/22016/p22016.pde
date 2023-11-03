OpenSimplexNoise noise; 

Brush brush;

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  background(240);

  noise = new OpenSimplexNoise(); 

  brush = new Brush(10, .02); 

  colorMode(HSB);
}

float t; 
float off; 
void draw() {
  t+=radians(2); 
  //background(240); 
  //translate(width/2, height/2); 
  push();
  translate(100*cos(t), 100*sin(t)); 

  for (int i = 0; i < 10; i++) {
    push();
    translate(map(i, 0, 10, -width, width), 0); 
    brush.renderBrush();
    pop();
  }
  pop();

  off+=1; 

  //noLoop();
}

class Brush {
  float size; //size of brush
  float r; 
  float res; //between 0, 1 
  int numPoints; 

  PVector points[]; 


  Brush(float s, float resolution) {
    size = s; 
    res = resolution; 
    numPoints = int(res*500);

    points = new PVector[numPoints + 1]; 

    initBrush();
  }

  void initBrush() {
    for (int i = 0; i < numPoints; i++) {
      float a = map(i, 0, numPoints, 0, TAU); 
      points[i] = randPoints(a);
    }
  }


  void renderBrush() {
    strokeWeight(3);
    //stroke(0, 20); 

    for (int i = 0; i < numPoints; i++) {
      PVector v = points[i]; 
      stroke(map(mag(v.x, v.y), 0, 10, 255, 0)); 
      point(v.x+off, v.y+off);
    }



    //for (float a = 0; a < TAU; a += TAU/numPoints) {

    //  point(x, y);
    //}
  }

  PVector randPoints(float a) {
    r = size*sqrt(random(1)); 

    float x = r*cos(a); 
    float y = r*sin(a);

    return new PVector(x, y);
  }
}

void mousePressed(){
 saveFrame("render.png");  
}
