// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flow Field Following
// Via Reynolds: http://www.red3d.com/cwr/steer/FlowFollow.html

// Using this variable to decide whether to draw all the stuff
boolean debug = true;

// Flowfield object
FlowField flowfield;
// An ArrayList of vehicles
ArrayList<Vehicle> vehicles;
color[] colorArray = {#252E40, #7289A6, #A3BFD9, #C9DFF2, #0D0000};

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  noiseSeed(3);
  // Make a new flow field with "resolution" of 16
  flowfield = new FlowField(20);
  vehicles = new ArrayList<Vehicle>();
  // Make a whole bunch of vehicles with random maxspeed and maxforce values
  for (int i = 0; i < 300; i++) {
    vehicles.add(new Vehicle(new PVector(random(width), random(height)), random(2, 5), random(0.1, 0.5)));
  }
}

float t;
void draw() {
  background(0);
  t+=0.01;
  //translate(0, mouseX,0);
  //rotateX(radians(80));
  // Display the flowfield in "debug" mode
  if (debug) flowfield.display();
  // Tell all the vehicles to follow the flow field
  for (Vehicle v : vehicles) {
    v.follow(flowfield);
    v.run();
  }
  
  //noLoop();
  // Instructions
  //fill(0);
  //text("Hit space bar to toggle debugging lines.\nClick the mouse to generate a new flow field.",10,height-20);
}


void keyPressed() {
  if (key == ' ') {
    debug = !debug;
  }
}

// Make a new flowfield
void mousePressed() {
  flowfield.init();
  saveFrame("render###.png");
}
