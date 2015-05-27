class Juan extends GameObject{
 Juan(PImage s, PVector loc, PVector vel){
   super(s, loc, vel, 1);
   health = 5;
 } 
 Juan(PImage s, PVector loc){
   super(s, loc, 1);
   health = 5;
 } 
 
  
  void update()
   {
      for (int i = 0; i < bullets.size(); i++)
     if(checkCollision(this, bullets.get(i)))
       {
       this.health--;
       }
      if (checkCollision(this,boss))
      {
      if(bottom<boss.loc.y||top>boss.loc.y)
        {
        vel.y*=-1;
        loc.y+=2*vel.y;
        }
      if(right<boss.loc.x||left>boss.loc.x)
        {
        vel.x*=-1;
        loc.x+=2*vel.x;
        }
      }
      if (checkCollision(this,ship))
      {
        if(bottom<ship.loc.y)
        {
          vel.y=-abs(vel.y);
          loc.y-=10;
        }
        if(top>ship.loc.y)
        {
          vel.y=abs(vel.y);
          loc.y+=10;
        }
        if(right<ship.loc.x)
        {
          vel.x=-abs(vel.x);
          loc.x-=10;
        }
        if(left>ship.loc.x)
        {
          vel.x=abs(vel.x);
          loc.x+=10;
        }
      }
    vel.limit(7);
    vel.add(acc);
    loc.add(vel);
    
    if(img!=null)
    {
      left=loc.x-(img.width/2);
      top=loc.y-(img.height/2);
      right=loc.x+(img.width/2);
      bottom=loc.y+(img.height/2);
    }
      if(health<=0)
      vel=new PVector(0,0);
      if(juanitoTime)
        {
        acc = new PVector(.001*(ship.loc.x-loc.x),.001*(ship.loc.y-loc.y));
        }
      else
        acc = new PVector(0,0);
   }
  
  void display(){
    pushMatrix();
    translate(loc.x, loc.y);
    imageMode(CENTER); 
    image(img, 0, 0);
    popMatrix();
  }
}
