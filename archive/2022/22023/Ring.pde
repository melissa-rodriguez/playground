class Ring {
  PVector pos;
  float size; 
  float numPoints; 
  float h; 
  float t; 

  int numParticles = 3000; //Number of particles
  Particle[] particles = new  Particle[numParticles];

  Ring(PVector p, float s, float stripHeight) {
    pos = p; 
    size = s;
    numPoints = 80;
    h = stripHeight; 

    for (int i = 0; i< numParticles; i++) {
      particles[i] = new Particle(); //add the particles
    }
  }

  void render() {
    stroke(255); 
    strokeWeight(3); 
    //noFill(); 
    fill(0); 
    noStroke(); 

    beginShape(TRIANGLE_STRIP); 
    for (int i = 0; i <= numPoints; i++) { 
      float theta = map(i, 0, numPoints, 0, TAU);       
      PVector v = ring(theta).add(pos); 


      vertex(v.x, v.y, v.z);
      vertex(v.x, v.y, v.z-h);
    }
    endShape(CLOSE);
  }



  PVector ring(float theta) {
    float x = size*cos(theta+t);
    float y = size*sin(theta+t); 
    float z = 0;

    return new PVector(x, y, z);
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

  void update() {
    t-=radians(1);
  }

  class Particle {
    float theta; 
    float phi;
    float len = 0.3; //scale of length of each line, between 0 and 1
    float sw; // strokeweight\
    float z;

    Particle() {
      theta = random(0, 2*PI); // choose a random theta value
      z = random(-h,0); 

      //randomly vary the strokeweight between 1-5
      sw = constrain(5*randomGaussian(), 1, 30);
    }

    void draw_point(float t) {
      /*Note: we want the particles to rotate faster than the actual 
       torus is rotating which is why we increase the phase by 2*PI*t */
      PVector v = ring(theta + 2*PI*1).add(new PVector(0, 0, z)).add(pos); ;
      strokeWeight(sw); 
      stroke(255); 
      point(v.x, v.y, v.z);
    }

    void draw_line(float t, int n) {
      //store the vectors so that we can connect lines
      PVector[] vectors= new PVector[n+1]; 

      //n is the line resolution aka how many subdivisions make up the line
      float dt = len/n; 

      for (int i = 0; i <= n; i++) {
        vectors[i] = ring(theta + 2*PI*1 - dt*i).add(new PVector(0, 0, z)).add(pos);
      }


      strokeWeight(sw);
      stroke(255);

      //render the lines 
      for (int i = 0; i < n; i++) {
        line(vectors[i].x, vectors[i].y, vectors[i].z, 
          vectors[i+1].x, vectors[i+1].y, vectors[i+1].z);
      }
    }
  }
}
