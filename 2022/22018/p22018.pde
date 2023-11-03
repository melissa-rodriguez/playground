ArrayList<Brush> brushes;

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);

  //background(0); 

  colorMode(HSB); 
  //background(0); 
  //background(160, 20, 255); 
  background(160, 255, 60); 
  //background(15, 255, 255); 

  brushes = new ArrayList<Brush>();

  int num = 10; //numbrushes 
  for (int i = 0; i < num; i++) {
    float x = map(i, 0, num, width/4, width-width/4); 
    float y = 0; 
    PVector pos = new PVector(x, y);
    brushes.add(new Brush(pos, 110, 0.9));
  }

  //brush = new Brush(100, 0.9);
}

float speed = 2; 
float t; 
float x, y; 
void draw() {


  //if (y > height/3) {
  //  t+=radians(2);
  //}else if(y > height-height/3){

  //}

  //if (y < height/3 || y > height-height/3) {
  //  t = 0;
  //} else {
    t+=radians(1.5);
  //}
  //brush.render(); 

  for (Brush b : brushes) {
    push();
    float phase = map(b.brushPos.x, 0, width, 0, PI); 
    translate(x+100*cos(t+phase), y+50*sin(t)); 
    b.render();
    pop();
  }
  y+=speed;
}

class Brush {
  PVector brushPos; 
  float size; //size of brush
  float r; 
  float res; //resolution of brush, number between 0 and 1
  int numPoints; 

  ArrayList<brushPoint> bPoints = new ArrayList<brushPoint>(); 

  Brush(PVector p, float s, float resolution) {
    brushPos = p; 
    size = s; 
    res = resolution; 
    numPoints = int(res*300); //300 being the max number of points

    initBrush();
  }

  void initBrush() {
    //create the brush made up of a set of brush points
    for (int i = 0; i < numPoints; i++) {
      float theta = map(i, 0, numPoints, 0, TAU); 
      bPoints.add(new brushPoint(brushPos, size, theta));
    }
  }

  void render() {
    for (brushPoint pt : bPoints) {
      stroke(pt.col); 
      strokeWeight(pt.sw); 
      point(brushPos.x + pt.pos.x, brushPos.y + pt.pos.y);
    }
  }
}

class brushPoint {
  //i want this class to store the position and color/stroke of each point
  PVector pos; 
  color col; 
  float sw; 
  brushPoint(PVector brushPos, float size, float theta) {
    float r = size*sqrt(random(1)); 
    sw = 4*sqrt(random(1));
    pos = new PVector(r*cos(theta), r*sin(theta)); 
    //col = color(160, 255*map(mag(pos.x, pos.y), 0, size, 1, 0.1), 255); //blue
    //col = color(160, 255*map(mag(pos.x, pos.y), 0, size, 1, 0.1), 255); //blue
    col = color(160, map(brushPos.x, width/4, width-width/4, 100, 255)*map(mag(pos.x, pos.y), 0, size, 1, 0.5), 255); //blue
    //col = color(20, 255*map(mag(pos.x, pos.y), 0, size, 1, 0.2), 255);
  }
}

void mousePressed(){
 saveFrame("render.png");  
}
