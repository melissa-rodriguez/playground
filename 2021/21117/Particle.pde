class Particle {
  float r;
  PVector pos;

  Particle() {
    pos = PVector.random3D();
    r = random(1, 10);
  }

  void render() {
    push();
    float x = width*2*pos.x;
    float y = width*2*pos.y;
    if (y<50) {
      noStroke();
      translate(x, y, -1e3);
      circle(0, 0, r);
    }
    pop();
  }
}
