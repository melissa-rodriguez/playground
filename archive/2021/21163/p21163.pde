import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;

Path p;
// An ArrayList of vehicles
ArrayList<Vehicle> vehicles;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  noise = new OpenSimplexNoise();
  vehicles = new ArrayList<Vehicle>();

  cam = new PeasyCam(this, 800);
  p = new Path();

  for (int i = 0; i < 200/10; i++) {
    for (int j = 0; j < 1000/10; j++) {
      float x = map(i, 0, 20, 0, 200);
      float y = map(i, 0, 100, 0, 1000);
      vehicles.add(new Vehicle(new PVector(x, y), random(2, 5), random(0.1, 0.5)));
      vehicles.add(new Vehicle(new PVector(x, y+200), random(2, 5), random(0.1, 0.5)));
      vehicles.add(new Vehicle(new PVector(x, y+400), random(2, 5), random(0.1, 0.5)));
      vehicles.add(new Vehicle(new PVector(x, y+600), random(2, 5), random(0.1, 0.5)));
      vehicles.add(new Vehicle(new PVector(x, y+800), random(2, 5), random(0.1, 0.5)));
    }
  }
  
}

float t; 
void draw() {
  background(0);
  stroke(255);
  strokeWeight(3);
  translate(0, -500);
  t+=radians(2);
  //p.calcPoints();
  //p.display();
  p.init();

  for (Vehicle v : vehicles) {
    v.follow(p);
    v.run();
  }
  
  drawBorder();
  
  //if(frameCount > 300){
   //saveFrame("output2/gif###.png");
  //}
}

void drawBorder(){
 push();
 stroke(255);
 strokeWeight(10);
 line(205, 0, 205, height);
 line(-5, 0, -5, height);
 pop();
 
 //push();
 //stroke(0);
 //strokeWeight(5);
 //line(205, 0, 205, height);
 //line(0, 0, 0, height);
 //pop();
}

class Path {
  int w, l;
  int rows, cols;
  int resolution; 
  PVector[][] field; 


  Path() {
    resolution = 10;

    w = 200; //width of the wave (aka amplitude)
    l = 1000; //length of the wave

    cols = w/resolution;
    rows = l/resolution;

    field = new PVector[cols][rows];
    init();
  }

  void init() {
    noiseSeed(3);
    //float xoff = 0;
    //for (int i = 0; i < cols; i++) {
    //  float yoff = 0;
    //  for (int j = 0; j < rows; j++) {
    //    float theta = map((float)noise.eval(xoff*0.3, yoff*0.3), -1, 1, 0, TWO_PI);
    //    // Polar to cartesian coordinate transformation to get x and y components of the vector
    //    field[i][j] = new PVector(cos(theta), sin(theta));
    //    yoff += 0.1;
    //  }
    //  xoff += 0.1;
    //}

    for (int i = 0; i < cols; i++) {
      float column = map(i, 0, cols, -w/2, w/2);
      //beginShape();
      //noFill();
      for (int j = 0; j < rows; j ++) {
        //for (int i = 0; i < cols; i++) {
        float z = map(j, 0, rows, -l/2, l/2);
        float x = column + sin(radians(z))*100;

        float xoff = map(cos(t), -1, 1, 0, 0.5); 
        float yoff = map(sin(t), -1, 1, 0, 0.5);
        float r = map((float)noise.eval(xoff, yoff), -1, 1, 0, 1);

        float theta = map((float)noise.eval(radians(x), radians(z), r), -1, 1, 0, PI);
        //curveVertex(x, 0, z);
        field[i][j] = new PVector(cos(theta), sin(theta));
        //}
      }
      //endShape();
    }
  }

  // Draw every vector
  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        drawVector(field[i][j], i*resolution, j*resolution, resolution-2);
      }
    }
  }

  // Renders a vector object 'v' as an arrow and a position 'x,y'
  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    float arrowsize = 4;
    // Translate to position to render vector
    translate(x, y);
    stroke(255);
    // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
    rotate(v.heading2D());
    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*scayl;
    // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
    line(0, 0, len, 0);
    //line(len,0,len-arrowsize,+arrowsize/2);
    //line(len,0,len-arrowsize,-arrowsize/2);
    popMatrix();
  }

  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].get();
  }


  void calcPoints() {

    for (int i = 0; i < cols; i++) {
      float column = map(i, 0, cols, -w/2, w/2);
      beginShape();
      noFill();
      for (int j = 0; j < rows; j ++) {
        //for (int i = 0; i < cols; i++) {
        float z = map(j, 0, rows, -l/2, l/2);
        float x = column + sin(radians(z))*100;
        curveVertex(x, 0, z);
        //}
      }
      endShape();
    }
  }
}
