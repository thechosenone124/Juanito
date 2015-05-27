class Juanito extends GameObject{
 Juanito(PImage img){
   super(img, 1);
   health = 0;
 } 
 
  
  void update()
   {
      for (int i = 0; i < bullets.size(); i++)
     if(checkCollision(this, bullets.get(i)))
       {
       this.health--;
       }
     if(loc!=null)
     {
     if(health<=0)
     {
       juanitoTime=false;
       score+=20;
     }
      left=loc.x-(img.width/2);
      top=loc.y-(img.height/2);
      right=loc.x+(img.width/2);
      bottom=loc.y+(img.height/2);
     }
   }
  
  void display(){
    if(loc!=null)
     {
    pushMatrix();
    translate(loc.x, loc.y);
    imageMode(CENTER); 
    image(img, 0, 0);
    popMatrix();
     }
  }
}
