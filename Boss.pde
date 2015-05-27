class Boss extends GameObject{
  int i = -1;
  Boss(PImage s, PVector loc){
    super(s, loc, 10);
    health = 300;
    left=loc.x-(img.width/2);
    top=loc.y-(img.height/2);
    right=loc.x+(img.width/2);
    bottom=loc.y+(img.height/2);
  }
  
  void update()
  {
    left=loc.x-(img.width/2);
    top=loc.y-(img.height/2);
    right=loc.x+(img.width/2);
    bottom=loc.y+(img.height/2);
   for (int i = 0; i < bullets.size(); i++)
     if(checkCollision(this, bullets.get(i)))
       {
         float x = ship.loc.x-this.loc.x;
         float y = ship.loc.y-this.loc.y;
         this.health--;
         int chance=int(random(4));
         if(chance==3)
         evilbullets.add(new EvilBullet(new PVector(boss.loc.x,boss.loc.y),new PVector(3*x/4,3*y/4)));
       } 
   if(this.health<=0)
   {
     gameState=2;
     go.clear();
     bullets.clear();
     evilbullets.clear();
     setup();
   }
   loc.add(vel);
   vel.limit(7);
   checkEdges();
  }
  
  
    void display(){
    
    pushMatrix();
    translate(loc.x, loc.y);
    imageMode(CENTER); 
    if(juanitoTime)
    {
    rotate((0.25*i)%(2*PI));
    i--;
    }
    image(img, 0, 0);
    popMatrix();
  }
  void checkEdges(){
     if(left < 0) {vel.x=5;}
     if(right > width) {vel.x=-5;}
     if(top < 0) {vel.y=5;}
     if(bottom > height) {vel.y=-5;}
   }
}

