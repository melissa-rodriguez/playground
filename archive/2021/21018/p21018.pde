FlowField field;
OpenSimplexNoise noise;
float n, s, d;
ArrayList<Vehicle> vehicles;
float r, angle, step, r2;

PImage img;


void setup() {
  size(1080, 1080, P2D); 
  pixelDensity(2);
  background(240);
  field = new FlowField();
  noise = new OpenSimplexNoise();
  vehicles = new ArrayList<Vehicle>();
  //field.init();
  
  colorMode(HSB);
  img = loadImage("desert.jpg");
  //img.resize(1080, 1080);

  r     = 300;
  r2 = 450;
  angle = 0;
  step  = PI/12; //in radians equivalent of 360/6 in degrees

  for (float a = 0; a <= 360; a ++) {
    float x = r*cos(a);
    float y = r*sin(a);
    float x2 = r2*cos(a);
    float y2 = r2*sin(a);
    vehicles.add(new Vehicle(new PVector(width/2 + x, height/2 + y), 3, 0.3));
    push();
    noStroke();
    circle(width/2 + x, height/2 + y, 10);
    circle(width/2 + x2, height/2 + y2, 15);
    
    pop();
  }
}

void draw() {
  //background(img);
  field.init();
  
 
 for (Vehicle v : vehicles) {

    float d = dist(v.position.x, v.position.y, width/2, height/2);
    if (d < 450) {
      v.follow(field); 
      v.run();
    }
  }
  
  
  //ring around
//beginShape();
  for (float a = 0; a <= 360; a ++) {
    push();
    float x = r*cos(a);
    float y = r*sin(a);
    
    float x2 = r2*cos(a);
    float y2 = r2*sin(a);
    fill(0);
    noStroke();
    //circle(width/2 + x, height/2 + y, 10);
    circle(width/2 + x2, height/2 + y2, 15);
    pop();
  }
 //endShape();
  
  
  
  //noLoop();
  //rec();
  //println(frameCount);
  //if (frameCount<=600) {
  //   saveFrame("gif/img####.png");
  //  //println(frameCount);
  //}
  //else{
  // println("render is complete"); 
  //}
 
}

void mouseDragged() {
  vehicles.add(new Vehicle(new PVector(mouseX, mouseY), 3, 0.3));
}
