let shape; 

function setup() {
  createCanvas(1000, 1000);

  shape = new noiseCircle(width/2, height/2, 200); 
}

function draw() {
  background(240);
  // fill(0);
  // ellipse(width / 2, height / 2, 200);
  
  shape.show(); 
}

class noiseCircle{
  constructor(x,y,r_){
    this.pos = createVector(x,y); 
    this.r = r_; 
    this.noiseMax = 0.5; 
    this.numPoints = 100; 
    this.rMin = this.r/2; 
    this.rMax = this.r*2; 
  }

  show(){
    beginShape();
    noFill();
    for(let i = 0; i < this.numPoints; i++){
      let a = map(i, 0, this.numPoints, 0, TAU); 
      let xoff = map(cos(a), -1, 1, 0, 1); 
      let yoff = map(sin(a), -1, 1, 0, 1);
      let n = noise(xoff, yoff); 
      let r = map(n, 0, 1, this.rMin, this.rMax); 

      let x = this.pos.x + r*cos(a); 
      let y = this.pos.y + r*sin(a); 
      vertex(x,y); 
    }
    endShape(CLOSE); 
  }
}