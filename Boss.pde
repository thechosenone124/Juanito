class Boss extends GameObject{
  int i = -1;
  Boss(PImage s, PVector loc){
    super(s, loc, 10);
    health = 650;
    left=loc.x-(img.width/2);
    top=loc.y-(img.height/2);
    right=loc.x+(img.width/2);
    bottom=loc.y+(img.height/2);
    acc = new PVector(0,0);
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
         int chance=int(random(2));
         if(chance==1)
         {
           evilbullets.add(new EvilBullet(new PVector(boss.loc.x-45,boss.loc.y-40),new PVector(3*(ship.loc.x-(boss.loc.x-45))/4,3*(ship.loc.y-(boss.loc.y-40))/4)));//left eye
           evilbullets.add(new EvilBullet(new PVector(boss.loc.x+37,boss.loc.y-48),new PVector(3*(ship.loc.x-(boss.loc.x+37))/4,3*(ship.loc.y-(boss.loc.y-48))/4)));//right eye
           if(juanitoTime)
           {
             evilbullets.add(new EvilBullet(new PVector(boss.loc.x+7,boss.loc.y+20),new PVector(3*(ship.loc.x-(boss.loc.x+7))/4,3*(ship.loc.y-(boss.loc.y+20))/4)));//right nostril
             evilbullets.add(new EvilBullet(new PVector(boss.loc.x-7,boss.loc.y+20),new PVector(3*(ship.loc.x-(boss.loc.x-7))/4,3*(ship.loc.y-(boss.loc.y+20))/4)));//left nostril
           }
         }
       } 
   if(this.health<=0)
   {
     gameState=2;
     go.clear();
     bullets.clear();
     evilbullets.clear();
     setup();
   }
   if(juanitoTime)
   {
      acc = new PVector(.0001*(ship.loc.x-loc.x),.0001*(ship.loc.y-loc.y));
   }
   else
   {
      acc = new PVector(0,0); 
   }
   loc.add(vel);
   vel.add(acc);
   vel.limit(7);
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
     if(left < 0) {vel.x=5;}
     if(right > width) {vel.x=-5;}
     if(top < 0) {vel.y=5;}
     if(bottom > height) {vel.y=-5;}
   }
}

