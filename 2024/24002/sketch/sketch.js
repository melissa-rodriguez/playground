function setup() {
  createCanvas(1000, 1000);
  pixelDensity(1); // Set pixel density to 1 for consistent pixel mapping
}

function draw() {
  background(240);
  fill('red');
  noStroke();
  ellipse(width / 2, height / 2, 400);

  let noiseScale = .001; // Adjust this value to control the intensity of the distortion
  let maxDisplacement = 80; // How close is the displaced pixel to the original image
  let stripWidth = 10; // Width of strips

  glass_rasterize_strips(stripWidth, noiseScale, maxDisplacement);

  noLoop();
}

function glass_rasterize_strips(stripWidth, noiseScale, maxDisplacement) {
  loadPixels();

  // Use a separate noise variable for consistent displacement across the canvas
  let noiseY = 0;

  for (let y = 0; y < height; y++) {
    noiseY += noiseScale; // Increment noiseY to generate a new noise value for each row

    for (let x = 0; x < width; x++) {
      let index = (x + y * width) * 4;

      // Calculate displacement amount based on noise map
      let noiseVal = noise(noiseY) * maxDisplacement;

      // Map pixels from original image to canvas with displacement
      let displacedX = floor(x + map(x % stripWidth, 0, stripWidth, -noiseVal, noiseVal));
      displacedX = constrain(displacedX, 0, width - 1);

      let displacedIndex = (displacedX + y * width) * 4;

      pixels[index] = pixels[displacedIndex]; // Red
      pixels[index + 1] = pixels[displacedIndex + 1]; // Green
      pixels[index + 2] = pixels[displacedIndex + 2]; // Blue
      pixels[index + 3] = pixels[displacedIndex + 3]; // Alpha
    }
  }

  updatePixels();
}
