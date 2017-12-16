class Particle{
  float x;
  float y;
  int life;
  boolean dead;
  int alpha;
  
  Particle(){
    x = 0;
    y = 0;
    life = 100; 
    dead = false;
    alpha = 1;
  }
  
  public void decay(){ 
    life -= 1;
    
    //fade particle in
    if (life > minlife) {
      alpha = min(alpha+40, 255);
    }
    //fade particle out
    if (life < minlife - 4) {
      alpha -= 255/minlife;
    }
    
    if (life < 0) {dead = true;}
  }
}