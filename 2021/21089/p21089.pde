void setup() {
  size(600, 600, P3D);
  pixelDensity(2);
}

float p, i, t, k = 100;
void draw() {
  background(0);
  t+=0.01;
  //noFill();
  //stroke(255);
  //strokeWeight(2);
  translate(width/2, height/2);
  for (i = 0; i<k; i+=1) {
    p = (i+t)/k;
    //for(float a = 0 ; a<PI;a+=01){
    
    push();
    //rotateY(66*TAU*p);
    //rotateX(TAU*p);
    //stroke(255, 255*p);
    circle(0, 0, 270*p);
    //circle(width/2, height/2, 300*p);
    //circle(100, 0/2, 300*p);

    pop();
  }

  if (t >= 1) {
    t = 0;
  }
  
  //println(mouseX);
  //if(frameCount<100){
  //  saveFrame("output/gif###.png");
  //}
  //else{
    
  // exit(); 
  //}
}

float count = 0;
void keyPressed() {
  if (keyCode == RIGHT) {
    count++;
  }
  if (keyCode==LEFT) {
    count--;
  }
  println(count);
}
