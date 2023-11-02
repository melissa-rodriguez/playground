class Object {
  //PVector pos; //pos of vertices?
  int len; //amt of points/vertices each line will have (limit = resolution of grid)
  int res; //resolution of the grid
  Object(int res) {
    //pos = new PVector(0, 0);
    len = 4;
  }

  //boolean isIntersecting(
  //float noiseRandom(){
    
  //}

  void renderLine() {
    beginShape();
    stroke(255);
    strokeWeight(2);
    int count = 0;
    ArrayList<PVector> vertices = new ArrayList<PVector>();
    for (int i = 0; i < gridPoints.size(); i++) { //go through every point in the grid

      if (count < len) { //as long as the count is less than the length (vertex amt) :
        int index = int(random(gridPoints.size())); //get a random index from the grid

        if (gridPoints.get(index).filled == false) { //if the random position is not filled :

          PVector pos = gridPoints.get(index).pos; //get the position from the random index
          gridPoints.get(index).filled = true; //mark the positions as filled
          vertices.add(pos);
          //println(pos);
          vertex(pos.x, pos.y);
          //point(pos.x, pos.y);
        }
      } else {
        break;
      }
      count++;
    }
    endShape();

    for (PVector v : vertices) {
      stroke(255, 0, 0);
      strokeWeight(8);
      point(v.x, v.y );
    }
  }

  void renderBezier() {
    beginShape();
    int count = 0;
    ArrayList<PVector> vertices = new ArrayList<PVector>();
    for (int i = 0; i < gridPoints.size(); i++) { //go through every point in the grid

      if (count < len) { //as long as the count is less than the length (vertex amt) :
        int index = int(random(gridPoints.size())); //get a random index from the grid

        if (gridPoints.get(index).filled == false) { //if the random position is not filled :

          PVector pos = gridPoints.get(index).pos; //get the position from the random index
          gridPoints.get(index).filled = true; //mark the positions as filled
          //println(pos);
          vertices.add(pos);
          //vertex(pos.x, pos.y);
          //point(pos.x, pos.y);
        }
      } else {
        break;
      }
      count++;
    }

    PVector v1 = vertices.get(0);
    PVector v2 = vertices.get(1);
    PVector v3 = vertices.get(2);
    PVector v4 = vertices.get(3);

    bezier(v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);

    endShape();
  }


  void renderArc() {
    beginShape();
    int count = 0;
    ArrayList<PVector> vertices = new ArrayList<PVector>();
    for (int i = 0; i < gridPoints.size(); i++) { //go through every point in the grid

      if (count < 2) { //as long as the count is less than the 2 (vertex amt) :
        int index = int(random(gridPoints.size())); //get a random index from the grid

        if (gridPoints.get(index).filled == false) { //if the random position is not filled :

          PVector pos = gridPoints.get(index).pos; //get the position from the random index
          gridPoints.get(index).filled = true; //mark the positions as filled
          vertices.add(pos);//add the pos to vertices array
          //println(pos);
          //vertex(pos.x, pos.y);
          //point(pos.x, pos.y);
        }
      } else {
        break;
      }
      count++;
    }

    PVector v1 = vertices.get(0);
    PVector v2 = vertices.get(1);
    float d = dist(v2.x, v2.y, v1.x, v1.y);
    arc(v1.x, v1.y, dist(v1.x, v1.y, v2.x, v2.y), 100, 0, PI);
    endShape();
  }
}
