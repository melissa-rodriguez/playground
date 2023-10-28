myShape shape;
float maxRadius = 300;
float spacing = 10;
float shapeSpacing;
float inc = 1;
void setup() {
  size(640, 640, P3D);
  pixelDensity(2);
}


float p, j, t, k = 5;
void draw() {
  background(0);
  stroke(255);
  fill(0);
  strokeWeight(4);
  //noFill();
  translate(width/2, height/2);
  shapeSpacing = 150;
  spacing = 70;
  //println(mouseX);

  t+=0.01;

  //rotateY(radians(frameCount));

  for (j = 0; j<k; j++) {
    p = (j+t)/k;
    maxRadius = 300*p;
    stroke(255*(p));
    push();
    translate(-shapeSpacing, -shapeSpacing);
    for (int i = 0; i<maxRadius; i+=spacing) {
      if (maxRadius-i <= 300) {
        shape = new myShape(0, 0, maxRadius*sin(TAU*(p-t))-i);
        shape.display();
      }
    }
    pop();


    push();
    translate(shapeSpacing, -shapeSpacing);
    //rotateY(-radians(frameCount));
    rotateY(PI);

    for (int i = 0; i<maxRadius; i+=spacing) {  
      if (maxRadius-i <= 300) {
        shape = new myShape(0, 0, maxRadius*sin(TAU*(p-t))-i);
        shape.display();
      }
    }
    pop();

    push();
    translate(shapeSpacing, shapeSpacing);
    //rotateY(radians(frameCount));
    rotateX(PI);
    rotateY(PI);

    for (int i = 0; i<maxRadius; i+=spacing) {  
      if (maxRadius-i <= 300) {
        shape = new myShape(0, 0, maxRadius*sin(TAU*(p-t))-i);
        shape.display();
      }
    }
    pop();



    push();
    translate(-shapeSpacing, shapeSpacing);
    //rotateY(-radians(frameCount));
    rotateX(PI);

    for (int i = 0; i<maxRadius; i+=spacing) {   
      if (maxRadius-i <= 300) {
        shape = new myShape(0, 0, maxRadius*sin(TAU*(p-t))-i);
        shape.display();
      }
    }
    pop();
  }

  maxRadius+=t;
  if(t > 1){
   t=0; 
   maxRadius=300;
  }

 
  //if(frameCount<=30){
  //  saveFrame("output/gif###.png");
  //}else{exit();}

  //if(frameCount < 72){
  //saveFrame("output/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
  
  //if(frameCount < 100){
  //  saveFrame("output/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}

class myShape {
  float x, y, r;
  myShape(float xpos, float ypos, float radius) {
    x = xpos;
    y = ypos;
    r = radius;
  }

  void display() {
    push();
    translate(x, y);
    squarePart();
    circlePart();

    pop();
  }

  void squarePart() {
    //play around with the roundness of the square corner
    rect(0, 0, r/2, r/2, p*50);
    rect(0, 0, 150, 150, p*50);
  }

  void circlePart() {
    //fill(255);
    noFill();
    noStroke();
    arc(0, 0, r, r, PI/2, TAU, OPEN);
    arc(0, 0, 300, 300, PI/2, TAU, OPEN);
  }
}
