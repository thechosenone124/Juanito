class PowerUp extends GameObject{
 PowerUp(PImage img, PVector loc, PVector vel){
   super(img, loc, vel, 5);
   health = 1;
 } 
 
  void run()
   {
     if(checkCollision(this, ship))
     {
       this.health--;
       ship.health+=2;
       ship.controlFactor++;
       int chance = (int)random(2);
       if (chance==1)
       ship.bulletVel++;
       chance = (int)random(100);
       if (chance==1)
       for(int i = 0; i < go.size(); i++)
       {
          go.remove(i);
          score++;
       }
     }     
     vel.limit(3);
     update();
     display();
     checkEdges();
   }
  
  void display(){
    pushMatrix();
    translate(loc.x, loc.y);
    imageMode(CENTER); 
    image(img, 0, 0);
    popMatrix();
  }
  void checkEdges(){
     if(right < 0||left > width||bottom < 0||top > height) health=0;
   }
}
