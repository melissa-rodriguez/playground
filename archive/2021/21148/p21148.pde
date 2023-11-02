import peasy.*;
PeasyCam cam;

ArrayList<Particle> particles;
int initAmt = 100;
float tunnelSize = 150;
void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  particles = new ArrayList<Particle>();

  cam = new PeasyCam(this, 800);

  for (int i = 0; i < initAmt; i++) {
    particles.add(new Particle());
  }
}

float k = 10;
float t, q;
void draw() {
  background(0);
  t+=0.02;
  //for (int i = 0; i < 5; i ++) {
  //  //add 5 particles every frame
  //  particles.add(new Particle());
  //}

  tunnel(t);

  println(mouseX, mouseY);
  // -----DOOR------
  rectMode(CENTER);
  //stroke(255);
  //noFill();
  noStroke();
  //strokeWeight(10);
  fill(0);
  rect(0, 0, 180, 490);
  //strokeWeight(3);
  //circle(-20, 5, 10);
  //rect(0, 0, 75, 120);
  


  if(q > 1){
   t = 0; 
  }

  //if (q < 1) {
  //  saveFrame("output/gif###.png");
  //}
}

void tunnel(float t) {
  for (float j = 0; j < k; j++) {
    q = (j + t)/k;
    push();
    translate(0, 0, -2000 + 5e3*q);
    // ------------BOTTOM---------------
    push();
    translate(0, tunnelSize-25, 0);
    rotateX(radians(90));
    for (int i = 0; i < particles.size(); i ++) {
      Particle p = particles.get(i);
      p.display();
      p.update();
      if (p.finished()) {
        particles.remove(i);
      }
    }
    pop();


    //------------TOP---------------
    push();
    translate(0, -tunnelSize+25, 0);
    rotateX(radians(90));
    for (int i = 0; i < particles.size(); i ++) {
      Particle p = particles.get(i);
      p.display();
      p.update();
      if (p.finished()) {
        particles.remove(i);
      }
    }
    pop();

    // ------------RIGHT---------------
    push();
    translate(tunnelSize/2, 0, 0);
    rotateX(radians(90));
    rotateY(radians(90));
    //rotateX(radians(mouseX));
    for (int i = 0; i < particles.size(); i ++) {
      Particle p = particles.get(i);
      p.display();
      p.update();
      if (p.finished()) {
        particles.remove(i);
      }
    }
    pop();


    // ------------LEFT---------------
    push();
    translate(-tunnelSize/2, 0, 0);
    rotateX(radians(90));
    rotateY(radians(90));
    //rotateX(radians(mouseX));
    for (int i = 0; i < particles.size(); i ++) {
      Particle p = particles.get(i);
      p.display();
      p.update();
      if (p.finished()) {
        particles.remove(i);
      }
    }
    pop();
    pop();
  }
  
}

class Particle {
  PVector pos, vel, acc;
  float fallWidth, fallHeight, size;

  Particle() {
    fallWidth = 110;
    fallHeight = 500;
    pos = new PVector(random(-fallWidth, fallWidth), - height/2 + random(-fallHeight, fallHeight), 0);
    vel = new PVector(0, random(1, 2), 0);
    acc = new PVector(0, 0.00, 0);
    size = random(1, 8);
  }

  void display() {
    stroke(255);
    strokeWeight(size);
    point(pos.x, pos.y, pos.z);
  }

  void update() {
    //pos.add(vel); 
    //vel.add(acc);

    //acc.mult(0);
  }

  boolean finished() {
    //return whether the particle is either past the height or past the "camera" (z axis)
    return pos.y > height || pos.z > 500;
  }
}
