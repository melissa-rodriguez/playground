import peasy.*;
OpenSimplexNoise noise;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 500);
  noise = new OpenSimplexNoise();
}

void draw() {
  background(0);
  lights();
  //translate(size/2, size/2);
  rotateX(sin(radians(frameCount)));
  rotateY(cos(radians(frameCount)));
  translate(0, 0, 0);
  int colorind = floor(noise(random(5)));
  fill(0);
  //fill(240); 
  update();
  //saveFrame("output2/gif###.png");
  //rec();
}

void update() {
  clear();
  float span = 30; //box size?
  int face_color, frame_color;
  beginShape();
  for (int x = -300; x <=300; x+= span) {
    for (int y = -300; y <=300; y+= span) {
      for (int z = -300; z <=300; z+= span) {
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
  endShape();
  zoff += 0.02;
  
}
float zoff = 0;
float yoff = 0;
float xoff = 0;
color[] colorArray = new int[]{#F20544, #0597F2, #63CAF2, #F2CB05, #F28705};

void setBoxToMesh(PVector location, float size, float face_color, float frame_color) {
  //strokeWeight(sin(radians(frameCount*0.8))*5);
  //strokeWeight(1.2);
  //noFill();
  //stroke(255, 0, 0);
  
  //fill(255);
  stroke(240);
  //noStroke();
  float n = (float) noise.eval(location.x , location.y, zoff);
  box(location.x*n, location.y*n, location.z*n);
    
  stroke(255);
   
  
  //point(location.add(new PVector(size*-0.5*0.99, size*0.5*0.99, size*-0.5*0.99)).x, 
  //  location.add(new PVector(size*-0.5*0.99, size*0.5*0.99, size*-0.5*0.99)).y, 
  //  location.add(new PVector(size*-0.5*0.99, size*0.5*0.99, size*-0.5*0.99)).z);


  //point(location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * -0.5 * 0.99)).x, 
  //  location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * -0.5 * 0.99)).y, 
  //  location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * -0.5 * 0.99)).z);


  //point(location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).x, 
  //  location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).y, 
  //  location.add(new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).z);

  //point(location.add(new PVector(size * -0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).x, 
  //  location.add(new PVector(size * -0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).y, 
  //  location.add(new PVector(size * -0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99)).z);


  //------------------------------------------------------
  //stroke(0, 0, 255);
  //point(location.add(new PVector(size * -0.5, size * 0.5, size * -0.5)).x, 
  //  location.add(new PVector(size * -0.5, size * 0.5, size * -0.5)).y, 
  //  location.add(new PVector(size * -0.5, size * 0.5, size * -0.5)).z);

  //point(location.add(new PVector(size * 0.5, size * 0.5, size * -0.5)).x, 
  //  location.add(new PVector(size * 0.5, size * 0.5, size * -0.5)).y, 
  //  location.add(new PVector(size * 0.5, size * 0.5, size * -0.5)).z);
    
  //  point(location.add(new PVector(size * 0.5, size * 0.5, size * 0.5)).x, 
  //  location.add(new PVector(size * 0.5, size * 0.5, size * 0.5)).y, 
  //  location.add(new PVector(size * 0.5, size * 0.5, size * 0.5)).z);
    
  //  point(location.add(new PVector(size * -0.5, size * 0.5, size * 0.5)).x, 
  //  location.add(new PVector(size * -0.5, size * 0.5, size * 0.5)).y, 
  //  location.add(new PVector(size * -0.5, size * 0.5, size * 0.5)).z);
    
    
    //stroke(0, 255, 0);
    //point(location.add(new PVector(size * -0.5, size * -0.5, size * -0.5)).x, 
    //location.add(new PVector(size * -0.5, size * -0.5, size * -0.5)).y, 
    //location.add(new PVector(size * -0.5, size * -0.5, size * -0.5)).z);
    
    //point(location.add(new PVector(size * 0.5, size * -0.5, size * -0.5)).x, 
    //location.add(new PVector(size * 0.5, size * -0.5, size * -0.5)).y, 
    //location.add(new PVector(size * 0.5, size * -0.5, size * -0.5)).z);
    
    //point(location.add(new PVector(size * 0.5, size * -0.5, size * 0.5)).x, 
    //location.add(new PVector(size * 0.5, size * -0.5, size * 0.5)).y, 
    //location.add(new PVector(size * 0.5, size * -0.5, size * 0.5)).z);
    
    //point(location.add(new PVector(size * -0.5, size * -0.5, size * 0.5)).x, 
    //location.add(new PVector(size * -0.5, size * -0.5, size * 0.5)).y, 
    //location.add(new PVector(size * -0.5, size * -0.5, size * 0.5)).z);
}
