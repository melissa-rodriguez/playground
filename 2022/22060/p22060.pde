import peasy.*;
PeasyCam cam;

Brush brush;  

ArrayList<Brush> brushes; 
float t; 
int circleRes = 200; 
float r = 100; //width
float zres = r/5; 
float stripWidth = 200; //height

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  colorMode(HSB); 
  brushes = new ArrayList<Brush>(); 

  int amt = 1; 

  for (int i = 0; i < amt; i++) {

    //cam = new PeasyCam(this, 800);
    brush = new Brush(map(i, 0, amt, width/2, width), 0);
    brushes.add(brush); 
  }

  background(155, 255, 10);
  //background(240);
}

void draw() {
  //clear(); 
  //background(240); 

  for (Brush brush : brushes) {
    brush.render(); 
    brush.update(); 
    brush.behaviors();
  }


  //if (frameCount <= 24) {
  //  saveFrame("output/gif###.png");
  //}
}

class Brush {

  //for steering behaviors
  int grid_w = 1080; 
  int grid_h = 1920; 
  PVector pos, vel, acc; 
  PVector target; 
  //float r = 1; 
  float maxSpeed = 0.5; 
  float maxForce = 0.5;
  int brushDiameter; 


  int numParticles = 1000; 

  Particle[] particles; 

  Brush(float x, float y) {
    particles = new Particle[numParticles];
    pos = new PVector(x, y); 
    vel = PVector.random2D(); 
    acc = new PVector(0, 0); 
    target = new PVector(random(grid_w), random(grid_h)); //random position to target

    brushDiameter = 100;
      println(numParticles); 
    init();
  }

  void init() {
    for (int i = 0; i < numParticles; i++) {
      particles[i] = new Particle(random(0.05, 0.5));
    }
  }

