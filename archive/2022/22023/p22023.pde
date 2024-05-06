import peasy.*;
PeasyCam cam;

//Ring ring; 
ArrayList<Ring> rings; 

//meshStrip mesh; 
ArrayList<meshStrip> mesh; 
float radius = 300;

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  cam = new PeasyCam(this, 1200);

  int numRings = 1; 
  float h = 200; 


  rings = new ArrayList<Ring>();  
  mesh = new ArrayList<meshStrip>(); 



  for (int i = 0; i < 20; i++) {
    //float x = map(i, 0, 20, -1000, 1000); 
    mesh.add(new meshStrip(new PVector(i*radius/8, radius+5, 0), h, "init"));
  }
  //mesh.add(new meshStrip(new PVector(0, radius+5, 0), h));

  for (int i = 0; i < numRings; i++) {
    //float zOff = map(i, 0, numRings, 0, numRings*h); 
    rings.add(new Ring(new PVector(0, 0, -i*(h)), radius, h));
  }
}

void draw() {
  background(0);
  
 
  rotateY(radians(240)); 
  renderAll();
  
 
  //remove the meshes that are off the screen
  for (int i = mesh.size() - 1; i >= 0; i--) {
    meshStrip m = mesh.get(i);
    //println(m.xoff); 
    if (m.xoff > 800) {
      //println("here"); 
      mesh.remove(i);
    }
  }
  
  //if(frameCount<=180){
  // saveFrame("output/gif###.png");  
  //}else{
  // exit();  
  //}
}

void renderAll(){
   push();
  stroke(255); 
  strokeWeight(3);
  //fill(0);
  noFill();
  circle(0,0,600); // left
  //line(-10, radius+5, width, radius+5); 
  
  translate(0, 0, -200);
  circle(0,0,600); //right
  //line(-10, radius+5, width, radius+5); 
  pop();
  
  
  for (Ring ring : rings) {
    ring.render();
    ring.renderParticles(); 
    ring.update();
  }

  for (int i = 0; i < mesh.size(); i++) {
    meshStrip lastStrip = mesh.get(mesh.size()-1); 
    //println(lastStrip.xoff); 
    if (lastStrip.xoff > radius/8) {
      mesh.add(new meshStrip(new PVector(0, radius+5, 0), 200, "new"));
    }

    meshStrip m = mesh.get(i); 
    m.render();
    m.renderParticles();
    m.update();
  }
}
