import peasy.*;
OpenSimplexNoise noise;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2); 
  cam = new PeasyCam(this, 1000);
  noise = new OpenSimplexNoise();
  colorMode(HSB, 360);
}

void draw() {
  //background(#323232);
  //translate(size/2, size/2);
  background(0);
  lights();
  rotateX(sin(radians(frameCount*1)));
  rotateY(cos(radians(frameCount*1)));
  //translate(0, -100, 0);
  update();
  //if(frameCount <= 180){
  //saveFrame("output4/gif###.png");
  //}
  //else{exit();}
  //rec();
}

void update() {
  //clear();
  float span = 30; //box size?
  int face_color, frame_color;
  //beginShape();
  for (int x = -200; x <=200; x+= span) {
    for (int y = -200; y <=200; y+= span) {
      for (int z = -200; z <=200; z+= span) {
        PVector vec = new PVector(x, y, z);
        float max = max(abs(x), abs(y), abs(z));
        float noise_value = noise(x * 0.005, z *0.005, z*0.005); //diff than OG

        if (noise_value > map(max, 180, 300, 0.1, 0.55)) {
          face_color = color(map(max, 180, 300, 239, 39));
          frame_color = color(239);
          setBoxToMesh(vec, span, face_color, frame_color);
        }
      }
    }
  }
  zoff += 0.3;
  //endShape();
}

float zoff = 0;
void setBoxToMesh(PVector location, float size, float face_color, float frame_color) {
  //strokeWeight(sin(radians(frameCount*0.8))*5);
  
  noStroke();
  
  PVector v = new PVector(size*-0.5*0.99, size*0.5*0.99, size*-0.5*0.99);
  PVector pos = location.add(v);
  float noise_value = (float) noise.eval(pos.x * 0.005, pos.z *0.005, zoff*0.05);
  
  push();
  stroke(210, 100+(255*noise_value),360);
  fill(210, (255*noise_value),360);
  //stroke(50*noise_value, 105+(255*noise_value),360);
  //fill(50*noise_value, (255*noise_value),360);
  
  translate(pos.x, pos.y, pos.z);
  float boxSize = map(mouseX, -width/2, width/2, 1, 20);
  box(100 * noise_value, 20 * noise_value, 75 * noise_value);
  pop();


  //point(location.add(new PVector(size*-0.5*0.99, size*0.5*0.99, size*-0.5*0.99)).x, 
  //  location.add(new PVector(size*-0.5*0.99, size*0.5*0.99, size*-0.5*0.99)).y, 
  //  location.add(new PVector(size*-0.5*0.99, size*0.5*0.99, size*-0.5*0.99)).z);


  //point(location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * -0.5 * 0.99)).x, 
  //  location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * -0.5 * 0.99)).y, 
  //  location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * -0.5 * 0.99)).z);


  //point(location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).x, 
  //  location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).y, 
  //  location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).z);
    
  //  point(location.add(new PVector(size * -0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).x, 
  //  location.add(new PVector(size * -0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).y, 
  //  location.add(new PVector(size * -0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).z);
}