  void behaviors() {
    PVector arrive = arrive(target); 
    PVector object = new PVector(mouseX, mouseY); 
    PVector flee = flee(object); 


    arrive.mult(3); 
    flee.mult(5); 

    //applyForce(flee); 
    applyForce(arrive);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  PVector flee(PVector target) {
    PVector desired = PVector.sub(target, pos); 
    float d = desired.mag(); 
    desired.setMag(maxSpeed); 
    desired.mult(-1); //opposite direction 

    PVector steer = PVector.sub(desired, vel); 
    steer.limit(maxForce); 

    float fleeDiameter = 100;  //brush diameter


    if (d < fleeDiameter) {
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  PVector arrive(PVector target) {
    PVector desired = PVector.sub(target, pos); 
    float d = desired.mag(); 

    float speed = maxSpeed; 
    float thresh = 100;  //thresh hold //affects hairy texture
    if (d < thresh) {
      speed = map(d, 0, thresh, 0, maxSpeed);
    }

    //stroke(map(speed, 0, maxSpeed, 240, 0));
    if (speed > 0.1) {
      stroke(0);
    } else {
      noStroke();
    }

    desired.setMag(speed); 

    PVector steer = PVector.sub(desired, vel); 
    steer.limit(maxForce); 

    return steer;
  }

  void update() {
    pos.add(vel); 
    vel.add(acc);  
    acc.mult(0);

    if (frameCount %120==0) { //every two seconds
      //target = target = new PVector(random(pos.x, grid_w), random(pos.y, grid_h));

      //target = target = new PVector(random(grid_w), random(grid_h));


      //control the likelyhood of the new target being a point downward to prevent
      //so much backtracting
      //if (pos.y < grid_h/2) {
      target = new PVector(random(grid_w), random(pos.y, grid_h+600));
      //} else {
      //  target = new PVector(random(grid_w), random(grid_h));
      //}
    }
    
    //should travel faster, the farther away the target is from the brush
    //float d = dist(target.x, target.y, pos.x, pos.y);
    //maxSpeed = map(d, 0, grid_h, 0.5, 2); 
    
  }

  void render() {
    push();
    stroke(0, 255, 255); 
    circle(target.x, target.y, 10); 
    pop();
    
    push(); 
    translate(pos.x, pos.y); 
    rotate(radians(pos.y)); 
    drawSurface(); 
    //stroke(240);
    for (int i = 0; i < numParticles; i++) {
      particles[i].draw_point(-t);
      //particles[i].draw_line(t, 7);
    }
    pop();
  }
}

void drawSurface() {
  for (int k = 0; k < zres; k++) {

    beginShape(TRIANGLE_STRIP); 
    //fill(155, 155, 50); 
    fill(240, 10);  
    //noFill(); 
    //stroke(255); 
    noStroke(); 
    //noFill(); 
    for (float a = 0; a <= TAU+PI; a+=TAU/circleRes) {
      PVector v1 = calcPoint(k, a); 
      PVector v2 = calcPoint(k+1, a); 
      vertex(v1.x, v1.y, v1.z);
      vertex(v2.x, v2.y, v2.z);
    }
    endShape(CLOSE);




    //for (float a = 0; a <= TAU+PI; a+=TAU/circleRes) {
    //  PVector v1 = calcPoint(k, a); 
    //  PVector v2 = calcPoint(k+1, a); 
    //  push();
    //  stroke(255); 
    //  translate(v1.x, v1.y, v1.z); 
    //  rotate(TAU*map(a, 0, TAU, 0, 1)); 
    //  //line(0, -5, 0, 5); 
    //  //line(-5, 0, 5, 0); 
    //  noFill(); 
    //  //arc(0, 0, 50, 50, 0, PI, OPEN); 
    //  pop(); 
    //}
  }
}

PVector calcPoint(float k, float a) {
  float xoff = map(cos(a), -1, 1, 0, .8); 
  float yoff = map(sin(a), -1, 1, 0, .8);
  float n = noise(xoff, yoff); 

  float x = r*(cos(a)); 
  float y = stripWidth*map(k, 0, zres, -0.5, 0.5); 
  //float z = stripWidth*map(k, 0, zres, -0.5, 0.5);


  return new PVector(x, y);
}

class Particle {
  float k;
  float a;
  float offset;
  float weight = 4; 
  float length = 0.3; 
  float sw;

  Particle() {
    offset = random(0, 1);
    k = random(0, zres);
    a = random(0, 2*PI);
    

    sw = constrain(5*randomGaussian(), 1, 5);
  }

  Particle(float l) {
    offset = random(0, 1);
    k = random(0, zres);
    a = random(0, 2*PI);
    weight = random(1, 2);
    length = l;
    sw = constrain(5*randomGaussian(), 1, 5);
  }

  void draw_point(float t) {
    PVector v = calcPoint(k + offset, a);
    //stroke(255);
    strokeWeight(sw*1.3);
    stroke(155, 155, map(v.y, 0, r/2, 255, stripWidth/2));
    //stroke(155, 155, map(v.y, 0, stripWidth/2, 255, 10));
    point(v.x, v.y, v.z);
  }

  void draw_line(float t, int n) {

    PVector[] vectors = new PVector[n+1];
    float dt = length/n;
    for (int i = 0; i <= n; i++) {
      vectors[i] = calcPoint(k + offset - dt*i, a + dt*i);
    }

    strokeWeight(sw);
    //stroke(255);


    for (int i = 0; i < n; i++) {
      stroke(155, 155, map(vectors[i].y, 0, r/2, 255, stripWidth/2)); 
      line(vectors[i].x, vectors[i].y, vectors[i].z, vectors[i+1].x, vectors[i+1].y, vectors[i+1].z);
    }

    //push();
    //strokeWeight(8);
    //stroke(0, 255, 0);
    //PVector test = vectors[0];
    //point(test.x, test.y, test.z);
    //pop();
  }
}

void mousePressed() {
  saveFrame("output.png");
}
