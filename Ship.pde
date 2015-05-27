

class Ship extends GameObject{
  float theta=vel.heading();
  int velLimit = 4;
  int controlFactor = 1;
  boolean breaksWorking=true;
  int knockback=3;
  int bulletVel = 7;
  Ship(PImage s, PVector loc){
    super(s, loc, 5);
    health=20;
    acc = new PVector(0,0);
  }
  void update()
   {
    vel.limit(7);
    loc.add(vel);
    vel.add(acc);
    if(img!=null)
    {
      left=loc.x-(img.width/2);
      top=loc.y-(img.height/2);
      right=loc.x+(img.width/2);
      bottom=loc.y+(img.height/2);
    }
    for(GameObject j:go)
    {
      if (checkCollision(this,j))
      {
        health--;
        if(bottom<j.loc.y)
        vel.y=-10;
        if(top>j.loc.y)
        vel.y=10;
        if(right<j.loc.x)
        vel.x=-10;
        if(left>j.loc.x)
        vel.x=10;
      }
    }
    if (checkCollision(this,boss))
      {
        if(bottom<boss.loc.y)
          vel.y=-knockback;
        if(top>boss.loc.y)
          vel.y=knockback;
        if(right<boss.loc.x)
          vel.x=-knockback;
        if(left>boss.loc.x)
          vel.x=knockback;
        ship.breaksWorking=false;
      }
      if (checkCollision(this,one))
      {
        if(bottom<one.loc.y)
          vel.y=-knockback;
        if(top>one.loc.y)
          vel.y=knockback;
        if(right<one.loc.x)
          vel.x=-knockback;
        if(left>one.loc.x)
          vel.x=knockback;
        ship.breaksWorking=false;
      }
      if (checkCollision(this,two))
      {
        if(bottom<two.loc.y)
          vel.y=-knockback;
        if(top>two.loc.y)
          vel.y=knockback;
        if(right<two.loc.x)
          vel.x=-knockback;
        if(left>two.loc.x)
          vel.x=knockback;
        ship.breaksWorking=false;
      }
      if (checkCollision(this,three))
      {
        if(bottom<three.loc.y)
          vel.y=-knockback;
        if(top>three.loc.y)
          vel.y=knockback;
        if(right<three.loc.x)
          vel.x=-knockback;
        if(left>three.loc.x)
          vel.x=knockback;
        ship.breaksWorking=false;
      }
      if (checkCollision(this,four))
      {
        if(bottom<four.loc.y)
          vel.y=-knockback;
        if(top>four.loc.y)
          vel.y=knockback;
        if(right<four.loc.x)
          vel.x=-knockback;
        if(left>four.loc.x)
          vel.x=knockback;
        ship.breaksWorking=false;
      }
      for (int i = 0; i < evilbullets.size(); i++)
       if(checkCollision(this, evilbullets.get(i)))
       {
         int chance=int(random(4));
         if(chance==3)
         this.health--;
       } 

   }
  void display(){
    

    pushMatrix();
    translate(loc.x, loc.y);
    imageMode(CENTER); 
    rotate(theta);
    image(img, 0, 0);
    popMatrix();
  }
    
  void velocity(int direction)
   {
      if (direction == UP&&vel.y > -velLimit)
        vel.y += -controlFactor;
      if (direction == DOWN&&vel.y < velLimit)
        vel.y += controlFactor;
      if (direction == RIGHT&&vel.x < velLimit)
        vel.x += controlFactor;
      if (direction == LEFT&&vel.x > -velLimit)
        vel.x += -controlFactor;
      theta = vel.heading()+radians(45);
      theta +=  180/PI;
   }
   
   void fire()
   {
     //loc.x+cos(theta-radians(90))*50, loc.y+sin(theta-radians(90))*50 a position 50 units away from the front of the ship
     //bullet location: ship.loc, adjust bullet stream upwards in relation to ship, adjust bullet stream backwards in relation to ship 
     bullets.add(new Bullet(new PVector(ship.loc.x-(sin(theta-radians(90))*7)-cos(theta-radians(90))*5, ship.loc.y+cos(theta-radians(90))*-(sin(theta-radians(90))*5)), new PVector(cos(theta-radians(90))*(bulletVel), sin(theta-radians(90))*(bulletVel)), bulletVel));
     img=firingShip;
   }
   
   
   
}

