FlowField field;
OpenSimplexNoise noise;
float n, s, d;
ArrayList<Vehicle> vehicles;
float r, angle, step;
void setup() {
  size(1080, 1080, P2D); 
  pixelDensity(2);
  background(0);
  field = new FlowField();
  noise = new OpenSimplexNoise();
  vehicles = new ArrayList<Vehicle>();
  //field.init();

  r     = 300;
  angle = 0;
  step  = PI/12; //in radians equivalent of 360/6 in degrees

  for (float a = 0; a <= 360; a ++) {
    float x = r*cos(a);
    float y = r*sin(a);
    vehicles.add(new Vehicle(new PVector(width/2 + x, height/2 + y), 3, 0.3));
    push();
    noStroke();
    circle(width/2 + x, height/2 + y, 10);
    pop();
  }
}

void draw() {
  //background(240);
  field.init();

  //move 0,0 to the center of the screen
  //translate(width/2, height/2);

  //convert polar coordinates to cartesian coordinates
  //float x = r * sin(angle);
  //float y = r * cos(angle);

  ////draw ellipse at every x,y point
  //point(x+ width/2, y+height/2);
  //vehicles.add(new Vehicle(new PVector(width/2 + x, height/2 + y), 3, 0.3));
  ////increase angle by step size
  //angle = angle + step;

  for (Vehicle v : vehicles) {

    float d = dist(v.position.x, v.position.y, width/2, height/2);
    if (d <= 300) {
      v.follow(field); 
      v.run();
    }
  }

  for (float a = 0; a <= 360; a ++) {
    float x = r*cos(a);
    float y = r*sin(a);
    push();
    noStroke();
    circle(width/2 + x, height/2 + y, 12);
    pop();
  }
  //noLoop();
  //rec();
  //if (frameCount<=360) {
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
