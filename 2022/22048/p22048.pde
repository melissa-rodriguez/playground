//TODO: CREATE A FUNCTION THAT SELECTS A RANDOM TYPE OF FLOWFIELD (EXPLORE DIFFERENT FLOWFIELDS)
import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise; 

ArrayList<Grid> grids; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  colorMode(HSB); 
  cam = new PeasyCam(this, 1200);
  noise = new OpenSimplexNoise(); 

  grids = new ArrayList<Grid>();
  PVector gridPos = new PVector(0, 0, 0);
  float gridWidth = 1080;
  float gridHeight = 1080; 
  
  grids.add(new Grid(gridPos, gridWidth, gridHeight)); 
}

void draw() {
  background(240); 
  translate(-width/2, -height/2); //offset peasy cam

  for(Grid grid : grids){
   grid.showGrid(); 
   grid.field.showField(); 
   //grid.field.updateField(); 
  }
  
  //saveFrame("output/gif###.png"); 
}

void mousePressed(){
 saveFrame("output###.png");  
}
