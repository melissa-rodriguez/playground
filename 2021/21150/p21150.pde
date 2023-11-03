import peasy.*;
PeasyCam cam;

ArrayList<Path> path1 = new ArrayList<Path>(); //store points of top path
ArrayList<Path> path2 = new ArrayList<Path>(); //store points of bottom path

ArrayList<Path> particles = new ArrayList<Path>(); //store surface particles

int numPoints = 800; //amount of points in path (resolution);
void setup() {
  size(2000, 2000, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 5000);

  for (int i = 0; i < numPoints; i ++) {
    path1.add(new Path(i)); 
    path2.add(new Path(i, 2000));
    particles.add(new Path(i, 2000));
  }
}

float t; 
void draw() {
  background(0);
  t+=1;

  //rotateX(-PI+radians(-10));
  rotate(PI/2+PI);
  rotateX(radians(148));
  println(mouseX);
  translate(-600, -width/2+618);

  push();
  drawSurface(t);
  for (Path p : path2) {
    p.show();
    p.update(t);
  }
  pop();

  push();

  translate(0, 2000);
  rotate(PI);
  drawSurface(t);
  for (Path p : path2) {
    p.show();
    p.update(t);
  }
  pop();

  //for (Path p : particles) {
  //  p.show();
  //  p.update(t);
  //}

  if (frameCount <= 180) {
    //saveFrame("output2/gif###.png");
  }
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

void drawPoints(float t) {
  stroke(255);
  strokeWeight(5);
  for (int i = 0; i < path1.size(); i++) {
    path1.get(i).update(t);
    path2.get(i).update(t);
    PVector v1 = new PVector(path1.get(i).pos.x, path1.get(i).pos.y, path1.get(i).pos.z);
    PVector v2 = new PVector(path2.get(i).pos.x, path2.get(i).pos.y, path2.get(i).pos.z);
    //connect top and bottom paths
    vertex(v1.x, v1.y, v1.z);
    vertex(v2.x, v2.y, v2.z);
  }
}


class Path {
  PVector pos, pointPos, pointPos2, pointPos3;
  float size;
  float x, z, amp, h, len;
  Path(int i) {
    amp= 1000; //changing amp for this path and path(i, h) results in a "peak" and wider base
    z = -2500+i*10;
    x = amp*(sin(radians(z))); //makes the "sin" path
    pos = new PVector(x, 0, z); 
    pointPos = new PVector(x, random(h), z); //h is height of shape
    pointPos2 = new PVector(x, 0, z); //h is height of shape
    pointPos3 = new PVector(x, 0, z); //h is height of shape
    size = random(3, 8);
  }

  Path(int i, float h) {
    amp= 1000;
    z = -2500+i*10;
    x = amp*(sin(radians(z))); //makes the "sin" path
    pos = new PVector(x, h, z); //h is height of shape
    pointPos2 = new PVector(x, random(h), z); //h is height of shape
    pointPos3 = new PVector(x, random(h), z); //h is height of shape
    pointPos = new PVector(x, random(h), z);
    size = random(3, 8);
  }

  void show() {
    strokeWeight(size);
    stroke(255);

    point(pointPos.x, pointPos.y, pointPos.z);
    point(pointPos2.x, pointPos2.y, pointPos2.z);
    point(pointPos3.x, pointPos3.y, pointPos3.z);


    //strokeWeight(3);
    //line(pointPos.x, pointPos.y, pointPos.z,pointPos.x+len, pointPos.y+len, pointPos.z+len);
    //line(pointPos2.x, pointPos2.y, pointPos2.z,pointPos2.x+len, pointPos2.y+len, pointPos2.z+len);
    //line(pointPos3.x, pointPos3.y, pointPos3.z,pointPos3.x+len, pointPos3.y+len, pointPos3.z+len);

    len = 50*(1-easeInCubic(sin(PI/8*(radians(z)+t))));
  }

  void update(float t) {
    pointPos.x= amp*easeInExpo(sin(PI/90*(radians(z)+t))); //updates the "sin" path
    pointPos2.x= amp*easeInExpo(sin(PI/90*(radians(z)+t))); //updates the "sin" path
    pointPos3.x= amp*easeInExpo(sin(PI/90*(radians(z)+t))); //updates the "sin" path
    pos.x= amp*easeInExpo(sin(PI/90*(radians(z)+t))); //updates the "sin" path
  }
}
