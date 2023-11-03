Chain chain; 
void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);

  colorMode(HSB); 
  
  int chainLength = 20; 
  chain = new Chain(chainLength);
}

void draw() {
  background(240);

  chain.render();
}


class Chain {
  int len; //length of chain (amt of circles)
  ArrayList<Circle> links; 

  Chain(int l) {
    len = l; 
    links = new ArrayList<Circle>(); 

    createChain();
  }

  void createChain() {
    for (int i = 0; i < len; i++) {
      PVector pos = new PVector(width/2, height/2); 
      float size = 1080 - (1080/len)*i; 

      links.add(new Circle(pos.x, pos.y, size));
    }
  }

  void render() {
    //for (Circle link : links) {
    //  //link.showVertices(); 
    //  link.shapeVertices();
    //}
    
    for(int i = 0; i < links.size(); i++){
     Circle link = links.get(i);  
     //println(i); 
     color col = color(155, map(i, 0, links.size(), 255, 0), 255);
     link.shapeVertices(col);
    }
  }
}


class Circle {
  PVector pos; 
  float r; 
  ArrayList<PVector> vertices; 

  Circle(float x, float y, float size) {
    pos = new PVector(x, y); 
    r = size;
    
    noiseSeed(int(r)); 

    vertices = new ArrayList<PVector>(); //store the vertices of each circle object
    createVertices();
  }

  void createVertices() {
    int numPoints = 100; //dial
    float noiseMax = 0.2; //dial
    float phase = PI/4; //dial


    for (float a = 0; a < TAU; a+=TAU/numPoints) {
      float xoff = map(cos(a + phase), -1, 1, 0, noiseMax); 
      float yoff = map(sin(a), -1, 1, 0, noiseMax); 
      float n = noise(xoff, yoff); 
      float radius = (r/2)*n;

      float x = pos.x + radius*cos(a); 
      float y = pos.y + radius*sin(a); 

      vertices.add(new PVector(x, y)); //store vertices
    }
  }


  void render() {
    strokeWeight(2); 
    noFill(); 
    circle(pos.x, pos.y, r);
  }

  void showVertices() {
    for (PVector v : vertices) {
      fill(0); 
      circle(v.x, v.y, 10);
    }
  }

  void shapeVertices(color col) {
    beginShape(); 
    //stroke(255); 
    noStroke(); 
    fill(col); 
    for (PVector v : vertices) {
      //fill(0); 
      curveVertex(v.x, v.y, 10);
    }
    endShape(CLOSE);
  }
}

void mousePressed(){
 saveFrame("render.png");  
}
