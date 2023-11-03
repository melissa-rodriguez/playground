
import peasy.*;
PeasyCam cam;

//ArrayList<Vertex> verts; 
Vertex[][] verts; 
int res, cols, rows; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  colorMode(HSB); 
  cam = new PeasyCam(this, 700);

  res = 20; 
  cols = width/res; 
  rows = height/res; 
  verts = new Vertex[cols][rows]; 

  //verts = new ArrayList<Vertex>();
  //int res = 20; 


  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      float x = map(i, 0, rows, 0, width); 
      float y = map(j, 0, cols, 0, height);

      verts[i][j] = new Vertex(x, y, 0); 
      //verts.add(new Vertex(x, y, 0));
    }
  }
}

void draw() {
  background(0); 
  //strokeWeight(3);
  //noStroke(); 
  translate(-width/2, -height/2); //offset peasy cam

  for (int j = 0; j < rows-1; j++) {
    beginShape(QUAD_STRIP);
    fill(240); 
    //fill(240*abs(sin(map(j, 0, rows-1, 0, TAU)))); 
    for (int i = 0; i < cols-1; i++) {
      Vertex v1 = verts[i][j];
      Vertex v2 = verts[i][j+1];
      //fill(v1.col); 


      v1.show(); 
      v2.show(); 

      v1.update(); 
      v1.behaviors(); 
      //verts.add(new Vertex(x, y, 0));
    }
    endShape();
  }
  //Vertex v1 = verts.get(int(mouseX)); 
  //strokeWeight(10); 
  //v1.show();

  //if (frameCount > 360 && frameCount <= 540) {
  //  saveFrame("output/output###.png");
  //}
  

}

class Vertex {
  PVector pos, vel, acc; 
  PVector target; 
  float r = 8; 
  float maxSpeed = 4; 
  float maxForce = 0.8; 
  color col; 

  Vertex(float x, float y, float z) {
    pos = new PVector(x, y, z); 
    vel = new PVector(0, 0, 0); 
    //vel = PVector.random3D(); 
    acc = new PVector(0, 0, 0); 
    //col = color(random(20, 100), 155, 255); 
    col = color(20); 

    target = new PVector(x, y, z);
  }

  void behaviors() {
    PVector arrive = arrive(target); 
    applyForce(arrive); 

    PVector mouse = new PVector(width/2 + 200*cos(radians(frameCount*2)), 
      height/2 + 200*sin(radians(frameCount*2))); 
    PVector flee = flee(mouse); 
    applyForce(flee);
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  PVector arrive(PVector target) {
    PVector desired = PVector.sub(target, pos); 
    float d = desired.mag(); 
    float speed = maxSpeed; 

    if (d < 100) {
      speed = map(d, 0, 100, 0, maxSpeed);
    }

    //stroke(map(speed, 0, maxSpeed, 240, 0)); 

    //if (speed > 0) {
    //  col = color(map(speed, 0, maxSpeed, 255, 0));
    //}else{col = color(240);}

    desired.setMag(speed); 
    PVector steer = PVector.sub(desired, vel); 
    steer.limit(maxForce); 

    return steer;
  }

  PVector flee(PVector target) {
    PVector desired = PVector.sub(target, pos); 
    float d = desired.mag(); 


    desired.setMag(maxSpeed); 
    desired.mult(-1); 
    if (d > 100) {
      vel = new PVector(0, 0, 0);
    }
    PVector steer = PVector.sub(desired, vel); 
    steer.limit(maxForce); 

    if (d < 100) {
      return steer;
    } else {
      return new PVector(0, 0, 0);
    }
  }

  void update() {
    pos.add(vel); 
    vel.add(acc); 
    acc.mult(0);
  }

  void show() {
    //stroke(col); 

    vertex(pos.x, pos.y, pos.z);
  }
}

void mousePressed(){
 saveFrame("output###.png");  
}
