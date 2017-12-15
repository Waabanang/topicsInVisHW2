class Particle{
  float x;
  float y;
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