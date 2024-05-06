ArrayList<Bubble> bubbles;
OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  noise = new OpenSimplexNoise();

  bubbles = new ArrayList<Bubble>();

  int check = 0;

  background(0);
  //for(int i = 0; i < 10; i++){
  while (bubbles.size() < 2000 ) {

    float x = random(width);
    float y = random(height);
    //float r =  abs(30*randomGaussian());
    float r =  map((float)noise.eval(x*0.005,y*0.003), -1, 1, 1, 20);
    
    if (dist(x, y, width/2, height/2) < 500) {
      Bubble bubble = new Bubble(x, y,r);


      boolean overlapping = false; 
      for (Bubble otherBubble : bubbles) {
        float d = dist(bubble.x, bubble.y, otherBubble.x, otherBubble.y);
        if (d < bubble.r + otherBubble.r) {
          //they are overlapping 
          overlapping = true;
          break;
        }
      }

      if (!overlapping) {
        bubbles.add(bubble);
      }

      check++;
      if (check > 10000) {
        break;
      }
    }
  }

  for (Bubble b : bubbles) {
    b.show();
  }
  println(bubbles.size());
  
  //saveFrame("render.png");
}

void draw() {
}

class Bubble {
  float x, y, r; 
  Bubble(float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;
    
    
    
    noFill();
  }

  void show() {
    stroke(map(r, 1, 20, 30, 255));
    strokeWeight(map(r, 1, 20, 1, 5));
    circle(x, y, r*2);
  }
}
