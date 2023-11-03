class Brush {
  PVector pos; 
  int numPoints; 
  ArrayList<PVector> brushPoints; //store the points that make up the brush
  float r; // translates to the strokeweight
  boolean uniformStroke; //is the stroke of the brush consistent or varied (dithered effect)

  Brush(PVector brushPos, float sw, int res, boolean uniform) {
    pos = brushPos; 
    numPoints = res; 
    r = sw; 
    uniformStroke = uniform; 

    brushPoints = new ArrayList<PVector>(); 
    createPoints();
  }

  void createPoints() {
    for (float a = 0; a < TAU; a += TAU/numPoints) {
      float size = r*sqrt(random(1)); 

      //for more scattered line (variable thickness -- > dithering effect almost)
      float x = pos.x + size*randomGaussian()*cos(a); 
      float y = pos.y + size*randomGaussian()*sin(a); 

      if (uniformStroke) {
        //for uniform line (even thickness)
         x = pos.x + size*cos(a); 
         y = pos.y + size*sin(a);
      }

      brushPoints.add(new PVector(x, y));
    }
  }

  void render(color strokeCol) {
    pg.stroke(strokeCol); 
    for (PVector pt : brushPoints) {
      pg.point(pt.x, pt.y);
    }
  }
}
