import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.geom.*;


PImage textureImg;

int cols = 40;
int rows = 40;

Particle[][] particles = new Particle[cols][rows];
ArrayList<Spring> springs;

float radius = 100;
float w = 10;
Sphere s;

VerletPhysics3D physics;

ParticleConstraint3D sphere;

void setup() {
  size(1080, 1080, P3D); 
  
  textureImg = loadImage("texture8.png");
  textureImg.resize(width/4, height/4);
  
  springs = new ArrayList<Spring>();

  physics = new VerletPhysics3D();
  Vec3D gravity = new Vec3D(0, 0.15, 0);
  GravityBehavior3D gb = new GravityBehavior3D(gravity);
  physics.addBehavior(gb);

  //add sphere 
  //Sphere sphere = new Sphere(radius*2);
  //SphereConstraint(sphere, false);
  Vec3D sphereLocation = new Vec3D(0, 0, radius*2);
  s = new Sphere(sphereLocation, radius);
  sphere = new SphereConstraint(s, false);



  initAnimation();
  

  //particles[0][0].lock();
  //particles[cols-1][0].lock();
}
float a = 0;

void draw() {
  //background(0, 0, 30);
  background(240);

  translate(width/2, height/2);

  //rotateY(a);
  a += 0.01;
  physics.update();
  //rotateY(90);
  push();
  lights();
  fill(240);
  noStroke();
  translate(0, 0, radius*2);
  //showAxis();
  sphere(radius-1);
  pop();


  //stroke(255);
  noStroke();
  textureMode(NORMAL);
  for (int j = 0; j < rows-1; j++) {
    beginShape(TRIANGLE_STRIP);
    texture(textureImg);
    for (int i = 0; i < cols; i++) {
      //particles[i][j].addConstraint(sphereConstraint);
      //println(particles[i][j].intersectsSphere(sphere));
      //if(particles[i][j].y > 100){
      //Vec3D wind = new Vec3D(0,-100,0);
      //particles[i][j].addForce(wind);
      ////particles[cols/2][rows/2].lock();
      ////particles[cols/2-10][rows/2-10].lock();
      //}
      
      if(particles[i][j].y > height){
        initAnimation();
      }
      
      float x1 = particles[i][j].x;
      float y1 = particles[i][j].y;
      float z1 = particles[i][j].z;
      float u = map(i, 0, cols-1, 0, 1);
      float v1 = map(j, 0, rows-1, 0, 1);
      vertex(x1, y1, z1, u, v1);

      float x2 = particles[i][j+1].x;
      float y2 = particles[i][j+1].y;
      float z2 = particles[i][j+1].z;
      float v2 = map(j+1, 0, rows-1, 0, 1);
      vertex(x2, y2, z2, u, v2);
      //particles[i][j].display();
    }
    endShape();
  }


  //for (Spring s : springs) {
  //  s.display();
  //}
  //rec();
}

void showAxis() {
  push();
  //xaxis
  stroke(0, 255, 0);
  line(0, 0, 0, 200, 0, 0);
  pop();

  push();
  //yaxis
  stroke(255, 0, 0);
  line(0, 0, 0, 0, 200, 0);
  pop();

  push();
  //zaxis
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 200);
  pop();
}

void initAnimation(){
  float x = -cols*w/2;
  for (int i = 0; i < cols; i++) {
    float z = 0;
    for (int j = 0; j < rows; j++) {
      Particle p = new Particle(x, -550, z);
      particles[i][j] = p;
      physics.addParticle(p);
      p.addConstraint(sphere);
      z = z + w;
    }
    x = x + w;
  }

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Particle a = particles[i][j];
      if (i != cols-1) {
        Particle b1 = particles[i+1][j];
        Spring s1 = new Spring(a, b1);
        springs.add(s1);
        physics.addSpring(s1);
      }
      if (j != rows-1) {
        Particle b2 = particles[i][j+1];
        Spring s2 = new Spring(a, b2);
        springs.add(s2);
        physics.addSpring(s2);
      }
    }
  }
}
