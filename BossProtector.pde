class BossProtector extends GameObject{
  float spinSpeed;
  PVector currentloc;
  float startAngle;
  float i = 1;
  boolean upOrDown=true;
  float distanceFromCenterChange = 5;
  int howManyRadiusChange = 0;
 BossProtector(PImage s, PVector init, float orbitalVelocity){
   super(s, init, 1);
   //The start location uses the center of th screen as 0,0, with conventional cartesian coordinates NOT PROCESSING DEFAULT
   spinSpeed = orbitalVelocity;
 } 
 
  
  void run()
   {
     display();
     left=boss.loc.x+currentloc.x-25;
      top=boss.loc.y-currentloc.y-25;
      right=boss.loc.x+currentloc.x+25;
      bottom=boss.loc.y-currentloc.y+25;
      if(upOrDown)
      {
        loc.x+=cos(startAngle)*distanceFromCenterChange;
        loc.y-=sin(startAngle)*distanceFromCenterChange;  
        howManyRadiusChange++;
        if(howManyRadiusChange>50)
        {
          upOrDown = false;
          howManyRadiusChange=0;
        }
      }
      else
      {
        loc.x-=cos(startAngle)*distanceFromCenterChange;
        loc.y+=sin(startAngle)*distanceFromCenterChange;  
        howManyRadiusChange++;
        if(howManyRadiusChange>50)
        {
          upOrDown = true;
          howManyRadiusChange=0;
        }
      }
      if(!juanitoTime)
      {
        for (int i = 0; i < bullets.size(); i++)
        {
        int chance=(int)(random(15));
      if(chance==3)
      {
         if(checkCollision(this, bullets.get(i))&&boss.health<300)
         {
           boss.health+=1;
         }
        if(checkCollision(this, ship)&&boss.health<299)
        {
          boss.health+=2;
        }
      }
        }
      }
   }
  
  void display(){
    pushMatrix();
    translate(boss.loc.x, boss.loc.y);
    imageMode(CENTER); 
    rotate((i*spinSpeed)%(2*PI));
    i++;
    if(loc.x>0)
    startAngle=atan(-loc.y/loc.x);
    else if(loc.x==0)
    {
       if (loc.y>0)
          startAngle=radians(90);
       else
          startAngle=radians(270); 
    }
    else
    startAngle=atan(-loc.y/loc.x)+radians(180);    
    image(img, loc.x, -loc.y, 50, 50);
    currentloc = new PVector(cos((i*spinSpeed)%(2*PI)-startAngle)*loc.mag(),sin((i*spinSpeed)%(2*PI)-startAngle)*-loc.mag());
    popMatrix();
  }
}
