class dRing {
  PVector c1_Init, c2_Init; //Initial Tunnel Centers
  PVector c1_Curr, c2_Curr; //Current Tunnel Centers
  PVector meetPoint; //Where the tunnels meet
  float radius; //tunnel radius

  float numPoints;

  dRing(float x1, float y1, float z1, float x2, float y2, float z2) {
    c1_Init = new PVector(x1, y1, z1);
    c2_Init = new PVector(x2, y2, z2);    //Initialize 
    c1_Curr = new PVector(x1, y1, z1);
    c2_Curr = new PVector(x2, y2, z2);

    meetPoint = new PVector(0, 150, 0); //set meet point;
    numPoints = 90;
  }

  void update(float p) {
    //c1_Curr.x = 
    c1_Curr.z = 800-(p*0.1)*1e4;
    c2_Curr.z = c1_Curr.z;
    radius = pow(p, 8.0)*1000; //update radius
  }

  PVector surface(float theta, float phi) {
    float xPos1 = radius*c1_Curr.x + radius*cos(theta)*cos(phi+t);
    float yPos1 = c1_Curr.y + radius*sin(theta)*sin(phi+t);
    float zPos1 = c1_Curr.z;

    return new PVector(xPos1, yPos1, zPos1);
  }

  void display(float p) {
    float n1 = 10;
    //noFill()
    fill(0);
    strokeWeight(3);
    stroke(200, 255, 244);

    //for (float a=0; a<TAU; a+=TAU/numPoints) {
    for (int i = 0; i<n1; i++) {
      beginShape();
      for (int j = 0; j<n1; j++) {

        float theta1 = map(i, 0, n1, 0, TAU);
        float theta2 = map(i+1, 0, n1, 0, TAU);

        float phi = map(j, 0, n1, 0, 2*PI);

        //float xPos1 = c1_Curr.x + radius*cos(a);
        //fTRIANGLE_STRIPloat yPos1 = c1_Curr.y + radius*sin(a);
        //float zPos1 = c1_Curr.z;
        //float xPos2 = c2_Curr.x + radius*cos(a);
        //float yPos2 = c2_Curr.y + radius*sin(a);
        //float zPos2 = c2_Curr.z;

        PVector v1 = surface(theta1, phi);
        PVector v2 = surface(theta2, phi);

        //fill(255*map(radius, 0, 800, 0, 1));
        //fill(255*(1-p));
        //noStroke();
        //stroke(255, 255*p);
        vertex(v1.x, v1.y, v1.z);
        vertex(v2.x, v2.y, v2.z);

        //if (zPos1 < -300) {
        //push();
        //translate(xPos2, yPos2, zPos2);
        //circle(0, 0, 5*p);
        //pop();
        //}
      }
    }
    endShape(CLOSE);
  }
}
