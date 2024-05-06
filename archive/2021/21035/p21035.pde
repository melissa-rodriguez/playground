import peasy.*;
OpenSimplexNoise noise;
PeasyCam cam;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);
  noise = new OpenSimplexNoise();
}
float zspeed = 0;
void draw() {
  background(240);
  lights();

  //translate(size/2, size/2);
  //rotateX(sin(radians(frameCount)));
  rotateY(sin(radians(frameCount)));
  translate(0, 0, 0);
  //println(-100*mouseY);
  int colorind = floor(noise(random(5)));
  fill(0);
  update();
  if (frameCount <=360) {
    //saveFrame("output2/gif###.png");
  } else {
    //exit();
  }
  //rec();
}

void update() {
  clear();
  float span = 30; //box size?
  int face_color, frame_color;
  beginShape();
  for (int x = -300; x <=100; x+= span) {
    for (int y = -300; y <=100; y+= span) {
      for (int z = -300; z <=100; z+= span) {
        PVector vec = new PVector(x, y, z);
        float max = max(abs(x), abs(y), abs(z));
        float noise_value = noise(x * 0.005, z *0.005, z *0.005); //diff than OG

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
  strokeWeight(1.2);
  //noFill();
  //stroke(255, 0, 0);

  //fill(255);

  //noStroke();
  PVector v = new PVector(size*-0.5*0.99, size*0.5*0.99, size*-0.5*0.99);
  float n = (float) noise.eval(location.add(v).x, location.add(v).y, location.add(v).z*zoff*0.002);

  push();
  //translate(location.add(v).x, location.add(v).y, location.add(v).z*cos(n)*50);
  float m = map(n, -1, 1, 0.01, TAU);
  //float zpos = map(abs(location.add(v).z*pow(cos(n*TAU),3)), 0, 360, 255, 0 );
  if (cos(radians(frameCount)) < 0) {
    stroke(255);
  } else {
    stroke(0);
  }
  //println(location.add(v).z*pow(cos(n*TAU), 3));
  translate(location.add(v).x+150, location.add(v).y*sin(radians(frameCount)), location.add(v).z*cos(radians(frameCount)));
  box(12*n);
  pop();


  //PVector v2 = new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * -0.5 * 0.99);
  //push();
  //translate(location.add(v2).x, location.add(v2).y, location.add(v2).z);
  //box(10);
  //pop();

  //PVector v3 = new PVector(size * 0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99);
  //push();
  //translate(location.add(v3).x, location.add(v3).y, location.add(v3).z);
  //box(10);
  //pop();

  //PVector v4 = new PVector(size * -0.5 * 0.99, size * 0.5 * 0.99, size * 0.5 * 0.99);
  //push();
  //translate(location.add(v4).x, location.add(v4).y, location.add(v4).z);
  //box(10);
  //pop();



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
