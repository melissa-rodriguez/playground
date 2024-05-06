
color[] colorArray = new int[]{#F2884B, #F23005, #011C40, #6D90A6};

//Cluster cluster; 
ArrayList<Cluster> clusters; 
ArrayList<PVector> gridLines; 


void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  //noise = new OpenSimplexNoise();
  colorMode(HSB); 

  clusters = new ArrayList<Cluster>(); 
  gridLines = new ArrayList<PVector>(); 

  int amt = 1; 

  PVector pos = new PVector(0, 0); 

  int grid_w = int(1080/2); 
  int grid_h = int(1080/2); 
  int res = 100; //how big u want each grid size to be
  int cols = grid_w/res; 
  int rows = grid_h/res; 

  float size = res; 
  float deform = res/2; //amt cluster will deform


  for (int i = 0; i <= cols; i++) {
    for (int j = 0; j <= rows; j++) {
      float x = map(i, 0, cols, 0, grid_w); 
      float y = map(j, 0, rows, 0, grid_h); 
      pos = new PVector(grid_w/2 + x, grid_h/2 + y); 
      gridLines.add(pos); 
      //pos.add(new PVector(random(-size/2, size/2), random(-size/2, size/2))); 
      //int numPoints = int(map(y, 0, grid_h, 5, 15)); 
      if (sqrt(random(1)) > 0.7) {
        int numPoints = int(100*sqrt(random(1))); 
        clusters.add(new Cluster(pos, size, deform, numPoints));
      }
    }
  }

  background(240);
}

void draw() {
  //translate(width/2, height/2);
  //background(240);  
  background(0); 

  for (Cluster cluster : clusters) {
    cluster.render(); 
    //cluster.update();
  }

  //show gridlines
  //for (PVector line : gridLines) {

  //  stroke(255); 
  //  line(line.x-50, line.y-50, line.x-50, line.y + 50);
  //  line(line.x-50, line.y-50, line.x+50, line.y - 50);
  //}
}

class Cluster {
  PVector pos; 
  ArrayList<Point> points; 
  int numPoints; 
  float size; //size of cluster
  float t; 
  float deform; //amt that the shape deforms by, smaller number the closer it stays to original shape
  PVector offset; 

  Cluster(PVector p, float s, float d, int pts) {
    points = new ArrayList<Point>();
    size = s; 
    deform = d; 
    numPoints = pts; 
    pos = p; 
    offset = new PVector(random(-size/2, size/2), random(-size/2, size/2));

    init();
  }

  void init() {
    for (int i = 0; i < numPoints; i++) {
      points.add(new Point(size, deform));
    }
  }

  void render() {
    //push(); 
    //translate(pos.x, pos.y);
    //strokeWeight(0.5);
    //noFill(); 
    //square(-size/2, -size/2, size); 
    //pop(); 

    push();
    translate(pos.x, pos.y);
    strokeWeight(0.5);
    for (int i = 0; i < points.size(); i++) {
      beginShape();
      //noFill();
      stroke(points.get(i).col, 20);
      points.get(i).update(t);
      for (int j = 0; j < points.size(); j++) {

        PVector pos1 = points.get(i).pos; 
        PVector posN = points.get(j).pos; 
        vertex(pos1.x, pos1.y);
        vertex(posN.x, posN.y);
      }
      endShape();
    }
    pop();
  }

  void update() {
    t+=radians(0.5);
  }
}

class Point {
  PVector pos; 
  float randX, randY; 
  float t = 0; //initialize t for movement
  float deform; 
  color col; //color of the connecting line

  float angle; 
  float size; 

  Point(float s, float d) {
    size = s; 

    //randX = map(sqrt(random(1))*cos(random(TAU)), -1, 1, 0, size); 
    //randY = map(sqrt(random(1))*sin(random(TAU)), -1, 1, 0, size);

    randX = sqrt(random(1))*(cos(random(TAU))); 
    randY = sqrt(random(1))*(sin(random(TAU)));

    if (randX < 0) {
      randX = -size/2;
    } else {
      randX = size/2;
    }

    if (randY < 0) {
      randY = -size/2;
    } else {
      randY = size/2;
    }


    pos = new PVector(randX, randY); //place point at random location

    angle = random(TAU);
    deform = d;

    col = (colorArray[int((colorArray.length)*sqrt(random(1)))]);
    //col = color(0, 0, 0); 
    //col = color(240*sqrt(random(1))); 
    //col = color(155, 240*sqrt(random(1)), 255); 
    //col = color(colNum*sqrt(random(1)), 155*sqrt(random(1)), 255*sqrt(random(1)));
  }

  void update(float t) {
    //println("here"); 
    //float x = randX+(deform*easeInBack(sin(t)))*cos(t+map(mag(randX, 0), -size, size, 0, TAU));
    //float y = randY+(deform*easeInBack(cos(t)))*sin(t+map(mag(0, randY), -size, size, 0, TAU));
    float x = randX + deform*easeInExpo(cos(t+angle)); 
    float y = randY + deform*easeInExpo(sin(t+angle)); 
    pos = new PVector(x, y);
  }
}

void mousePressed() {
  saveFrame("render.png");
}
