class Bullet extends GameObject{
  int velLim = 7;
 Bullet(PVector loc, PVector vel, int lim){
   super(loc, vel, 5);
   velLim=lim;
   health = 1;
 } 
 
  void run()
   {
     for (int i = 0; i < go.size(); i++)
     if(checkCollision(this, go.get(i)))
       {
       this.health--;
       break;
       }
     if(checkCollision(this, juajua)||checkCollision(this, one)||checkCollision(this, two)||checkCollision(this, three)||checkCollision(this, four)||(gameState==1&&checkCollision(this,boss)))
       {
       this.health--;
       }
     
     
     update();
     display();
     checkEdges();
   }
  
  void display(){
    stroke(255,255,255);
    fill(color(255, 255, 255));
    if(loc != null){
      ellipse(loc.x, loc.y, 10, 10);
      left=loc.x-10;
      right=loc.x+10;
      bottom=loc.y+10;
      top=loc.y-10;
    }
  }
  void checkEdges(){
     if(right < 0||left > width||bottom < 0||top > height) health=0;
   }
   void update()
   {
    vel.limit(velLim);
    loc.add(vel);
   }
}
