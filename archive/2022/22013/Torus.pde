/*
  Torus torus = new Torus(float r1, float r2, int res); 
 */

class Torus {
  float r1, r2; //radii of the torus (r2 > r1)
  int res; //resolution of surface
  float t1;
  float t2; 
  float t; 

  int theta_res;
  int phi_res; 

  int numParticles = 6000; //Number of particles
  Particle[] particles = new  Particle[numParticles];


  //if t is given as an argument, this will move
  Torus(float r1_, float r2_, int r) {
    r1 = r1_;
    r2 = r2_; 
    res = r;

    theta_res = res; 
    phi_res = res*5;

    for (int i = 0; i< numParticles; i++) {
      particles[i] = new Particle(); //add the particles
    }
  }


  //this function starts with PVector and not void because it will return a vector
  PVector surface(float theta, float phi, float r1, float r2) {
    //equation of a torus
    float phase = easeInBack(sin(phi + t1));
    float x = (r2+r1*(cos(theta+phase)))*cos(phi+t2);
    float y = (r2+r1*(cos(theta+phase)))*sin(phi+t2);
    float z = r1*sin(theta+phase);

    return new PVector(x, y, z); //return the position vector
  }

  void renderTorus() {

    stroke(255); 
    noStroke();
    fill(0); 
    strokeWeight(3); 

    for (int i = 0; i <= theta_res; i++) {
      beginShape(TRIANGLE_STRIP); //start the shape, specify triangle strip
      for (int j = 0; j <= phi_res; j++) {
        float theta1 = map(i, 0, theta_res, 0, 2*PI); 
        float theta2 = map(i+1, 0, theta_res, 0, 2*PI); //calculate theta2 for vector 2

        float phi = map(j, 0, phi_res, 0, 2*PI);  

        float xoff = map(cos(theta1), -1, 1, 0, 5); 
        float yoff = map(sin(theta1), -1, 1, 0, 5); 

        PVector v1 = surface(theta1, phi, r1, r2); 
        PVector v2 = surface(theta2, phi, r1, r2); 

        float n = (float)noise.eval(xoff, yoff); 

        float x1 = map(n, -1, 1, -v1.x, v1.x); 
        float x2 = map(n, -1, 1, -v2.x, v2.x); 

        float y1 = map(n, -1, 1, 0, v1.y); 
        float y2 = map(n, -1, 1, 0, v2.y); 

        float z1 = map(n, -1, 1, 0, v1.z); 
        float z2 = map(n, -1, 1, 0, v2.z); 


        vertex(v1.x, v1.y, v1.z); //vertex1
        vertex(v2.x, v2.y, v2.z); // vertex2
      }
      endShape(CLOSE); //CLOSE = connect the last point to the first point
    }
  }

  void renderPoints() {

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
    t1 += radians(1); 
    t = radians(TAU); 
    t2 += radians(0.2);
  }

  class Particle {
    float theta; 
    float phi;
    float len = 0.3; //scale of length of each line, between 0 and 1
    float sw; // strokeweight

    Particle() {
      theta = random(0, 2*PI); // choose a random theta value
      phi = random(0, 2*PI);  //choose a randome phi value

      //randomly vary the strokeweight between 1-5
      sw = constrain(5*randomGaussian(), 1, 30);
    }

    void draw_point(float t) {
      /*Note: we want the particles to rotate faster than the actual 
       torus is rotating which is why we increase the phase by 2*PI*t */
      PVector v = surface(theta + 2*PI*t, phi + 2*PI*t, r1, r2);
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
        vectors[i] = surface(theta + 2*PI*t - dt*i, phi - 2*PI*t + dt*i, r1, r2);
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
