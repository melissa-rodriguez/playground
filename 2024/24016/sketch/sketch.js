let rec;

function setup() {
  createCanvas(1000, 1000);
  strokeCap(SQUARE);


  let w = 400;
  let h = 200; 
  let x = width/2;
  let y = height/2; 
  let numStrips = 5;
  rec = new gradientRect(x, y, w, h, numStrips);

}

function draw() {
  background(240);
  rec.show();

}

class gradientRect{
  constructor(x, y, w, h, numStrips_){
    this.pos = createVector(x,y); 
    this.rectW = w; 
    this.rectH = h; 
    this.numStrips = numStrips_; 
    this.stripWidth = this.rectW/this.numStrips; 
  }

  show(){
    strokeWeight(this.stripWidth); 

    for(let i = 0; i < this.numStrips; i++){
      push();
      translate(this.pos.x, this.pos.y); 
      let xpos = this.stripWidth/2 + (this.stripWidth * i); 
      let ypos = 0; 
      let col = map(xpos, this.stripWidth/2, this.stripWidth/2 + (this.stripWidth * this.numStrips), 0, 255);
      stroke(col); 
      line(xpos, ypos, xpos, ypos + this.rectH);
      pop();
    }
  }
}