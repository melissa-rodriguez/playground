ArrayList<Particle> particles; 
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  particles = new ArrayList<Particle>(); 
  int ires = 200; 
  int jres = 400; 

  for (int i = 1; i < ires; i++) {
    for (int j = 1; j < jres; j++) {
      float x = map(i, 0, ires, 0, width); 
      float y = map(j, 0, jres, height/2, height*2); 

      particles.add(new Particle(x, y));
    }
  }
}

void draw() {
  background(0);
  stroke(255); 
  strokeWeight(3); 

  for (Particle p : particles) {
    p.display(); 
    p.update();
  }
  
}

class Particle {
  PVector pos, vel, acc; 
  
  PVector changeSpeed; 
  Particle(float x, float y) {
    pos = new PVector(x, y); 
    vel = new PVector(0, -1); 

    changeSpeed = new PVector(0, random(-3, -2)); 
  }

  void display() {
    point(pos.x, pos.y);
  }

  void update() {
    pos.add(vel);

    if (pos.y < height/2) {
      vel = changeSpeed; 
    } else {
      vel = new PVector(0, -1);
    }
  }
}
