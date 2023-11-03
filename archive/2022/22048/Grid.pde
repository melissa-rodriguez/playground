class Grid {
  PVector gridPos; //starting at top left corner
  Vertex[][] verts; //all the vertices in the grid
  int ires, jres, cols, rows; 
  float w, h; //width and height of the grid

  Flowfield field; //each grid has a flowfield
  Particle particle; //single particle, to add more, create an arraylist
  //ArrayList<Particle> particles; 

  Grid(PVector p, float gridWidth, float gridHeight) {
    gridPos = p; 
    w = gridWidth; 
    h = gridHeight; 

    //ires = int(random(10, 50)); 
    ires = 20; 
    jres = ires; 
    cols = ires; 
    rows = jres; 

    verts = new Vertex[cols][rows];

    field = new Flowfield(w, h, ires); //initiate FF, same w, h, res as grid
    particle = new Particle(random(w), random(h)); //start on a position on the grid
    //particles = new ArrayList<Particle>();

    //for (int i = 0; i < 3; i++) {
    //  particles.add(new Particle(random(w), random(h)));
    //}

    init();
  }



  void init() {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        float x = gridPos.x + map(i, 0, ires, 0, w+100); //make the +100 better
        float y = gridPos.y + map(j, 0, jres, 0, h+100);

        verts[i][j] = new Vertex(x, y, 0);
      }
    }
  }

  void showGrid() {
    //fill(240);
    particle.follow(field);  //follow the flowfield embeded in the grid
    
    for (int j = 0; j < rows-1; j++) {
      beginShape(TRIANGLE_STRIP);
      fill(240); 
      stroke(0); 
      noFill();
      for (int i = 0; i < cols-1; i++) {
        Vertex v1 = verts[i][j];
        Vertex v2 = verts[i][j+1];

        //fill(v1.col); 
        v1.show(); 
        v2.show(); 

        v1.update(); 

        v1.behaviors(particle);
      }
      endShape();
    }
  }
}
