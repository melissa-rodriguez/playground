Brush brush; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);

  brush = new Brush(); 
  background(240);
  colorMode(HSB);
}

boolean brushDown=false; 
void draw() {
  if(frameCount > 5){
    if (keyPressed) {
    if (key == 'b' || key == 'B') {
      brush.render(mouseX, mouseY, true); 
    }
  } else {
    brush.render(mouseX, mouseY, false); 
  }
    
  }
}

class Brush {
  PVector center; 
  float numPoints = 1000;
  float r; 
  float size = 100; 
  float theta; 
  ArrayList<PVector> points = new ArrayList<PVector>(); 
  Brush() {
    //center = new PVector(x, y);

    for (float i = 0; i < numPoints; i++) {
      r = size*sqrt(random(1)); 
      theta = random(TAU); 
      float xpos = r*cos(theta); 
      float ypos = r*sin(theta); 
      points.add(new PVector(xpos, ypos));
    }
  }

  void render(float dx, float dy, boolean brushDown) {

    for (PVector pt : points) {
      float ptx = dx + pt.x; 
      float pty = dy + pt.y; 
      if (brushDown) {
        stroke(map(dist(ptx, pty, width/2, height/2), 0, width/2, 255, 155), 155, 255); 
        point(ptx, pty);
      }
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      brushDown = false; 
    } else if (keyCode == DOWN) {
      println("here"); 
      brushDown = true; 
    }
  } 
}

void mousePressed(){
 saveFrame("output###.png");  
}
