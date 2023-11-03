ArrayList<Clock> clocks = new ArrayList<Clock>();
ArrayList<PVector> edgeVertices = new ArrayList<PVector>();
float r = 60;
char n, o, w; 
OpenSimplexNoise noise;
PFont font;
PShape shape;

void setup() {
  size(1080, 1080); 
  pixelDensity(2);
  noise = new OpenSimplexNoise();
  font = createFont("box.ttf", 300, true);
  n = 'N';
  shape = font.getShape(n);
  for (int i = 0; i < shape.getVertexCount(); i++) {
    edgeVertices.add(shape.getVertex(i));
  }
  //clocks.add(new Clock()); 
  for (float x = 100; x < width-r; x += r) {
    for (float y = 100; y < height-20; y += r) {
      clocks.add(new Clock(x, y));
    }
  }
}

void draw() {
  background(0);

  strokeWeight(3);

  for (Clock c : clocks) {
    c.display();
  }
  
  //if(frameCount < 360){
  //  saveFrame("output2/gif###.png");
  //}
}

class Clock {
  float xpos, ypos, radius, thetaMin, thetaSec;
  Clock(float x, float y) {
    xpos = x;
    ypos = y;
    radius = 50;
    //thetaMin = random(360);
    //thetaSec = random(360);
    thetaMin = 0;
    thetaSec = 0;
  }

  void display() {
    strokeWeight(2);
    stroke(255);
    showClock();
    showHands();
  }

  void showClock() {
    noFill();
    circle(xpos, ypos, radius);
    circle(xpos, ypos, radius + 10);
  }

  void showHands() {
   
    //minute hand
    PVector minuteDirection = PVector.fromAngle(radians(thetaMin));
    PVector minuteLength = new PVector(xpos+(minuteDirection.x*radius/2), ypos+(minuteDirection.y*radius/2));
    line(xpos, ypos, minuteLength.x, minuteLength.y);

    //seconds hand
    PVector secDirection = PVector.fromAngle(radians(thetaSec));
    PVector secLength = new PVector(xpos+(secDirection.x*radius/2), ypos+(secDirection.y*radius/2));
    line(xpos, ypos, secLength.x, secLength.y);
    
    float d = dist(xpos, ypos, 0, 0);
    thetaMin+=(map(d, 0, width, 0, 10*cos(radians(frameCount))));

    if(thetaMin > 360){
     thetaMin = 0; 
    }
    thetaSec+=5;
    
    //thetaSec+=(map(d, 0, width, 0, 10*sin(radians(frameCount))));
  }
}
