Line line; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);

  line = new Line(100, 200, 1000, 1200, 5);
}

void draw() {
  background(240);

  line.showPrototype();
  line.overUnder();

  //noLoop();
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

  void showPrototype() {
    //line(x1, y1, x2, y2); 
    fill(255, 0, 0); 
    for (PVector v : vertices) {
      circle(v.x, v.y, 20);
    }


    noFill(); 

    for (Circle c : circles) {
      //c.render();
      beginShape(POINTS);
      for (PVector v : c.circleVertices) {
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    }
  }

  void overUnder() {
    push(); 
    beginShape(); 
    noFill(); 
    strokeWeight(5); 
    for (int i = 0; i < vertices.size()-1; i++) {
      Circle c = circles.get(i); 
      PVector v1 = vertices.get(i); 
      PVector v2 = vertices.get(i+1);
      float angle1 = getAngle(v1, i);
      
      //every other circle overline, underline
      if (i % 2 == 0) {
        for (float theta = angle1-PI; theta < angle1; theta+=TAU/c.numPoints) {
          float x = c.pos.x + (c.r/2)*cos(theta); 
          float y = c.pos.y + (c.r/2)*sin(theta); 
          vertex(x,y); 
          //circle(x, y, 30);
        }
      } else {
        for (float theta = angle1-PI; theta > angle1-TAU; theta-=TAU/c.numPoints) {
          float x = c.pos.x + (c.r/2)*cos(theta); 
          float y = c.pos.y + (c.r/2)*sin(theta); 
          vertex(x,y); 
          //circle(x, y, 30);
        }
      }
    }
    endShape(); 
    pop(); 
  }

  float getAngle(PVector v1, int i) {
    Circle c = circles.get(i); 
    println((c.r/2)/v1.x);
    float angle = acos((c.pos.x - v1.x)/(c.r/2)); //find the angle of the intersection pt

    return angle;
  }
}

class Circle {
  PVector pos; 
  float r; 
  int numPoints; 

  ArrayList<PVector> circleVertices; //save all the vertices of every circle 

  Circle(PVector p, float size) {
    pos = p; 
    r = size;
    numPoints = int(r/2); 

    circleVertices = new ArrayList<PVector>(); 
    createVertices();
  }

  void createVertices() {
    for (float a = 0; a < TAU; a +=TAU/numPoints) {
      float x = pos.x + (r/2)*cos(a); 
      float y = pos.y + (r/2)*sin(a); 

      circleVertices.add(new PVector(x, y));
    }
  }




  void render() {
    circle(pos.x, pos.y, r);
  }
}

void mousePressed(){
 saveFrame("render.png");  
}
