// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain

// Floyd Steinberg Dithering
// Edited Video: https://youtu.be/0L2n8Tg2FwI

PImage kitten;
ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();

OpenSimplexNoise noise;

void setup() {
  size(1080, 1080);
  pixelDensity(2);
  kitten = loadImage("man.jpg");
  kitten.resize(1080, 1080);
  kitten.filter(GRAY);
  //image(kitten, 0, 0);
  
  slider_init();
  
  noise = new OpenSimplexNoise();
  
  
  ditherImage();
  background(0);

  for (int i = 0; i < kitten.width; i+=10) {
    for (int j = 0; j < kitten.height; j+=10) {
      color c = kitten.get(i, j);
      float b = map(brightness(c), 0, 255, 1, 0);
      if (b < 0.53) {
        //fill(c);
        
        pushMatrix();
        //fill(c);
        //stroke(c);
        //translate(i, j);
        points.add(new PVector(i, j));
        vehicles.add(new Vehicle(i, j));
        //ellipse(i, j, 1, 1);
        popMatrix();
      }
    }
  }
}

int index(int x, int y) {
  return x + y * kitten.width;
}


void ditherImage() {
  kitten.loadPixels();
  for (int y = 0; y < kitten.height-1; y++) {
    for (int x = 1; x < kitten.width-1; x++) {
      color col = kitten.get(x, y);
      float bright = brightness(col);
      if (bright < 100) {
        color pix = kitten.pixels[index(x, y)];
        float oldR = red(pix);
        float oldG = green(pix);
        float oldB = blue(pix);
        int factor = 1;
        int newR = round(factor * oldR / 255) * (255/factor);
        int newG = round(factor * oldG / 255) * (255/factor);
        int newB = round(factor * oldB / 255) * (255/factor);
        kitten.pixels[index(x, y)] = color(newR, newG, newB);

        float errR = oldR - newR;
        float errG = oldG - newG;
        float errB = oldB - newB;


        int index = index(x+1, y  );
        color c = kitten.pixels[index];
        float r = red(c);
        float g = green(c);
        float b = blue(c);
        r = r + errR * 7/16.0;
        g = g + errG * 7/16.0;
        b = b + errB * 7/16.0;
        kitten.pixels[index] = color(r, g, b);

        index = index(x-1, y+1  );
        c = kitten.pixels[index];
        r = red(c);
        g = green(c);
        b = blue(c);
        r = r + errR * 3/16.0;
        g = g + errG * 3/16.0;
        b = b + errB * 3/16.0;
        kitten.pixels[index] = color(r, g, b);

        index = index(x, y+1);
        c = kitten.pixels[index];
        r = red(c);
        g = green(c);
        b = blue(c);
        r = r + errR * 5/16.0;
        g = g + errG * 5/16.0;
        b = b + errB * 5/16.0;
        kitten.pixels[index] = color(r, g, b);


        index = index(x+1, y+1);
        c = kitten.pixels[index];
        r = red(c);
        g = green(c);
        b = blue(c);
        r = r + errR * 1/16.0;
        g = g + errG * 1/16.0;
        b = b + errB * 1/16.0;
        kitten.pixels[index] = color(r, g, b);
      }
    }
  }
  kitten.updatePixels();
  image(kitten, 0, 0);
}


void draw() {
  background(0);
  //ditherImage();
  //for(PVector p : points){
  // ellipse(p.x, p.y, 1,1); 
  //}
  
  for(Vehicle v : vehicles){
   v.behaviors();
   v.update();
   v.display(); 
  }
  
  //rec();
  //push();
  //fill(0);
  //textSize(50);
  //textAlign(CENTER, CENTER);
  //text("3.14.21", width/2, 100);
  //pop();
  //saveFrame("render/gif####.png");
}
