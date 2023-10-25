class Vehicle {
  // The usual stuff
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  Vehicle(PVector l, float ms, float mf) {
    position = l.copy();
    r = 3.0;
    maxspeed = ms;
    maxforce = mf;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
  }

  public void run() {
    update();
    borders();
    display();
  }


  void follow(FlowField flow) {
    PVector desired = flow.lookup(position); //what is the vecotr at that spot in flowfield
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity); //steer = desired - velocity
    steer.limit(maxforce);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  float t = 0;
  color c;
  float b;
  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading() + radians(90);
    d = dist(position.x, position.y, width/2, height/2);

    if (d < 100) {
      stroke(0);
      fill(0);
    } else if(d <= 200){
      stroke(0);
      fill(#ACD1EE);
    }
    else if (d<=300) {
      c = img.get(int(position.x), int(position.y));
      b = map(brightness(c), 0, 255, 1, 0);
      fill(255);
    } else if (d > 300 && d < 450) {
      c = img.get(int(position.x+img.width/2), int(position.y+img.height/2));
      b = map(brightness(c), 0, 255, 1, 0);
      stroke(0);
      fill(#0208A8);
    } else {
      stroke(0);
      //noStroke();
      fill(240);
    }
    


    //fill(map(d, 0, 300, 200, 10));
    //noStroke();
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);

    s = sin(TAU*t-d);

    circle(0, 0, 10);
    //beginShape(TRIANGLES);
    //vertex(0, -r*2);
    //vertex(-r, r*2);
    //vertex(r, r*2);
    //endShape();
    popMatrix();
    t+= 0.01;

    //else{
    // position.sub(velocity.mult(2)); 
    //}
  }

  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
}
