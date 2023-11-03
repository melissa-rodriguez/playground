ArrayList<pointVertex> vertices;

void setup() {
  size(1080, 1080);
  pixelDensity(2);
  vertices = new ArrayList<pointVertex>(); 

  int res = 50; // resolution of circle

  for (int i = 0; i < res; i++) {
    float theta = map(i, 0, res, 0, TAU); 
    vertices.add(new pointVertex(theta));
  }
}

void draw() {
  background(0);
  //translate(width/2, height/2);

  //noFill(); 
  push();
  noStroke();
  fill(255, 0, 0, 100); 
  if (mousePressed) {
    fill(255, 0, 0);
  }
  circle(mouseX, mouseY, 50);
pop();

fill(255); 

stroke(255);
strokeWeight(3); 

beginShape();
for (pointVertex v : vertices) {
  v.render();  
  v.update(); 
  v.behaviors();
}
endShape(CLOSE);

//if (frameCount < 361) {
  //saveFrame("output/gif###.png");
//}
}



class pointVertex {
  PVector pos, vel, acc, target, target2; 
  float r = 200; 
  float maxSpeed = 2; 
  float maxForce = 0.3; 

  float a = 0; 
  float a2 = 0; 

  PVector steer; 

  pointVertex(float theta) {
    pos = new PVector(width/2 + r*cos(theta), height/2 + r*sin(theta)); 
    //pos = new PVector(random(-width/2, width/2), random(-height/2, height)); 
    target = new PVector(width/2 + r*cos(theta), height/2 + r*sin(theta)); 
    vel = PVector.random2D(); 
    acc = new PVector(0, 0);
  }

  void render() {
    curveVertex(pos.x, pos.y);
  }

  void behaviors() {
    PVector arrive = arrive(target); 


    PVector object1 = new PVector((mouseX), (mouseY));
    PVector seek = seek(object1); 

    seek.mult(2); 
    arrive.mult(1); 

    applyForce(arrive); 

    if (mousePressed) {
      applyForce(seek);
    }



    //PVector mouse = new PVector(mouseX, mouseY);
    //PVector flee = flee(mouse); 
    //applyForce(flee);
  }

  PVector arrive(PVector target) {
    //difference between position and target?
    PVector desired = PVector.sub(target, pos); 
    float speed = maxSpeed;
    float d = desired.mag();  

    if (d < 50) {
      speed = map(d, 0, 50, 0, maxSpeed);
    }

    desired.setMag(speed); 
    steer = PVector.sub(desired, vel); 
    steer.limit(maxForce); 
    return steer;
  }

  PVector seek(PVector target) {
    //difference between position and target?
    PVector desired = PVector.sub(target, pos); 
    float d = desired.mag(); 

    if (d < 100) {
      desired.setMag(maxSpeed); 
      //desired.mult(-1); 

      steer = PVector.sub(desired, vel); 
      steer.limit(maxForce); 
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  PVector flee(PVector target) {
    //difference between position and target?
    PVector desired = PVector.sub(target, pos); 
    float d = desired.mag(); 

    if (d < 50) {
      desired.setMag(maxSpeed); 
      desired.mult(-1); 

      steer = PVector.sub(desired, vel); 
      steer.limit(maxForce); 
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {
    pos.add(vel); 
    vel.add(acc); 

    acc.mult(0);

    a+=radians(3);
    a2+=radians(1);
  }

  PVector calcPos(float theta) {
    float x = r*cos(theta); 
    float y = r*sin(theta);

    return new PVector(x, y);
  }
}
