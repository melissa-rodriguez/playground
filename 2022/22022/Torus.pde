/*
  Torus torus = new Torus(float r1, float r2, int res); 
*/

class Torus {
  float r1, r2; //radii of the torus (r2 > r1)
  int res; //resolution of surface
  float t;

  
  //if t is given as an argument, this will move
  Torus(float r1_, float r2_, int r) {
    r1 = r1_;
    r2 = r2_; 
    res = r;
  }


  //this function starts with PVector and not void because it will return a vector
  PVector surface(float theta, float phi, float r1, float r2) {
    //equation of a torus
    float phase = easeInExpo(map(sin(phi + t), -1, 1, 0, TAU));
    float x = (r2+r1*(cos(theta+phase)))*cos(phi);
    float y = (r2+r1*(cos(theta+phase)))*sin(phi);
    float z = r1*sin(theta+phase);

    return new PVector(x, y, z); //return the position vector
  }

  void render() {
    int theta_res= res; 
    int phi_res= res;  

    stroke(255); 
    fill(0); 
    strokeWeight(3); 

    for (int i = 0; i <= theta_res; i++) {
      beginShape(TRIANGLE_STRIP); //start the shape, specify triangle strip
      for (int j = 0; j <= phi_res; j++) {
        float theta1 = map(i, 0, theta_res, 0, 2*PI); 
        float theta2 = map(i+1, 0, theta_res, 0, 2*PI); //calculate theta2 for vector 2

        float phi = map(j, 0, phi_res, 0, 2*PI);  

        PVector v1 = surface(theta1, phi, r1, r2); 
        PVector v2 = surface(theta2, phi, r1, r2); 

        vertex(v1.x, v1.y, v1.z); //vertex1
        vertex(v2.x, v2.y, v2.z); // vertex2
      }
      endShape(CLOSE); //CLOSE = connect the last point to the first point
    }
  }
  
  void update(){
   t += radians(1);  
  }
  
}
