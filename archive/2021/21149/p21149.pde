import peasy.*;
PeasyCam cam;

ArrayList<Path> path1 = new ArrayList<Path>(); //store points of top path
ArrayList<Path> path2 = new ArrayList<Path>(); //store points of bottom path

ArrayList<Path> particles = new ArrayList<Path>(); //store surface particles

int numPoints = 100; //amount of points in path (resolution);
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 1800);

  for (int i = 0; i < numPoints; i ++) {
    path1.add(new Path(i)); 
    path2.add(new Path(i, 200));
  }
}

float t; 
void draw() {
  background(0);
  t+=0.04;
  rectMode(CENTER);
  noFill();
  push();
  translate(0, 100, 200);
  rect(0, 0, 800, 1200);
  pop();

  rotateX(-PI+radians(-10));
  rotate(PI);

  drawSurface(t);


  for (Path p : path2) {
    p.show();
    p.update(t);
  }

  //saveFrame("output/gif###.png");
}

void drawSurface(float t) {
  stroke(255); //white outline
  strokeWeight(1); //line weight
  noStroke();
  fill(0); //fill black
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < path1.size(); i++) {
    path1.get(i).update(t);
    path2.get(i).update(t);
    PVector v1 = new PVector(path1.get(i).pos.x, path1.get(i).pos.y, path1.get(i).pos.z);
    PVector v2 = new PVector(path2.get(i).pos.x, path2.get(i).pos.y, path2.get(i).pos.z);
    //connect top and bottom paths
    vertex(v1.x, v1.y, v1.z);
    vertex(v2.x, v2.y, v2.z);
  }
  endShape(CLOSE);
}


class Path {
  PVector pos, pointPos;
  float size;
  float x, z, amp, h;
  Path(int i) {
    amp= 200; //changing amp for this path and path(i, h) results in a "peak" and wider base
    z = -2000+i*10;
    x = amp*(sin(radians(z))); //makes the "sin" path
    pos = new PVector(x, 0, z); 
    pointPos = new PVector(x, random(h), z); //h is height of shape
    size = random(5, 30);
  }

  Path(int i, float h) {
    amp= 200;
    z = -2000+i*10;
    x = amp*(sin(radians(z))); //makes the "sin" path
    pos = new PVector(x, h, z); //h is height of shape
    pointPos = new PVector(x, random(h), z);
    size = random(5, 30);
  }

  void show() {
    strokeWeight(5);
    stroke(255);
    for (int i = 0; i < 10; i ++) {
      float y = map(i, 0, 10, 0, pointPos.y);
      point(pointPos.x, y, pointPos.z);
    }
  }

  void update(float t) {
    pointPos.x= amp*(sin(radians(z)+t)); //updates the "sin" path
    pos.x= amp*(sin(radians(z)+t)); //updates the "sin" path
  }
}
