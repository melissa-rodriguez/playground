import peasy.*; 
PeasyCam cam; 

PGraphics pg;
int numParticles;
Particle[] particles;



float t; //time variable to increase every time through draw
float r1 = 200; 
float r2 = 2*r1; 
float scale = 50; 


PVector surface(float theta, float phi, float r1, float r2) {
  //equation of a torus
  float x = scale*((3.5 + cos(theta+t / 2) * sin(phi) - sin(theta+t / 2) * sin(2 * phi)) * cos(theta));
  float y = scale*(( 3.5+ cos(theta+t / 2) * sin(phi) - sin(theta+t / 2) * sin(2 * phi)) * sin(theta));
  float z = scale*(1*sin(theta+t / 2) * sin(phi) + cos(theta+t / 2) * sin(2 * phi));

  return new PVector(x, y, z);
}

void draw_surface() {
  int theta_res= 40; 
  int phi_res= 80;  

  //stroke(255); 
  pg.noStroke(); //turn off the stroke, the surface should only be filled black to "hide" it
  pg.fill(0); 
  pg.strokeWeight(3); 

  for (int i = 0; i <= theta_res; i++) {
    pg.beginShape(TRIANGLE_STRIP); 
    for (int j = 0; j <= phi_res; j++) {
      float theta1 = map(i, 0, theta_res, 0, 2*PI); 
      float theta2 = map(i+1, 0, theta_res, 0, 2*PI); 

      float phi = map(j, 0, phi_res, 0, 2*PI);  

      PVector v1 = surface(theta1, phi, r1, r2); 
      PVector v2 = surface(theta2, phi, r1, r2); 

      pg.vertex(v1.x, v1.y, v1.z); 
      pg.vertex(v2.x, v2.y, v2.z);
    }
    pg.endShape(CLOSE);
  }
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
    sw = constrain(5*randomGaussian(), 2, 6);
  }

  void draw_point(float t) {
    /*Note: we want the particles to rotate faster than the actual 
     torus is rotating which is why we increase the phase by 2*PI*t */
    pg.stroke(255); 
    PVector v = surface(theta + 2*PI*0, phi + 2*PI*0, r1, r2);
    pg.strokeWeight(sw); 
    pg.point(v.x, v.y, v.z);
  }

  void draw_line(float t, int n) {
    //store the vectors so that we can connect lines
    PVector[] vectors = new PVector[n+1]; 

    //n is the line resolution aka how many subdivisions make up the line
    float dt = len/n; 

    for (int i = 0; i <= n; i++) {
      vectors[i] = surface(theta + 2*PI*0 - dt*i, phi - 2*PI*0 + dt*i, r1, r2);
    }


    strokeWeight(sw);
    stroke(255);

    //render the lines 
    for (int i = 0; i < n; i++) {
      pg.line(vectors[i].x, vectors[i].y, vectors[i].z, 
        vectors[i+1].x, vectors[i+1].y, vectors[i+1].z);
    }
  }
}

void setup() {
  size(1080, 1080, P3D); 
  pg = createGraphics(2000, 2000, P3D);
  smooth(8);

  numParticles = pg.width*9; //Number of particles
  particles = new  Particle[numParticles];

  //cam = new PeasyCam(this, 100); 

  for (int i = 0; i< numParticles; i++) {
    particles[i] = new Particle(); //add the particles
  }
}

void draw() {
  background(0); 
  t += radians(5); // increase each time through draw

  // ------ DRAW THE CENTER CIRCLE ------

  pg.beginDraw(); 
  pg.background(0); 
  pg.translate(pg.width/2, pg.height/2, pg.width/2+pg.width/3.5); 
  pg.rotateX(radians(90)); 
  pg.rotateY(radians(60)); 

  draw_surface();

  for (int i = 0; i < numParticles; i++) {
    particles[i].draw_point(t);
    //particles[i].draw_line(t, 7);
  }

  pg.endDraw(); 

  image(pg, 0, 0); 

  //if (frameCount <=72) {
  //  //saveFrame("output/gif###.png");
  //  pg.save("output/gif"+str(frameCount)+".png"); 
  //} else {
  //  exit();
  //}
  
  if (frameCount <=144) {
    //saveFrame("output/gif###.png");
    pg.save("output/gif"+str(frameCount)+".png"); 
  } else {
    exit();
  }
}
