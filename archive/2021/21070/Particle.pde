class Particles {
  PVector pos = new PVector(random(width),random(height));
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  float maxSpeed = 1;

  PVector prevPos = pos.copy();

   void update() {
    
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }

   void follow(PVector[] vectors) {
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    int index = (x-1) + ((y-1) * cols);
    // Sometimes the index ends up out of range, typically by a value under 100.
    // I have no idea why this happens, but I have to do some stupid if-checking
    // to make sure the sketch doesn't crash when it inevitably happens.
    //
    index = index - 1;
    if(index > vectors.length || index < 0) {
      //println("Out of bounds!");
      //println(index);
      //println(vectors.length);
      index = vectors.length - 1;
    }
    PVector force = vectors[index];
   
    applyForce(force);
    
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

   void show() {

    //stroke(255, 255*sin(frameCount));
    stroke(184, 208, 217, 50);
    strokeWeight(2);
    point(pos.x-width/2, pos.y-height/2);
    //push();
    //println("here");
    //translate(pos.x-width/2, pos.y-height/2);
    //fill(255);
    ////translate(mouseX+width/2, mouseY+height/2);
    //box(2);
    //pop();

  }

   void updatePrev() {
    prevPos.x = pos.x;
    prevPos.y = pos.y;
  }

   void edges() {
    if (pos.x > width) {
      pos.x = 0;
      updatePrev();
    }
    if (pos.x < 0) {
      pos.x = width;
      updatePrev();
    }

    if (pos.y > height) {
      pos.y = 0;
      updatePrev();
    }
    if (pos.y < 0) {
      pos.y = height;
      updatePrev();
    }
  }
}
