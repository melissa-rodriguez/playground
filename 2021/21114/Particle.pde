class Particle {
  float theta, phi, offset, weight,alpha, length = 0.3;

  Particle() {
    offset = random(0, 1);
    theta = random(0, TAU);
    phi = random(0, TAU);
    weight = random(1, 3);
  }

  Particle(float l) {
    offset = random(0, 1);
    theta = random(0, 2*PI);
    phi = random(0, 2*PI);
    weight = random(1, 2);
    length = l;
    alpha=255*(random(0, 1));
  }

  void drawPoint(float t) {
    PVector v = surface(theta, phi + TAU*t, r); 
    stroke(255);
    strokeWeight(3);
    push();
    translate(v.x, v.y, v.z);
    //sphere(2);
    point(0, 0, 0);
    pop();
  }

  void drawLine(float t, int n) {
    PVector[] vectors = new PVector[n+1];
    float dt = length/n;
    for (int i = 0; i <= n; i++) {
      vectors[i] = surface(theta+dt, phi+dt*i-PI*t, r+t);
    }

    strokeWeight(weight);
    

    for (int i = 0; i < n; i++) {
      float m = map(mag(vectors[i].x, vectors[i].y, vectors[i].z), 0, r, 0, 1);
    stroke(255, 255*m);
      line(vectors[i].x, vectors[i].y, vectors[i].z, vectors[i+1].x, vectors[i+1].y, vectors[i+1].z);
    }
  }
}
