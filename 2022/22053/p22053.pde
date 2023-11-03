void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  colorMode(HSB); 
  smooth(8);

}

void draw() {
  background(240);  
  gradient(); 
  
  
}

void mousePressed() {
  saveFrame("output.png");
}

void gradient(){
 noStroke(); 
  float grid_w = width/2; 
  float grid_h = height/1.5; 

  int ires = 1; 
  int jres = 5;  
  int res =200;

  for (int amt = 0; amt <res; amt++) {
    for (int i = 0; i < ires; i++) {
      for (int j = 0; j < jres; j++) {
        float x = map(i, 0, ires, 0, grid_w)+map(amt, 0, res, 0, grid_w); 
        float y = map(j, 0, jres, 0, grid_h); 
        float size = grid_h/jres; 
        if (j%2==0) {
          fill(map(x, 0, grid_w, 240, 0)); 
        } else {
          fill(map(x, 0, grid_w, 0, 240));  
        }
        circle(width/2 - grid_w/2 + x, height/2-grid_h/2+y+size/2, size);
      }
    }
  } 
}
