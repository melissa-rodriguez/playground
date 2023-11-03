ArrayList<Line> lines;  

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  colorMode(HSB); 
  lines = new ArrayList<Line>(); 

  int lineCount = 50; 
  for (int i = 0; i < lineCount; i++) {
    lines.add(new Line(width/5, 0, width/5, height, 100));
  }
}

void draw() {
  background(240); 

  for (Line line : lines) {
    line.render();
  }
}

class Line {
  float x1, y1, x2, y2; 
  float noiseMax; 
  int seed; //noise seed to vary the noise space
  int subdivisions; //num of vertices
  ArrayList<PVector> vertices; //store the vertices of the line
  color strokeCol; 

  Line(float x1_, float y1_, float x2_, float y2_, int divisions) {
    x1 = x1_; 
    y1 = y1_; 
    x2 = x2_; 
    y2 = y2_; 
    subdivisions = divisions;
    noiseMax = 0.8*randomGaussian(); 
    
    seed = int(1234*sqrt(random(1))); 
    noiseSeed(seed); 
    
    //strokeCol = color(155, 255*sqrt(random(1)), 255); 
    strokeCol = color(240*sqrt(random(1))); 

    vertices = new ArrayList<PVector>(); 
    createVertices();
  }

  void createVertices() {
    for (int i = 0; i <= subdivisions; i++) {
      float xSpacing = (x2-x1)/subdivisions; 
      float ySpacing = (y2-y1)/subdivisions; 
      float x = x1 + xSpacing * i; 
      float y = y1 + ySpacing * i;
      float d = dist(x1, y1, x2, y2); //distance between points 

      float xoff = map(x, 0, x1 + xSpacing * subdivisions, 0, noiseMax); 
      float yoff = map(y, 0, y1 + ySpacing * subdivisions, 0, noiseMax); 
      float n = noise(xoff, yoff); 
      float slope = (y2 - y1)/((x2 - x1) + 0.01); //adding 0.01 in the case that x2-x1 = 0 (vertical line)

      float xNoise = map(slope, 0, d/0.01, 0, n); //map the x noise more as the line is more vertical 
      float yNoise = map(slope, 0, d/0.01, n, 0); //map the y noise more as the line is more horizontal 


      //circle(x, y, 30);
      vertices.add(new PVector(x + x*xNoise, y + y*yNoise));
    }
  }

  void render() {
    //line(x1, y1, x2, y2);

    beginShape(); 
    noFill(); 
    strokeWeight(5); 
    stroke(strokeCol);
    for (PVector v : vertices) {
      vertex(v.x, v.y);
    }
    endShape();
    
    beginShape(); 
    noFill(); 
    strokeWeight(2); 
    stroke(0);
    for (PVector v : vertices) {
      vertex(v.x, v.y);
    }
    endShape();
  }
}

void mousePressed(){
 saveFrame("render.png");  
}
