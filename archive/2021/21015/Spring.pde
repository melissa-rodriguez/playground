// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/jrk_lOg_pVA

class Spring extends VerletSpring3D {

  Spring(VerletParticle3D a, VerletParticle3D b, float dist, float force) {
    super(a, b, dist, force);
  }
  
  void display() {
    push();
    stroke(#E7F291);
    strokeWeight(2);
    line(a.x, a.y, a.z, b.x, b.y, b.z);
    pop();
  } 
}
