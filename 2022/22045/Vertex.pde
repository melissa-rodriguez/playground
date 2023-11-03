//steering behaviors class

  class Vertex {
    PVector pos, vel, acc; 
    PVector target; 
    float r = 8; 
    float maxSpeed = 4; 
    float maxForce = 0.8; 
    color col; 

    //PVector randPoint;

    Vertex(float x, float y, float z) {
      pos = new PVector(x, y, z); 
      vel = new PVector(0, 0, 20); 
      //vel = PVector.random3D(); 
      acc = new PVector(0, 0, 0); 
      //col = color(random(20, 100), 155, 255); 
      //col = color(20); 

      target = new PVector(x, y, z);
    }

    void behaviors() {
      PVector arrive = arrive(target); 

      float xoff = mouseX;
      float yoff = mouseY;
      PVector mouse = new PVector(xoff, yoff);  

      PVector flee = flee(mouse); 

      arrive.mult(1); 
      flee.mult(5); 

      //applyForce(arrive); 
      applyForce(flee);
    }

    void applyForce(PVector f) {
      acc.add(f);
    }

    PVector arrive(PVector target) {
      PVector desired = PVector.sub(target, pos); 
      float d = desired.mag(); 
      float speed = maxSpeed; 
      float maxD = 20;

      if (d < maxD) {
        speed = map(d, 0, maxD, 0, maxSpeed);
      }

      //stroke(map(speed, 0, maxSpeed, 0,200));
      col = color(map(pos.z, 0, 20, 240, 20));

      desired.setMag(speed); 
      PVector steer = PVector.sub(desired, vel); 
      steer.limit(maxForce); 

      return steer;
    }

    PVector flee(PVector target) {
      PVector desired = PVector.sub(target, pos); 
      float d = desired.mag();  
      float maxD = 100; 


      desired.setMag(maxSpeed); 
      desired.mult(-1); 
      if (d > maxD) {
        vel = new PVector(0, 0, 0);
      }
      PVector steer = PVector.sub(desired, vel); 
      steer.limit(maxForce); 

      //fill(map(vel.z, 0, 20, 240, 0)); 

      if (d < maxD) {
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
