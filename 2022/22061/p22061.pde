OpenSimplexNoise noise; 
color[] colorArray = new int[]{#1A374D, #406882, #6998AB, #B1D0E0, #FEE3EC};

Cluster cluster; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  //noise = new OpenSimplexNoise();
  colorMode(HSB); 
  
  float size = 800; 
  float deform = 200; //amt cluster will deform
  cluster = new Cluster(size, deform); 

  background(240);
}

void draw() {
  translate(width/2, height/2); 
  
  
  cluster.render(); 
  cluster.update(); 
  
}

class Cluster {
  ArrayList<Point> points; 
  int numPoints = 20; 
  float size; //size of cluster
  float t; 
  float deform; //amt that the shape deforms by, smaller number the closer it stays to original shape

  
  
  Cluster(float s, float d) {
    points = new ArrayList<Point>();
    size = s; 
    deform = d; 
    

    init();
  }

  void init() {
    for (int i = 0; i < numPoints; i++) {
      points.add(new Point(size, deform));
    }
  }

  void render() {
    strokeWeight(1);
    stroke(0, 20);
    for (int i = 0; i < points.size(); i++) {
      beginShape();
      //noFill();
      stroke(points.get(i).col, 5);
      points.get(i).update(t);
      for (int j = 0; j < points.size(); j++) {

        PVector pos1 = points.get(i).pos; 
        PVector posN = points.get(j).pos; 
        vertex(pos1.x, pos1.y);
        vertex(posN.x, posN.y);
      }
      endShape();
    }
  }
  
  void update(){
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
    
    randX = size*sqrt(random(1))*cos(random(TAU)); 
    randY = size*sqrt(random(1))*sin(random(TAU)); 

    pos = new PVector(randX, randY); //place point at random location

    angle = random(TAU);
    deform = d;
    col = (colorArray[int((colorArray.length)*sqrt(random(1)))]);
  }

  void update(float t) {
    //println("here"); 
    //float x = randX+(deform*easeInBack(sin(t)))*cos(t+map(mag(randX, 0), -size, size, 0, TAU));
    //float y = randY+(deform*easeInBack(cos(t)))*sin(t+map(mag(0, randY), -size, size, 0, TAU));
    float x = randX + deform*easeInExpo(cos(t+angle)); 
    float y = randY + deform*easeInExpo(sin(t+angle)); 
    pos = new PVector(x,y); 
  }
}

void mousePressed() {
  saveFrame("render.png");
}
