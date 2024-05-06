// Total number of frames in the gif
int numFrames = 80;

float scale = 10;
float r1 = 10;
float r2 = 6;
import peasy.*;

PeasyCam cam;

// 3D parameterized surface
PVector surface(float theta, float phi, float r1, float r2) {
    float x =  scale*(r1+r2*cos(theta))*cos(phi);
    float y = scale*(r1+r2*cos(theta))*sin(phi); 
    float z = scale*r2*(sin(theta));
    
    //float x = scale*(r1+r2*cos(3*theta))*(cos(3*phi));
    //float y = scale*(r1+r2*cos(3*theta))*(sin(3*phi));
     

    return new PVector(x,y,z);
}

// Draws surface
void draw_surface() {
    int n1 = 40; // theta subdivisions
    int n2 = 80; // phi subdivisions

    stroke(255); // white lines
    fill(0); // black fill

    noStroke();

    for (int i = 0; i < n1; i++) {
        beginShape(TRIANGLE_STRIP);
        for (int j = 0; j < n2+1; j++) {
            float theta1 = map(i,0,n1,0,TAU); 
            float theta2 = map(i+1,0,n1,0,TAU);

            float phi = map(j,0,n2,0,TAU);

            PVector v1 = surface(theta1,phi,r1,r2);
            PVector v2 = surface(theta2,phi,r1,r2);
            
            vertex(v1.x,v1.y,v1.z);
            vertex(v2.x,v2.y,v2.z);
        }
        endShape();
    }
}

class Particle {
    float theta;
    float phi;
    float offset;
    float weight = 2; 
    float length = .3; 

    Particle() {
        offset = random(0,1);
        theta = random(0,2*PI);
        phi = random(0,2*PI);
    }

    Particle(float l) {
        offset = random(0,1);
        theta = random(0,2*PI);
        phi = random(0,2*PI);
        weight = random(1,2);
        length = l;
    }

    void draw_point(float t) {
        PVector v = surface(theta + 2*PI*t,phi ,r1,r2);
        stroke(255);
        strokeWeight(3);
        push();
        translate(v.x,v.y,v.z);
        sphere(2);
        pop();
    }

    void draw_line(float t, int n) {

        PVector[] vectors = new PVector[n+1];
        float dt = length/n;
        for (int i = 0; i <= n; i++) {
            vectors[i] = surface(theta+dt*i+2*PI*t,phi+dt ,r1,r2);
        }

        strokeWeight(weight);
        stroke(255);

        for (int i = 0; i < n; i++) {
            line(vectors[i].x,vectors[i].y,vectors[i].z,vectors[i+1].x,vectors[i+1].y,vectors[i+1].z); 
        }
    }
}

PVector camera_path(float t) {
    float x = 150+150*sin(t*2*PI - 3*PI/2);
    float y = 0;
    float z = -200*sin(t*2*PI);

    return new PVector(x,y,z);
}

float cameraX = 400;
float cameraY = 0;
float cameraZ = 0;

int numParticles = 2000; 
Particle[] particles = new Particle[numParticles];

void setup() {
    size(1080,1080,P3D);
    pixelDensity(2);
    sphereDetail(3);

    //camera(cameraX,cameraY,cameraZ,0,0,0,0,-1,0);
    cam = new PeasyCam(this, 125);

    for (int i = 0; i < numParticles; i++) {
        particles[i] = new Particle(random(0.05,0.5)); 
    }
}

float t = 0;
void draw() {
    background(0);
    //float t = 1.0*(frameCount-1)/numFrames;
    t+=0.005;

    //camera(cameraX,cameraY,cameraZ,0,0,0,0,-1,0);

    pushMatrix();

    //rotateX(PI/2);
    //rotate(TAU*t);
    
    //rotateY(PI*t);


    draw_surface();

    for (int i = 0; i < numParticles; i++) {
        particles[i].draw_line(t,7);
        particles[i].draw_point(t); 
    }

    popMatrix();
    
    //if(t>2){
    // t=0; 
    //}
    //if(t<2){
    // saveFrame("output/gif###.png"); 
    //}
    //else{
    // exit(); 
    //}
    // Saves the frame
    //println(frameCount,"/",numFrames);
    //saveFrame("fr###.png");
    
    //if(frameCount <=100){
    // saveFrame("output/gif###.png"); 
    //}
    //else{
    // exit(); 
    //}

    //// Stops when all the frames are rendered
    //if(frameCount == numFrames){
    //    exit();
    //}
}
