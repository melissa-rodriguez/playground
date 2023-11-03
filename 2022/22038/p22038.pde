ArrayList<Arc> arcs; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  colorMode(HSB); 
  arcs = new ArrayList<Arc>(); 
  int amt = 1; 

  for (int i = 0; i < amt; i++) {
    Point pt1 = new Point(width/2 - 200, height/2); 
    Point pt2 = new Point(width/2 + 200, height/2); 

    arcs.add(new Arc(pt1, pt2));
  }
}

void draw() {
  background(240);




  for(Arc arc : arcs){
   arc.render();  
  }
  //saveFrame("output.png"); 
  noLoop();
}

class Point {
  PVector pos; 
  Point(float xpos, float ypos) {
    pos = new PVector(xpos, ypos);
  }

  void render() {
    float size = 20; 
    stroke(0, 255, 255); 
    line(pos.x - size/2, pos.y, pos.x + size/2, pos.y); 
    line(pos.x, pos.y - size/2, pos.x, pos.y + size/2);
  }
}

class Arc {
  Point point1, point2; 

  int numArcs = 1; 
  float len; //length of arc that connects points (num between 0.5, 4); 

  Arc(Point pt1, Point pt2) {
    point1 = pt1; 
    point2 = pt2;

    len = random(0.5, 4);
  }

  void render() {
    point1.render(); 
    point2.render(); 
    arcBetweenPoints(point1, point2);
  }

  void arcBetweenPoints(Point point1, Point point2) {
    PVector center = point1.pos.add(point2.pos).div(2); 
    float size = dist(point1.pos.x, point1.pos.y, point2.pos.x, point2.pos.y); 
    noFill(); 
    stroke(20, 50);
    strokeWeight(1.5); 
    arc(center.x, center.y, size*2, size*len, 0, PI);
  }
}
