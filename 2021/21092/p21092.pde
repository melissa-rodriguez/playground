import peasy.*;
PeasyCam cam;
void setup(){
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
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
  
  t += 0.01;
  
  for(i = 0; i < k; i++){
   p = (i+t)/k;
   float numPoints = 50;
   //float radius = ouseX*p;
   //float radius = pow(p, 8)*1000;
   float radius = 800*p;
   for(float a = 0; a < TAU; a+= TAU/numPoints){
    float x = radius*cos(a*TAU*(p));
    //float x = pow(a*(p), 3)*1000;
    float y = radius*pow(sin(a*TAU*(p)),3);
    
    noStroke();
    fill(255);
    push();
    rotate(TAU*p);
    translate(x, y, 1000*p-1e3);
    //circle(0, 0, 10*p);
    
    sphere(10*p);
    stroke(255,100);
    line(0, 0, -100*p, -100*p);
    pop();
   }
  }
  
  //if(t>1){
  // t = 0; 
  //}
  if(frameCount <= 50){
    //saveFrame("output/gif###.png");
  }
  else{
    //exit();
  }
}
