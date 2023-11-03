//Line line; 
ArrayList<Line> lines; 

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  lines = new ArrayList<Line>(); 

  for (int i = 0; i < 1; i++) {
    lines.add(new Line(width/2, 0, width/2, height, 20));
  }
}

void draw() {
  background(240);

  for (Line line : lines) {
    //line.showPrototype();
    line.showOverUnder();
  }

  //noLoop();
}

class Line {
  float x1, y1, x2, y2; 
  int subdivisions; //num of vertices/circles 
  ArrayList<PVector> vertices; //store the location of all the vertices
  ArrayList<Circle> circles; 
  ArrayList<PVector> overUnderVertices; //store the points needed to connect the overunder line

  boolean withNoise = false; //will the vertices have noise (straight line vs wobbly)
  float noiseMax; //amt of wobbliness
  int seed; //noise seed to vary the noise space

  boolean withBrush = true; //does the outline have a texture (brush class)
  ArrayList<Brush> brushPoints; 
  
  float lineWeight; //strokeWeight of the outline

  Line(float x1_, float y1_, float x2_, float y2_, int divisions) {
    x1 = x1_; 
    y1 = y1_; 
    x2 = x2_; 
    y2 = y2_; 
    subdivisions = divisions;

    vertices = new ArrayList<PVector>(); 
    circles = new ArrayList<Circle>();
    overUnderVertices = new ArrayList<PVector>(); 

    noiseMax = 1.5; //amt of wobbliness
    seed = int(1234*sqrt(random(1))); 
    noiseSeed(seed); 

    brushPoints = new ArrayList<Brush>(); //store the brush points (vertices circle outline)

    lineWeight = 20; 

    createVertices(withNoise); //creates centerpoints of circles
    createChain(); //creates the actual circle chain
    overUnder(); //creates the vertices that need to be connected for overunder
  }

  void createVertices(boolean withNoise) {
    if (!withNoise) {
      //straight line, no wobble
      for (int i = 0; i <= subdivisions+1; i++) {
        float xSpacing = (x2 - x1)/subdivisions; 
        float ySpacing = (y2 - y1)/subdivisions; 

        float x = x1 + xSpacing * i; 
        float y = y1 + ySpacing * i; 

        //randomize the distance between vertices (aka circle radius)
        if (i > 0) { 
          float randomSpacing = random(i-1, i); 
          x = x1 + xSpacing * randomSpacing; 
          y = y1 + ySpacing * randomSpacing;
        }


        vertices.add(new PVector(x, y)); 
        //circles.add(new Circle(new PVector(x, y), 20));
      }
    } else {
      for (int i = 0; i <= subdivisions+1; i++) {
        float xSpacing = (x2 - x1)/subdivisions; 
        float ySpacing = (y2 - y1)/subdivisions; 
        float dx = xSpacing * i;
        float dy = ySpacing * i;

        float x = x1 + dx; 
        float y = y1 + dy; 

        //randomize the distance between vertices (aka circle radius)
        if (i > 0) { 
          float randomSpacing = random(i-1, i); 
          dx = xSpacing * randomSpacing;
          dy = ySpacing * randomSpacing;
          x = x1 + dx; 
          y = y1 + dy;
        }

        float d = dist(x1, y1, x2, y2); //distance between points 

        float xoff = map(x, 0, x1 + xSpacing * subdivisions, 0, noiseMax); 
        float yoff = map(y, 0, y1 + ySpacing * subdivisions, 0, noiseMax); 
        float n = noise(xoff, yoff); 
        float slope = (y2 - y1)/((x2 - x1) + 0.01); //adding 0.01 in the case that x2-x1 = 0 (vertical line)

        float xNoise = map(slope, 0, d/0.01, 0, n); //map the x noise more as the line is more vertical 
        float yNoise = map(slope, 0, d/0.01, n, 0); //map the y noise more as the line is more horizontal 


        vertices.add(new PVector(x + x*xNoise, y + y*yNoise)); 
        //circles.add(new Circle(new PVector(x, y), 20));
      }
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
          //vertex(x, y); 

          overUnderVertices.add(new PVector(x, y)); 

          float brushSize = lineWeight; 
          int res = int(brushSize*2); //how many points will bein the brush
          brushPoints.add(new Brush(new PVector(x, y), brushSize, res)); 
          //circle(x, y, 30);
        }
      } else {
        for (float theta = angle1-PI; theta > angle1-TAU; theta-=TAU/c.numPoints) {
          float x = c.pos.x + (c.r/2)*cos(theta); 
          float y = c.pos.y + (c.r/2)*sin(theta); 
          //vertex(x, y); 

          overUnderVertices.add(new PVector(x, y)); 

          float brushSize = lineWeight; 
          int res = int(brushSize*2); //how many points will bein the brush
          brushPoints.add(new Brush(new PVector(x, y), brushSize, res)); 
          //circle(x, y, 30);
        }
      }
    }
  }


  float getAngle(PVector v1, int i) {
    Circle c = circles.get(i); 
    float angle = acos((c.pos.x - v1.x)/(c.r/2)); //find the angle of the intersection pt

    return angle;
  }

  void showOverUnder() {
    if (!withBrush) {
      beginShape(); 
      noFill(); 
      strokeWeight(lineWeight); 
      for (PVector v : overUnderVertices) {
        vertex(v.x, v.y);
      }
      endShape();
    } else {
      for (Brush brushPt : brushPoints) {
        brushPt.render();
      }
    }
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

  void mousePressed() {
    saveFrame("render.png");
  }
