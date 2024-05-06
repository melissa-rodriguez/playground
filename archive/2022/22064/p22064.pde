Line line; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);

  line = new Line(100, 200, 1000, 800, 5);
}

void draw() {
  background(240);

  line.render();
}

class Line {
  float x1, y1, x2, y2; 
  int subdivisions; //num of vertices/circles 
  ArrayList<PVector> vertices; //store the location of all the vertices
  ArrayList<Circle> circles; 

  Line(float x1_, float y1_, float x2_, float y2_, int divisions) {
    x1 = x1_; 
    y1 = y1_; 
    x2 = x2_; 
    y2 = y2_; 
    subdivisions = divisions;

    vertices = new ArrayList<PVector>(); 
    circles = new ArrayList<Circle>();

    createVertices();
    createChain();
  }

  void createVertices() {
    for (int i = 0; i <= subdivisions; i++) {
      float xSpacing = (x2 - x1)/subdivisions; 
      float ySpacing = (y2 - y1)/subdivisions; 

      float x = x1 + xSpacing * i; 
      float y = y1 + ySpacing * i; 

      //randomize the distance between vertices (aka circle radius)
      if (i > 0) { 
        float randomeSpacing = random(i-1, i); 
        x = x1 + xSpacing * randomeSpacing; 
        y = y1 + ySpacing * randomeSpacing;
      }


      vertices.add(new PVector(x, y)); 
      //circles.add(new Circle(new PVector(x, y), 20));
    }
  }

  void createChain() {
    for (int i = 0; i < vertices.size()-1; i++) {
      PVector v1 = vertices.get(i); 
      PVector v2 = vertices.get(i+1);
      
      float d = dist(v1.x, v1.y, v2.x, v2.y); //will be size of circle
      PVector center = new PVector(v2.x - v1.x, v2.y - v1.y).setMag(d/2); //center between vertices
      
      PVector circlePos = new PVector(v1.x, v1.y).add(center);
      circles.add(new Circle(circlePos, d));
    }
  }

  void render() {
    line(x1, y1, x2, y2); 
    fill(255, 0, 0); 
    for (PVector v : vertices) {
      circle(v.x, v.y, 20);
    }


    noFill(); 
    for (Circle c : circles) {
      c.render();
    }
  }
}

class Circle {
  PVector pos; 
  float r; 
  Circle(PVector p, float size) {
    pos = p; 
    r = size;
  }

  void render() {
    circle(pos.x, pos.y, r);
  }
}

void mousePressed(){
 saveFrame("render.png");  
}
