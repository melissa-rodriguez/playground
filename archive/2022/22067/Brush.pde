class Brush {
  PVector pos; 
  int numPoints; 
  ArrayList<PVector> brushPoints; //store the points that make up the brush
  float r; // translates to the strokeweight
  
  Brush(PVector brushPos, float sw, int res) {
    pos = brushPos; 
    numPoints = res; 
    r = sw; 
    
    brushPoints = new ArrayList<PVector>(); 
    createPoints(); 
  }
  
  void createPoints(){
    for(float a = 0; a < TAU; a += TAU/numPoints){
      float size = r*sqrt(random(1)); 
      
      //for more scattered line (variable thickness -- > dithering effect almost)
      //float x = pos.x + size*randomGaussian()*cos(a); 
      //float y = pos.y + size*randomGaussian()*sin(a); 
      
      //for uniform line (even thickness)
      float x = pos.x + size*cos(a); 
      float y = pos.y + size*sin(a); 
      
      brushPoints.add(new PVector(x, y)); 
    }
  }
  
  void render(){
    for(PVector pt : brushPoints){
     point(pt.x, pt.y);  
    }
  }
}
