// uwnd stores the 'u' component of the wind.
// The 'u' component is the east-west component of the wind.
// Positive values indicate eastward wind, and negative
// values indicate westward wind.  This is measured
// in meters per second.
Table uwnd;

// vwnd stores the 'v' component of the wind, which measures the
// north-south component of the wind.  Positive values indicate
// northward wind, and negative values indicate southward wind.
Table vwnd;

// An image to use for the background.  The image I provide is a
// modified version of this wikipedia image:
//https://commons.wikimedia.org/wiki/File:Equirectangular_projection_SW.jpg
// If you want to use your own image, you should take an equirectangular
// map and pick out the subset that corresponds to the range from
// 135W to 65W, and from 55N to 25N
PImage img;

int pcount; // number of simulated particles
int maxlife; // longest lifetime of a particle, in millis
int minlife; //shoretest lifetime of a particle, in millis
int start; //simulation start in millis
ArrayList<Particle> particles; 
float stepsize; //Integration step size




void setup() {
  // If this doesn't work on your computer, you can remove the 'P3D'
  // parameter.  On many computers, having P3D should make it run faster
  size(700, 400, P3D);
  pixelDensity(displayDensity());

  img = loadImage("background.png");
  uwnd = loadTable("uwnd.csv");
  vwnd = loadTable("vwnd.csv");

  pcount = 3000; // number of simulated particles
  maxlife = 200; // longest lifetime of a particle, in frames
  minlife = 0; //shoretest lifetime of a particle, in frames
  stepsize = 0.1;
  //initialize particles to a random position on the screen
  particles = new ArrayList<Particle>(pcount);
  for (int i = 0; i < pcount; i++) {
    Particle p = new Particle();
    initializeParticle(p);
    particles.add(p);
  }
}

void draw() {
  background(255);
  image(img, 0, 0, width, height);
  drawMouseLine();
  drawParticles();
}

void drawMouseLine() {
  // Convert from pixel coordinates into coordinates
  // corresponding to the data.
  float a = mouseX * uwnd.getColumnCount() / width;
  float b = mouseY * uwnd.getRowCount() / height;

  // Since a positive 'v' value indicates north, we need to
  // negate it so that it works in the same coordinates as Processing
  // does.
  float dx = readInterp(uwnd, a, b) * 10;
  float dy = -readInterp(vwnd, a, b) * 10;
  line(mouseX, mouseY, mouseX + dx, mouseY + dy);
}

void drawParticles(){
  beginShape(POINTS);
  for (int i = 0; i < pcount; i++){
    Particle p = particles.get(i);
    p.decay();
    if (p.dead){
      initializeParticle(p);
    } else {
      updateParticle(p);
    }
    p.lastX = p.x;
    p.lastY = p.y;
    vertex(p.x, p.y); 
  }
  endShape();
}

void initializeParticle(Particle p){
  p.x = (int)random(width + 1);
  p.y = (int)random(height + 1);
  p.life = (int)random(minlife, maxlife + 1);
  p.dead = false;
}

void updateParticle(Particle p){
  // Convert from pixel coordinates into coordinates
  // corresponding to the data.
  float a = p.x * uwnd.getColumnCount() / width;
  float b = p.y * uwnd.getRowCount() / height;

  // Euler's integration(?)
  float dx = readInterp(uwnd, a, b) * 10;
  float dy = -readInterp(vwnd, a, b) * 10;
  p.x += dx * stepsize;
  p.y += dy * stepsize;
}

// Reads a bilinearly-interpolated value at the given a and b
// coordinates.  Both a and b should be in data coordinates.
float readInterp(Table tab, float a, float b) {
  float x = a;
  float y = b;
  int x1 = (int)a;
  int y1 = (int)b;
  int x2 = (int)a + 1;
  int y2 = (int)b + 1;
  float Q11 = readRaw(tab, x1, y1);
  float Q12 = readRaw(tab, x1, y2);
  float Q21 = readRaw(tab, x2, y1);
  float Q22 = readRaw(tab, x2, y2);
  // TODO: do bilinear interpolation
  return (1 / ((x2 - x1)*(y2 - y1))) * 
    (Q11 * (x2 - x) * (y2 - y) +
    Q21 * (x - x1) * (y2 - y) +
    Q12 * (x2 - x) * (y - y1) +
    Q22 * (x - x1) * (y - y1));
}

// Reads a raw value 
float readRaw(Table tab, int x, int y) {
  if (x < 0) {
    x = 0;
  }
  if (x >= tab.getColumnCount()) {
    x = tab.getColumnCount() - 1;
  }
  if (y < 0) {
    y = 0;
  }
  if (y >= tab.getRowCount()) {
    y = tab.getRowCount() - 1;
  }
  return tab.getFloat(y, x);
}