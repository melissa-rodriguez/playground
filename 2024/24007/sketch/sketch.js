function setup() {
  createCanvas(1000, 1000);
}

let a = 0; 
function draw() {
  blendMode(BLEND);
  background(240);

  blendMode(MULTIPLY);

  noStroke();
  let r = 100;
  
  // Magenta circle
  fill(255, 0, 255);
  // ellipse(width / 2 - r / 2 * cos(a), height / 2, r * 2);
  ellipse(width / 2 - r / 2 , height / 2, r * 2);

  // Yellow circle
  fill(255, 255, 0);
  // ellipse(width / 2 + r / 2 * cos(a), height / 2, r * 2);
  ellipse(width / 2 + r / 2 , height / 2, r * 2);

  // Cyan circle
  fill(0, 255, 255);
  // ellipse(width / 2, height / 2 - r * sin(a), r * 2);
  ellipse(width / 2, height / 2 - r , r * 2);

  // a += radians(1); 
}
