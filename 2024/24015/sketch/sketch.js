let brush;
let colors = ['#a8a50c', '#e8e719', '#f48358', '#a99dc2','#f0d6d6'];

function setup() {
  createCanvas(1000, 1000);



}

function draw() {
  background(240);
  // background('#b2b2b3');
  

  let col = colors[3];
  noStroke();


  let noiseMax = .5;
  let amt = 200;
  let radius = 300;
  let a = 30; //alpha

  brush = new Brush(radius, noiseMax, amt, col, a); 
  
  translate(width/2, height/2); 
  rotate(PI/2);
  brush.show();



  noLoop();

}

class Brush {
  constructor(r, noiseMax_, strokeAmt_, col_, alpha_) {
    this.noiseMax = noiseMax_;
    this.radius = r;
    this.strokeAmt = strokeAmt_; //amount of strokes within each brush spot
    this.col = col_; //stroke col
    this.alpha = alpha_; 

  }

  
  show() {
    let rMax = this.radius;
    let rMin = -rMax / 4;
    let deflection = this.radius/3; 
    
    for (let i = 0; i < this.strokeAmt; i++) {
      beginShape();

      for (let a = 0; a <= TAU * 2; a += radians(4)) {
        let xoff = map(cos(a), -1, 1, 0, this.noiseMax);
        let yoff = map(sin(a), -1, 1, 0, this.noiseMax);
        // let r = width / 2;
        let n = noise(xoff + i * 12345, yoff + i * 12345);
        let r = map(n, 0, 1, rMin, rMax);
        let transX = map(noise(xoff + a * random(12345), yoff + a * random(12345)), 0, 1, -deflection, deflection);
        let transY = map(noise(xoff + a * random(12345), yoff + a * random(12345)), 0, 1, -deflection, deflection);
        let x = transX + r * cos(a);
        let y = transY + r * 2 * sin(a);
        noFill();
        stroke(red(this.col), green(this.col), blue(this.col), this.alpha);
        curveVertex(x, y)
      }
      endShape();

    }
  }
}