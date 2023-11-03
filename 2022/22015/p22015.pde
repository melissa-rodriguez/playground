OpenSimplexNoise noise; 

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
}

void draw() {
  background(240); 
  translate(width/2-(300*2.5), width/2+300, - 700); 
  //println(); 
  println(mouseX, mouseY); 

  ////----YELLOW----
  //for (int i = 0; i < 4; i++) {
  //  //for (int j = 0; j < 8; j++) {
  //    push();
  //    stroke(255, 200, 0, 150); 
  //    strokeWeight(5); 
  //    translate(200*i+4, 0-8); 
  //    draw_line(200, 3, "DIAGONAL");
  //    pop();
  //  //}
  //}

  ////----RED----
  //for (int i = 0; i < 4; i++) {
  //  //for (int j = 0; j < 8; j++) {
  //    push();
  //    stroke(255, 0, 0, 150); 
  //    strokeWeight(5); 
  //    translate(200*i+4, 0-3); 
  //    draw_line(200, 3, "DIAGONAL");
  //    pop();
  //  //}
  //}

  ////----DARK BLUE----
  //for (int i = 0; i < 4; i++) {
  //  //for (int j = 0; j < 8; j++) {
  //    push();
  //    stroke(0, 0, 255, 200); 
  //    strokeWeight(5); 
  //    translate(200*i-4, 0+3); 
  //    draw_line(200, 3, "DIAGONAL");
  //    pop();
  //  //}
  //}

  ////----LIGHT BLUE----
  //for (int i = 0; i < 4; i++) {
  //  //for (int j = 0; j < 8; j++) {
  //    push();
  //    stroke(137, 207, 255, 150); 
  //    strokeWeight(5); 
  //    translate(200*i-4, 0+8); 
  //    draw_line(200, 3, "DIAGONAL");
  //    pop();
  //  //}
  //}

  //for (int i = 0; i < 4; i++) {
  //  //for (int j = 0; j < 8; j++) {
  //    push();
  //    stroke(0); 
  //    strokeWeight(10); 
  //    translate(200*i, 0); 
  //    draw_line(200, 3, "DIAGONAL");
  //    pop();
  //  //}
  //}
  
  int size = 300; 
  int tileAmt = 5; 

  for (int i = 0; i < tileAmt; i++) {
    push(); 
    translate(size*i, 0); 
    draw_line(size, 4, "DIAGONAL");

    pop();
  }
}

void draw_line(float l, int n, String lineType) {
  PVector[][] vectors = new PVector[n+1][n+1]; 
  float dt = l/n; 
  int sw = 10; //sw
  float scale = 1.5; 

  for (int i = 0; i <=n; i++) {
    for (int j = 0; j <=n; j++) {
      vectors[i][j] = new PVector(dt*i, dt*j);
    }
  }



  for (int i = 0; i <n; i++) {
    for (int j = 0; j <n; j++) {
      //stroke(255, 0, 0); 
      point(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z);








      //-------YELLOW----------
      strokeWeight(scale*(sw/2)); //for highlights
      
      push();
      translate(4*scale, -8*scale); 
      stroke(255, 200, 0, 150); 
      if (lineType == "DIAGONAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j+1].x, vectors[i+1][j+1].y, vectors[i+1][j+1].z);
      } else if (lineType == "HORIZONTAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j].x, vectors[i+1][j].y, vectors[i+1][j].z);
      } else if (lineType == "VERTICAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i][j+1].x, vectors[i][j+1].y, vectors[i][j+1].z);
      }
      pop();

      //-------RED----------
      push();
      translate(4*scale, -3*scale); 
      stroke(255, 0, 0, 150); 
      if (lineType == "DIAGONAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j+1].x, vectors[i+1][j+1].y, vectors[i+1][j+1].z);
      } else if (lineType == "HORIZONTAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j].x, vectors[i+1][j].y, vectors[i+1][j].z);
      } else if (lineType == "VERTICAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i][j+1].x, vectors[i][j+1].y, vectors[i][j+1].z);
      }
      pop();

      //-------DARK BLUE----------
      push();
      translate(-4*scale, 3.2*scale); 
      stroke(0, 0, 255, 255); 
      if (lineType == "DIAGONAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j+1].x, vectors[i+1][j+1].y, vectors[i+1][j+1].z);
      } else if (lineType == "HORIZONTAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j].x, vectors[i+1][j].y, vectors[i+1][j].z);
      } else if (lineType == "VERTICAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i][j+1].x, vectors[i][j+1].y, vectors[i][j+1].z);
      }
      pop();

      //-------LIGHT BLUE----------
      push();
      translate(-4*scale, 8*scale); 
      stroke(137, 207, 255, 150); 
      if (lineType == "DIAGONAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j+1].x, vectors[i+1][j+1].y, vectors[i+1][j+1].z);
      } else if (lineType == "HORIZONTAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j].x, vectors[i+1][j].y, vectors[i+1][j].z);
      } else if (lineType == "VERTICAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i][j+1].x, vectors[i][j+1].y, vectors[i][j+1].z);
      }
      pop();


      //-------MAIN BLACK LINE----------
      strokeWeight(sw*scale); //for main line
      
      push();
      stroke(0); 
      if (lineType == "DIAGONAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j+1].x, vectors[i+1][j+1].y, vectors[i+1][j+1].z);
      } else if (lineType == "HORIZONTAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i+1][j].x, vectors[i+1][j].y, vectors[i+1][j].z);
      } else if (lineType == "VERTICAL") {
        line(vectors[i][j].x, vectors[i][j].y, vectors[i][j].z, 
          vectors[i][j+1].x, vectors[i][j+1].y, vectors[i][j+1].z);
      }
      pop();
    }
  }
  //for (int i = 0; i < n; i++) {
  //  push();
  //  stroke(255, 0, 0); 
  //  point(vectors[i].x, vectors[i].y, vectors[i].z); 
  //  pop();
  //  //line(vectors[i].x, vectors[i].y, vectors[i].z, vectors[i+1].x, vectors[i+1].y, vectors[i+1].z);
  //}
}

//void mousePressed(){
// saveFrame("render.png");  
//}
