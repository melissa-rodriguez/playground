function setup() {
  createCanvas(1000, 1000);
  pixelDensity(1); // Set pixel density to 1 for consistent pixel mapping
}

function draw() {
  background(240);
  fill('red');
  noStroke();
  // ellipse(width / 2, height / 2, 400);
  rect(width / 2, height / 2, 400);

  let noiseScale = 0.07; // Adjust this value to control the intensity of the distortion
  let maxDisplacement = 100;
  glass_rasterize(noiseScale, maxDisplacement); 

  noLoop();
}

function glass_rasterize(noiseScale, maxDisplacement) {
  loadPixels();

  for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
      let index = (x + y * width) * 4;

      // Get displacement amount from noise map
      let noiseVal = noise(x * noiseScale, y * noiseScale) * maxDisplacement; // 50 is the maximum displacement amount

      // Apply displacement to x-coordinate
      let displacedX = floor(x + noiseVal);
      displacedX = constrain(displacedX, 0, width - 1);
      // Apply displacement to x-coordinate
      let displacedY = floor(y + noiseVal);
      displacedY = constrain(displacedY, 0, width - 1);

      // Map pixels from original image to canvas with displacement
      let displacedIndex = (displacedX + displacedY * width) * 4;
      pixels[index] = pixels[displacedIndex]; // Red
      pixels[index + 1] = pixels[displacedIndex + 1]; // Green
      pixels[index + 2] = pixels[displacedIndex + 2]; // Blue
      pixels[index + 3] = pixels[displacedIndex + 3]; // Alpha
    }
  }

  updatePixels();
}