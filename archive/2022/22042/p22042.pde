ArrayList<Node> nodes; 
void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  colorMode(HSB); 

  nodes = new ArrayList<Node>(); 

  int res = 100; 
  for (float a = 0; a < TAU; a+=TAU/res) {
    float x = width/2 + 300*cos(a); 
    float y = height/2 + 300*sin(a); 
    PVector start = new PVector(x, y); 
    //int stepsToInc = int(8*sqrt(random(1))); 
    nodes.add(new Node(start));
  }
}

void draw() {
  background(240); 
  strokeWeight(1);
  stroke(0, 50); 
  //stroke(20); 

  //beginShape();
  //noFill(); 
  //for (Node n : nodes) {
  //  n.show();  
  //  n.update();
  //}
  //endShape(CLOSE);

  beginShape(); 
  noFill();
  for (int i = 0; i < nodes.size()-1; i++) {
    Node node = nodes.get(i); 
    Node nextNode = nodes.get(i+1); 
    float addNode = sqrt(random(1)); 
    if (addNode > 0.1) {
      PVector midPoint = new PVector(nextNode.pos.x, node.pos.y); 
      Node newNode = new Node(midPoint);  
      if (dist(newNode.pos.x, newNode.pos.y, width/2, height/2) >200) {
        nodes.add(newNode);
      }
    }
    node.show();
  }
  endShape(CLOSE); 

  //saveFrame("output.png"); 
  noLoop();
}

class Node {
  PVector pos; 
  PVector increment; 

  Node(PVector start) {
    pos = start;
  }

  void show() {
    curveVertex(pos.x, pos.y);
  }

  void update() {
  }
}
