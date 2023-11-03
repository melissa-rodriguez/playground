import peasy.*;
PeasyCam cam;

void setup(){
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 100);
  sphereDetail(4);
}

float p, i, t, k = 100;
void draw(){
  background(0);
  //background(0, 20);
  //fill(0, mouseX);
  //rectMode(CENTER);
  //square(0,0, width);
  strokeWeight(3);
  fill(240);
  rect(-1, -height/2, 540, 1080);
  
  
  
  t += 0.02;
  translate(0, -60, 0);
  for(i = 0; i < k; i++){
   p = (i+t)/k;
   float numPoints = 50;
   //float radius = ouseX*p;
   //float radius = pow(p, 8)*1000;
   float radius = 800*p;
   beginShape();
   for(float a = 0; a < TAU; a+= TAU/numPoints){
    //float x = radius*cos(a*TAU*(p));
    float x = pow(a*(p), 3)*1000;
    float y = radius*pow(sin(a*TAU*(p)),3);
    
    //noStroke();
    stroke(0);
    //fill(0);
    noFill();
    push();
    rotateX(TAU*p);
    translate(x, y, 1000*p-1e3);
    //circle(0, 0, 10*p);
    //line(0, 0, 0, 50*p);
    //vertex(0,0,0);
    
    //sphere(10*p);
    curveVertex(x, y, 0);
    pop();
   }
   endShape();
  }
  
  
  
  rotateY(radians(180));
  for(i = 0; i < k; i++){
   p = (i+t)/k;
   float numPoints = 50;
   //float radius = ouseX*p;
   //float radius = pow(p, 8)*1000;
   float radius = 800*p;
   beginShape();
   for(float a = 0; a < TAU; a+= TAU/numPoints){
    //float x = radius*cos(a*TAU*(p));
    float x = pow(a*(p), 3)*1000;
    float y = radius*pow(sin(a*TAU*(p)),3);
    
    //noStroke();
    stroke(255);
    //fill(0);
    noFill();
    push();
    rotateX(TAU*p);
    translate(x, y, 1000*p-1e3);
    //circle(0, 0, 10*p);
    //line(0, 0, 0, 50*p);
    //vertex(0,0,0);
    
    //sphere(10*p);
    curveVertex(x, y, 0);
    pop();
   }
   endShape();
  }
  
 
  
  if(t>1){
   t = 0; 
  }
  if(frameCount <= 50){
    //saveFrame("output/gif###.png");
  }
  else{
    //exit();
  }
}
