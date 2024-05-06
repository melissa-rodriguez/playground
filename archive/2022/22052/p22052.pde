ArrayList<Rect> rects; 
OpenSimplexNoise noise; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  colorMode(HSB);
  rects = new ArrayList<Rect>(); 
  noise = new OpenSimplexNoise(); 

  float grid_w = width/2; 
  float grid_h = height/2; 

  int ires = 5; 
  int jres = 1; 

  for (int i = 0; i < ires; i++) {
    for (int j = 0; j < jres; j++) {
      float x = map(i, 0, ires, 0, grid_w); 
      float y = map(j, 0, jres, 0, grid_h); 
      rects.add(new Rect(width/2 - grid_w/2 + x, height/2 - grid_h/2 + y, 
        ires, jres, grid_w, grid_h, i, j));
    }
  }
}

void draw() {
  background(240); 

  for (Rect rect : rects) {
    rect.render();
  }

  //rotate(PI); 
  for (Rect rect : rects) {
    rect.render();
  }

  //saveFrame("render.png"); 
  noLoop();
}

class Rect {
  PVector rectPos; 
  float w, h; 
  float gridWidth, gridHeight; 
  int i, j; 
  int ires, jres; 
  float phase; 

  color topCol, bottomCol; 

  Rect(float x, float y, int ires_, int jres_, float grid_w, float grid_h, int i_, int j_) {
    rectPos = new PVector(x, y); 
    gridWidth = grid_w; 
    gridHeight = grid_h; 
    i = i_; 
    j = j_; 
    ires = ires_;
    jres = jres_; 

    phase = map((float)noise.eval(x*0.008, y*0.008), 0, 1, 0, TAU); 

    w = gridWidth/ires; 
    h = gridHeight/jres; 

    topCol = color(#283D28);
    bottomCol = color(#B1C9A4);

  }

  void render() {
    noFill(); 
    noStroke(); 
    //float topScale = map(i, 0, ires, 0.75, 0.25); 
    //float bottomScale = map(i, 0, ires, 0.25, 0.75); 

    float topScale = map(sin(map(i, 0, ires, 0, 2*TAU+phase)), -1, 1, 0.75, 0.25); 
    float bottomScale = map(sin(map(i, 0, ires, 0, 2*TAU+phase)), -1, 1, 0.25, 0.75); 

    float topSize = h*topScale; 
    float bottomSize = h*bottomScale; 

    fill(topCol); 
    rect(rectPos.x, rectPos.y, w, topSize); 
    push(); 
    fillPoints(rectPos.x, rectPos.y, w, topSize, "top");
    pop(); 

    fill(bottomCol); 
    rect(rectPos.x, rectPos.y+topSize, w, bottomSize);
    push(); 
    fillPoints(rectPos.x, rectPos.y+topSize, w, bottomSize, "bottom");
    pop();
  }

  void fillPoints(float x, float y, float rectW, float rectH, String type) {
    int pointResX = int(rectW/ires); 
    int pointResY = int(rectH/jres); 


    for (int i = 0; i <= pointResX; i++) {
      for (int j = 0; j <= pointResY; j++) {
        //float pointX = x + map(i, 0, pointResX, 0, rectW); 
        //float pointY = y + map(j, 0, pointResY, 0, rectH); 
        float pointX = x + random(0, rectW); 
        float pointY = y + random(0, rectH);
        if (type == "top") {
          stroke(bottomCol, 35);
        } else if (type == "bottom") {
          stroke(topCol, 35);
        }
        point(pointX, pointY);
      }
    }
  }
}

void mousePressed() {
  saveFrame("output###.png");
}
