class Particle{
  int x;
  int y;
  int lastX;
  int lastY;
  int life;
  boolean dead;
  
  Particle(){
    x = 0;
    y = 0;
    life = 100; 
    dead = false;
  }
  
  public void decay(){ 
    life -= 1;
    if (life < 0) {dead = true;}
  }


}