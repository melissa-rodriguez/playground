/**
 * boards in line
 *
 * @author aadebdeb
 * @date 2017/01/26
 */
PImage[] albums = new PImage[10];
PFont regular;
PFont bold;

int count = 0;

PImage spotifyIcon;
PImage spotifyLogo;
String[] artists = {"Kendrick Lamar", "Kendrick Lamar", "The Weeknd", "6black", 
  "Big Sean", "The Weeknd", "Playboi Carti", "Maluma", "Drake"};

PGraphics pg;
void setup() {
  size(1080, 1080, P3D);
  rectMode(CENTER);
  pixelDensity(2); 
  stroke(0);
  strokeWeight(1);
  imageMode(CENTER);
  for (int i = 0; i <albums.length; i ++) {
    albums[i] = loadImage("pic" + i +".png"); 
    albums[i].resize(300, 300);
  }

  spotifyIcon = loadImage("Spotify_Icon_RGB_Black.png");
  spotifyLogo = loadImage("Spotify_Logo_RGB_Green.png");

  spotifyLogo.resize(200, 60);

  pg = createGraphics(1080, 1080, P2D);
}

float t;
void draw() {
  background(0);


  //background(254,81,47);

  pushMatrix();
  stroke(255, 255, 255, 100);
  fill(255);
  displayAlbums();
  popMatrix();


  pushMatrix();
  displayText();
  popMatrix();

  count++;
  if (count>=artists.length) {
    count = 0;
  }
  //println(count);

  //rec();
}

void displayText() {

  pushMatrix();
  translate(0, 0, 0);
  //tint(255,50);
  image(spotifyLogo, 540, 960);

  popMatrix();
}

void displayAlbums() {
  translate(width / 2, height / 2, 0);
  rotateY(radians(745));
  int num = 10;
  float intervalX = map(1080, 0, width, 40, -50);
  float intervalY = map(abs(1080 - width / 2), 0, width / 2, 0, -20);
  float intervalZ = map(abs(1080 - width / 2), 0, width / 2, 0, -50);
  float rectX = 300;
  float rectY = 300;
  float rectZ = 7;
  float tilt = map(1080, 0, width, -20, 20);
  for (int i = num - 1; i > 0; i--) {
    pushMatrix();
    float rhytm = map(pow(abs(sin(frameCount * 0.03 - i * 0.3)), 50), 0, 1, 0, -50)
      * map(abs(1080 - width / 2), 0, width / 2, 0, 5);

    float upPos = intervalY * (i - num / 2.0) + rhytm;



    //float upPos = 0;
    translate(intervalX * (i - num / 2.0), upPos, intervalZ * (i - num / 2.0) );


    pushMatrix();
    fill(255);
    translate(0, 0, 3.6);
    tint(255, 255);
    image(albums[i], 0, 0);

    popMatrix();


    box(rectX, rectY, rectZ);


    popMatrix();
  }
}
