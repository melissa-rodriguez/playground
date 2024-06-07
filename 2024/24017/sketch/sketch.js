let rec;
let pixelArray;

function setup() {
  createCanvas(1000, 1000);
  strokeCap(SQUARE);

  // Create a gradient rectangle
  let x = 0;
  let y = 0;
  let w = width;
  let h = height;
  let numStrips = 20;
  rec = new GradientRect(x, y, w, h, numStrips);

  background(255 / 2);
  rec.show();

  loadPixels();

  // Create an array to store the pixel data
  pixelArray = [];

  // Loop through all the pixels and save their RGBA values
  for (let i = 0; i < pixels.length; i += 4) {
    let r = pixels[i];
    let g = pixels[i + 1];
    let b = pixels[i + 2];
    let a = pixels[i + 3];
    pixelArray.push(r, g, b, a);
  }

  // Clear the canvas and draw a line for reference
  clear();
  background(240);
  strokeWeight(50);
  stroke(0);
  line(0, height / 2, width, height / 2);
}

function draw() {
  let d = pixelDensity();
  loadPixels();
  // Loop through all the pixels
  for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
      // Get the pixel's index in the pixel array
      let index = (x + y * width) * 4 * d; // Each pixel takes 4 array elements (RGBA)
      // Get the brightness of the pixel
      let bright = (pixelArray[index] + pixelArray[index + 1] + pixelArray[index + 2]) / 3;
      let xDisplacement = 0;
      let yDisplacement = 100;

      // Map the brightness to a displacement value
      // let rand = random(1, 50); 
      let displacement = map(bright, 0, 255, 1, -1);
      let xDisp = displacement * xDisplacement;
      let yDisp = displacement * yDisplacement;


      // Apply displacement to current pixel
      let newX = constrain(x + xDisp, 0, width - 1); // Ensure newX stays within canvas bounds
      let newY = constrain(y + yDisp, 0, height - 1); // Ensure newY stays within canvas bounds


      // Get the color of the displaced pixel
      let r = pixels[index];
      let g = pixels[index + 1];
      let b = pixels[index + 2];
      let a = pixels[index + 3];

      // Update the canvas with the displaced pixel
      set(newX, newY, color(r, g, b, a));
    }
  }

  // Apply changes to the canvas
  background(240);
  updatePixels();
  noLoop(); // Stop the draw loop
}

// Class for creating a gradient rectangle
class GradientRect {
  constructor(x, y, w, h, numStrips_) {
    this.pos = createVector(x, y);
    this.rectW = w;
    this.rectH = h;
    this.numStrips = numStrips_;
    this.stripWidth = this.rectW / this.numStrips;
  }

  show() {
    strokeWeight(this.stripWidth);

    for (let i = 0; i < this.numStrips; i++) {
      push();
      translate(this.pos.x, this.pos.y);
      let xpos = this.stripWidth / 2 + (this.stripWidth * i);
      let ypos = 0;
      let col = map(xpos, this.stripWidth / 2, this.stripWidth / 2 + (this.stripWidth * this.numStrips), 255, 0);
      stroke(col);
      line(xpos, ypos, xpos, ypos + this.rectH);
      pop();
    }
  }
}
