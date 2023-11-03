//attempt to port code from https://al-ro.github.io/projects/curl/curl.js
//for curl flow

import peasy.*;
PeasyCam cam;

PGraphics canvas;

//flag for x direction flow
boolean flow = false;
boolean drawline = true;

//number of elements
int discCount = 1000; // arbitrary number of discs

//populate array with stationary discs at random locations
ArrayList<Disc> discs;

OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  canvas = createGraphics(width, height, P3D);

  cam = new PeasyCam(this, width/2, height/2, -50, width);

  //background(17, 27, 68, 255);
  //background(#03178C);
  background(0);
  //colorMode(HSB);


  discs = new ArrayList<Disc>();
  noise = new OpenSimplexNoise();

  for (int i = 0; i < discCount; i++) {
    discs.add(new Disc(random(width), random(height), random(100), 0, 0, 0, 5));
  }
}

//Move discs based on velocity and place them back in the domain if they go beyond the boundaries
//For flow, reintroduce discs at the left boundary, otherwise place in a random point
void move() {
  for (Disc d : discs) {
    if (d.xpos < d.r) {
      if (flow) {
        d.xpos = d.r;
        d.ypos = random(height);
      } else {
        d.xpos = random(width);
        d.ypos = random(height);
      }
    }

    if (d.ypos < d.r) {
      if (flow) {
        d.xpos = d.r;
        d.ypos = random(height);
      } else {
        d.xpos = random(width);
        d.ypos = random(height);
      }
    }

    if (d.xpos > width - d.r) {
      if (flow) {
        d.xpos = d.r;
        d.ypos = random(height);
      } else {
        d.xpos = random(width);
        d.ypos = random(height);
      }
    }

    if (d.ypos > height - d.r) {
      if (flow) {
        d.xpos = d.r;
        d.ypos = random(height);
      } else {
        d.xpos = random(width);
        d.ypos = random(height);
      }
    }

    d.xpos += d.xvel;
    d.ypos += d.yvel;
  }
}


float noise_; 
float[] curl = new float[2];

//Find the curl of the noise field based on on the noise value at the location of a disc
float[] computeCurl(float x, float y) {
  float eps = 0.0001;

  //find rate of change in x direction
  float n1 = (float) noise.eval(x + eps, y);
  float n2 = (float) noise.eval(x - eps, y);

  //average to find approximate derivative
  float a = (n1-n2)/(2*eps);
  curl[1] = -a;

  //find rate of change in y direction
  float n3 = (float) noise.eval(x, y + eps);
  float n4 = (float) noise.eval(x, y - eps);

  //avg to find approx derivative 
  float b = (n3 - n4)/(2 * eps);
  curl[0] = b;

  //curl
  return curl;
}

float initial_step = 100;
float speed = 0.5;
//step controls zoom of noise field. large value = biger vortices
//smaller value leads to more features
float step = initial_step;
float particle_size = 1.5;


float count = 0;
color[] col = {#0424D9, #031CA6, #3DADF2};
float zoff = 0;
void draw() {
  //background(240);
  //background(17, 27, 68, 10);
  lights();

  if (drawline) {
    canvas.beginDraw();
    canvas.pushMatrix();

    move();

    for (Disc d : discs) {
      //d.display();
      //find the curl of noise field at location of disc w the step
      float[] c = computeCurl(d.xpos/step, d.ypos/step);
      //set velocity of discs to the curl
      d.xvel = speed*curl[0];
      d.yvel = speed*curl[1];

      if (flow) {
        //add overall vel in positive x direction
        d.xvel += speed*3;
      }
      //canvas.fill(255, 20, 100);
      if (frameCount < 2) {
        //canvas.fill(#03178C);
        canvas.noFill();
        canvas.noStroke();
        //canvas.fill(255);
      } else {
        int choose = int(random(3));
        //canvas.fill(#031CA6);
        canvas.fill(#447EF2);
      }
      //canvas.stroke(61, 173, 242, 20);
      canvas.stroke(239, 19, 242, 30);
      //canvas.noStroke();
      canvas.arc(d.xpos, d.ypos, d.r, d.r, 0, TWO_PI);
      //circle(d.xpos, d.ypos, d.r);
    }
    canvas.popMatrix();
    canvas.endDraw();
  }

  zoff = count*.3;
  //if (zoff < 58) {
    translate(0, 0, zoff);
  //} else {
  //  translate(0, 0, 58);
  //}

  // apply view matrix of peasy to canvas
  cam.getState().apply(canvas);
  //rec();
  image(canvas, 0, 0);


  count +=speed;
  
  //colors();
  //rec();
}

void colors() {
  for (int s=0; s < discCount; s++) {
    red[s] = round(sin(freq1*s + phase1) * w + center);
    grn[s] = round(sin(freq2*s + phase2) * w + center);
    blu[s] = round(sin(freq3*s + phase3) * w + center);
  }
}

void mousePressed() {
  saveFrame("img###.png"); 
  println(zoff);
}
