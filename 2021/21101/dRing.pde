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

    meetPoint = new PVector(0, 0, 0); //set meet point;
    numPoints = 90;
  }

  void update(float p) {
    //c1_Curr.x = 
    c1_Curr.x = lerp(c1_Init.x, meetPoint.x, pow(p, 2));
    c1_Curr.y = lerp(c1_Init.y, meetPoint.y, pow(p, 2));  // Move the Tunnels towards the meet point
    c2_Curr.x = lerp(c2_Init.x, meetPoint.x, pow(p, 2));
    c2_Curr.y = lerp(c2_Init.y, meetPoint.y, pow(p, 2));
    c1_Curr.z = 800-(p*0.1)*1e4; //"extrude" the tunnel
    c2_Curr.z = c1_Curr.z;
    radius = pow(p, 8.0)*1000; //update radius
  }

  void display(float p) {
    for (float a=0; a<TAU; a+=TAU/numPoints) {
      float xPos1 = c1_Curr.x + radius*cos(a)+200*sin(3*PI*p)-200; // add the sin func to make it curve
      float yPos1 = c1_Curr.y + radius*sin(a);
      float zPos1 = c1_Curr.z;
      float xPos2 = c2_Curr.x + radius*cos(a)-200*sin(3*PI*p)+200;
      float yPos2 = c2_Curr.y + radius*sin(a);
      float zPos2 = c2_Curr.z;
      if (dist(xPos1, yPos1, c2_Curr.x, c2_Curr.y) >= radius) {
        push();
        rotateY(TAU*p);
        translate(xPos1, yPos1, zPos1);
        circle(0, 0, 5*p);
        pop();
      }    
      if (dist(xPos2, yPos2, c1_Curr.x, c1_Curr.y) >= radius) {
        push();
        rotateY(TAU*p);
        translate(xPos2, yPos2, zPos2);
        circle(0, 0, 5*p);
        pop();
        //sphere(5*p);
      }
      
    }
  }
}
