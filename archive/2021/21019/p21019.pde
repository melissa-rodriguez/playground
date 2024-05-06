FlowField field;
OpenSimplexNoise noise;
float n, s, d;
ArrayList<Vehicle> vehicles;
float r, angle, step;

PImage pug;

int totalFrames = 90;
int counter = 0;
boolean record = false;


void setup() {
  size(1080, 1080, P2D); 
  pixelDensity(2);
  background(0);
  field = new FlowField();
  noise = new OpenSimplexNoise();
  vehicles = new ArrayList<Vehicle>();

  pug = loadImage("fullskull.jpg");
  pug.resize(1000, 800);
  //field.init();
}


void draw() {
  float percent = 0;
  if (record) {
    percent = float(counter)/totalFrames;
  } else {
    percent = float(counter%totalFrames)/totalFrames;
  }
  background(0);
  translate(40, 120);
  //rotateY(radians(frameCount*.2));
  field.init(percent);
  if (record) {
    //saveFrame("output2/gif-" + nf(counter, 3) + ".png");

    if (counter == totalFrames-1) {
      exit();
    }
  }
  counter++;
  
  
}

void mouseDragged() {
  vehicles.add(new Vehicle(new PVector(mouseX, mouseY), 3, 0.3));
}
