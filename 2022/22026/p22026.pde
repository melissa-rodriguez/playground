void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);

  //background(240);
  colorMode(HSB);
}

void draw() {
  background(240); 

  noFill(); 

   
  translate(0, 0, -width/2); 

  int res = 60; 

  push();
  stroke(0);
  for (int i = 0; i <= res; i++) {
    for (int j = 0; j <= res; j++) {
      float x = map(i, 0, res, 0, width); 
      float y = map(j, 0, res, 0, height); 
      PVector center = new PVector(x, y); 
      float d = dist(x, y, 0, y); 

      int numPoints = int(map(d, 0, height, 3, 50)); 
      render(center, numPoints);
    }
  }
  pop();
  
  //push();
  //stroke(255,10);
  //for (int i = 0; i <= res; i++) {
  //  for (int j = 0; j <= res; j++) {
  //    float x = map(i, 0, res, 0, width); 
  //    float y = map(j, 0, res, 0, height); 
  //    PVector center = new PVector(x+4, y+4); 
  //    float d = dist(x, y, 0, 0); 

  //    int numPoints = int(map(d, 0, height, 3, 10)); 
  //    render(center, numPoints);
  //  }
  //}
  //pop();



  //point(vertex3.x, vertex3.y);
}

void render(PVector c, int np) {
  int numPoints = np; 

  push();
  translate(c.x, c.y); 

  for (float a = 0; a <= TAU; a+=TAU/numPoints) {

    float size = 100; 
    PVector center = new PVector(0, 0); 
    point(center.x, center.y); 


    PVector triangle = new PVector(size/(size*cos(radians(60)))*cos(radians(60)), 
      size/(size*cos(radians(60)))*sin(radians(60))).mult(1);
    PVector vertex1 = new PVector(center.x+triangle.x-(size/2)*cos(a), center.y+triangle.y+(size/2)*cos(a)); 
    PVector vertex2 = new PVector(center.x-triangle.x+(size/2)*sin(a), center.y+triangle.y+(size/2)*sin(a)); 
    PVector vertex3 = new PVector(center.x, center.y-triangle.y); 
    point(vertex1.x, vertex1.y); 
    point(vertex2.x, vertex2.y);
    strokeWeight(map(np, 3, 50, 0.1, 1.2));
    triangle(center.x, center.y, center.x+vertex1.x, center.y+vertex1.y, center.x+vertex2.x, center.y+vertex2.y);
  }
  pop();
}

void mousePressed() {
  saveFrame("render###.png");
}
