class EvilBullet extends GameObject{
 EvilBullet(PVector loc, PVector vel){
   super(loc, vel, 5);
   health = 1;
 } 
 
  void run()
   {
     if(checkCollision(this, ship))
     {
       this.health--;
     }     
     vel.limit(3);
     update();
     display();
     checkEdges();
   }
  
  void display(){
    stroke(0,0,255);
    fill(color(0, 0, 255));
    if(loc != null){
      ellipse(loc.x, loc.y, 20, 20);
      left=loc.x-10;
      right=loc.x+10;
      bottom=loc.y+10;
      top=loc.y-10;
    }
  }
  void checkEdges(){
     if(right < 0||left > width||bottom < 0||top > height) health=0;
   }
}
