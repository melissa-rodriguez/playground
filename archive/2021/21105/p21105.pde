PShader blur;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);

}

float size = 100;
float p, i, t, k = 20;
float a = 0;
void draw() {
  //size = mouseX;
  background(0);
  //filter(blur);  
  translate(width/2, height/2, 0);
  
  t+=0.01;
  noFill();
  stroke(255);
  strokeWeight(1.5);
  for (i = 0; i < k; i++) {
    p = (i+t)/k;
    for (float x = -width/2; x <= width/2+size; x+= size) {
      for (float y = -height/2; y <= height/2+size; y+= size) {
        //circle(x, y, size*(1-easeOutBounce(p)));
        push();
        //rotateY(TAU*easeOutBounce(p));
        //rotate(map(mouseX, 0, width, 0, TAU));
        polygon(0, 0, 300*(1-p), 6);
        //polygon(0, 0, 400*(p), 6);
        pop();
      }
    }
  }
  
  if(t>1){
   t=0; 
  }
  
  //if(t<1){
  // saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

//void mousePressed(){
// saveFrame("render###.png"); 
//}
