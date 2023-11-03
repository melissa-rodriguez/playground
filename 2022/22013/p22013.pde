import peasy.*;
PeasyCam cam;

OpenSimplexNoise noise; 

Torus torus; 

void setup() {
  size(900, 900, P3D); 
  pixelDensity(2);
  torus = new Torus(45, 475, 20); 
  //torus = new Torus(60, 15, 5); 
  
  noise = new OpenSimplexNoise(); 

  cam = new PeasyCam(this, 200);
}

void draw() {
  background(0);
  //println(mouseX, mouseY); 
  
  
  push();
  translate(250, 380, -100); 
  //rotateY(radians(-220)); 
  torus.renderTorus(); 
  torus.renderPoints();
  pop(); 
  
  push();
  translate(-350, 380); 
  rotateY(radians(220)); 
  torus.renderTorus(); 
  torus.renderPoints();
  pop(); 
  
  push();
  translate(350, -380); 
  rotateY(radians(-220)); 
  torus.renderTorus(); 
  torus.renderPoints();
  pop(); 
  
  
  torus.update(); 
  
  //if(frameCount <= 720){
  // saveFrame("output3/gif###.png");  
  //}else{
  // exit();  
  //}
}
