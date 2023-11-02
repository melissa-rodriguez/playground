class meshStrip {
  PVector pos; 
  float size; 
  float w, h; 
  float numPoints; 
  float t; 
  float xoff; 
  String type; //specify type of mesh to ease in the stroke color

  int numParticles = 200; //Number of particles
  Particle[] particles = new  Particle[numParticles];

  meshStrip(PVector p, float s, String type_) {
    pos = p; 
    size = s; 
    w = size/4; 
    h = size; 
    numPoints = 20;
    type = type_; 

    for (int i = 0; i< numParticles; i++) {
      particles[i] = new Particle(); //add the particles
    }
  }

  void render() {
    stroke(255);
    fill(0);  
    strokeWeight(3); 
    noStroke(); 


    for (int i = 0; i < numPoints; i++) {
      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < numPoints; j++) {
        PVector v = mesh(i, j); 
        PVector v2 = mesh(i+1, j); 
        vertex(v.x, v.y, v.z); 
        vertex(v2.x, v2.y, v2.z);
      }
      endShape();
    }
  }

  void update() {
    t+=radians(2);
    xoff = t*180;
  }

  void renderParticles() {

    for (int i = 0; i < 200; i++) {
      //particles[i].draw_point(t);
      particles[i].draw_line(0, 7);
    }

    for (int i = 0; i < numParticles; i++) {
      particles[i].draw_point(t);
      //particles[i].draw_line(0, 7);
    }
  }

  PVector mesh(int i, int j) {
    float x = map(i, 0, numPoints, -w/2, w/2); 
    float y = 0; 
    float z = map(j, 0, numPoints, 0, -h);

    return new PVector(x+xoff, y, z).add(pos);
  }

  class Particle {
    int iIndex; 
    int jIndex;
    float len = 0.3; //scale of length of each line, between 0 and 1
    float sw; // strokeweight\
    float z;

    Particle() {
      iIndex = int(random(0, numPoints+1)); // choose a random theta value
      jIndex = int(random(0, numPoints+1)); 
      z = random(h); 

      //randomly vary the strokeweight between 1-5
      sw = constrain(5*randomGaussian(), 1, 10);
    }

    void draw_point(float t) {
      /*Note: we want the particles to rotate faster than the actual 
       torus is rotating which is why we increase the phase by 2*PI*t */
      PVector v = mesh(iIndex, jIndex);
      strokeWeight(sw); 
      if (type == "new") {
        stroke(map(xoff, 0, size/4, 0, 255));
      } else {
        stroke(255);
      }
      point(v.x, v.y, v.z);
    }

    void draw_line(float t, int n) {
      //store the vectors so that we can connect lines
      PVector[] vectors= new PVector[n+1]; 

      //n is the line resolution aka how many subdivisions make up the line
      float dt = len/n; 

      for (int i = 0; i <= n; i++) {
        vectors[i] = mesh(int(iIndex - dt*i), int(jIndex + dt*i));
      }


      strokeWeight(sw);
      if (type == "new") {
        stroke(map(xoff, 0, size/4, 0, 255));
      } else {
        stroke(255);
      }

      //render the lines 
      for (int i = 0; i < n; i++) {
        line(vectors[i].x, vectors[i].y, vectors[i].z, 
          vectors[i+1].x, vectors[i+1].y, vectors[i+1].z);
      }
    }
  }
}
