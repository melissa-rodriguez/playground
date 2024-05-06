
ArrayList<Hexagon> hexagons = new ArrayList<Hexagon>(); 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  
  hexagons.add(new Hexagon(100)); 
}


void draw() {
  background(0);
  translate(width/2, height/2);
  
  for(Hexagon hex : hexagons){
   hex.renderHexagon();  
  }
}

void mousePressed() {
  saveFrame("output.png");
}

class Triangle { 
  PVector v1; 
  PVector v2; 
  PVector v3; 
  float size; 
  float a;
  float t; 

  Triangle(float s, float angle) {
    size = s;
    a = angle;

    strokeWeight(5);
    stroke(255); 
    noFill();
  }

  void renderTriangle() {
    v1 = new PVector(0, - size);
    v2 = new PVector(0, - size).rotate(radians(120));
    v3 = new PVector(0, - size).rotate(radians(-120));

    push();
    rotate(a); 
    translate(0, size); 

    beginShape();
    vertex(v1.x, v1.y); 
    vertex(v2.x, v2.y); 
    vertex(v3.x, v3.y);
    endShape(CLOSE);
    pop();
  }
}

class Hexagon {
  ArrayList<Triangle> triangles = new ArrayList<Triangle>(); 
  float size; //size of each hexagon

  Hexagon(float s) {
    size = s; 

    for (int a = 0; a < 360; a+=60) {
      triangles.add(new Triangle(size, radians(a)));
    }
  }

  void renderHexagon() {
    for (Triangle t : triangles) {
      t.renderTriangle();
    }
  }
}
