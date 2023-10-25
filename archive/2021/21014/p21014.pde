
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;


// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/jrk_lOg_pVA

//import toxi.geom.*;
//import toxi.physics.*;
//import toxi.physics2d.*;
//import toxi.physics2d.behaviors.*;
//import toxi.physics2d.constraints.*;


int cols = 40;
int rows = 40;

Particle[][] particles = new Particle[cols][rows];
ArrayList<Spring> springs;

float w = 10;

VerletPhysics2D physics;
AttractionBehavior2D mouseAttractor;
Vec2D mousePos;

void setup() {
  size(1080, 1080, P2D); 
  springs = new ArrayList<Spring>();

  physics = new VerletPhysics2D();
  Vec2D gravity = new Vec2D(0, 1);
  GravityBehavior2D gb = new GravityBehavior2D(gravity);
  physics.addBehavior(gb);
  
  physics.setWorldBounds(new Rect(0, 0, width, height));

  addParticles();
  addSprings();

  particles[0][0].lock();
  particles[cols-1][0].lock();
  particles[0][rows-1].lock();
  particles[cols-1][rows-1].lock();
}

boolean showSpring = true;
void draw() {
  background(0);
  //translate(width/2, height/2);
  physics.update();

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      //particles[i][j].display();
      //if(particles[i][j].y > height/2+100){
      // physics.removeParticle(particles[i][j]); 
      //}
    }
  }


  for (Spring s : springs) {
    s.display();
    if(s.a.y > height/2 + 300){
     physics.removeSpringElements(s); 
     //println(s);
     
    }
  }
  

  
  //if(frameCount <= 300){
  // saveFrame(); 
  //}
  //if(frameCount == 300){
  // println( "all frames saved");
  //}
  rec();
}

void mousePressed() {
  mousePos = new Vec2D(mouseX, mouseY);
  // create a new positive attraction force field around the mouse position (radius=250px)
  mouseAttractor = new AttractionBehavior2D(mousePos, 100, 0.9f);
  physics.addBehavior(mouseAttractor);

}

void mouseDragged() {
  // update mouse attraction focal point
  mousePos.set(mouseX, mouseY);
  
  
}

void mouseReleased() {
  // remove the mouse attraction when button has been released
  physics.removeBehavior(mouseAttractor);
 
}

void addParticles(){
 float x = width/2-cols*w/2;
  for (int i = 0; i < cols; i++) {
    float y = height/2-rows*w/2;
    for (int j = 0; j < rows; j++) {
      Particle p = new Particle(x, y);
      particles[i][j] = p;
      physics.addParticle(p);
      y = y + w;
    }
    x = x + w;
  } 
}

void addSprings(){
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
