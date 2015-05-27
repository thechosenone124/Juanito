class Background extends GameObject
{
  Background(PImage img, PVector loc, PVector vel)
  {
    super(img, loc, vel, 1);
    health=10;
  }
  void checkEdges(){
     if(top > height) loc.y = -height/2;
   }
  void display(){
    pushMatrix();
    translate(loc.x, loc.y);
    imageMode(CENTER); 
    image(img, 0, 0);
    popMatrix();
  }
}
