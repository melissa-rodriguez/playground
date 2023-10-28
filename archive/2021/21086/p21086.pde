myShape shape;
float maxRadius = 300;
float spacing = 10;
float shapeSpacing;
float inc = 1;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
}


void draw() {
  background(0);
  stroke(255);
  strokeWeight(1.5);
  noFill();
  translate(width/2, height/2);
  shapeSpacing = 150;
  spacing = 20;
  //println(mouseX);
  
  
  push();
  translate(-shapeSpacing, -shapeSpacing);
  //rotateY(radians(frameCount));
  for (int i = 0; i<maxRadius; i+=spacing) {
    if(maxRadius-i <= 300){
    shape = new myShape(0, 0, maxRadius-i);
    shape.display();
    }
  }
  pop();


  push();
  translate(shapeSpacing, -shapeSpacing);
  //rotateY(-radians(frameCount));
  rotateY(PI);

  for (int i = 0; i<maxRadius; i+=spacing) {  
    if(maxRadius-i <= 300){
    shape = new myShape(0, 0, maxRadius-i);
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
    if(maxRadius-i <= 300){
    shape = new myShape(0, 0, maxRadius-i);
    shape.display();
    }
  }
  pop();



  push();
  translate(-shapeSpacing, shapeSpacing);
  //rotateY(-radians(frameCount));
  rotateX(PI);

  for (int i = 0; i<maxRadius; i+=spacing) {   
    if(maxRadius-i <= 300){
    shape = new myShape(0, 0, maxRadius-i);
    shape.display();
    }
  }
  pop();
  
  maxRadius++;

  //if(frameCount<=30){
  //  saveFrame("output/gif###.png");
  //}else{exit();}

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
    rect(0, 0, r/2, r/2, 5);
    rect(0, 0, 150, 150, 5);
  }

  void circlePart() {
    fill(0);
    arc(0, 0, r, r, PI/2, TAU, OPEN);
    arc(0, 0, 300, 300, PI/2, TAU, OPEN);
  }
}
