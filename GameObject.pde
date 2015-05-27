abstract class GameObject implements Comparable
{
  PVector loc;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  PImage img;
  int rank;
  double left;
  double top;
  double right;
  double bottom;
  int health;
  
  GameObject(PImage img, int r) {
    this.img = img;
    rank = r;
  }

  GameObject(PVector loc, int r) {
    this.loc = loc;
    rank = r;
  }

  GameObject(PVector loc, PVector vel, int r) {
    this.loc = loc;
    this.vel = vel;
    rank = r;
  }

  GameObject(PImage img, PVector loc, PVector vel, int r) {
    this.vel = vel;
    this.loc = loc;
    this.img = img;
    rank = r;
  }
  
  GameObject(PImage img, PVector loc, int r) {
    this.loc = loc;
    this.img = img;
    rank = r;
  }
  void run()
   {
     update();
     display();
     checkEdges();
   }
   
   void update()
   {
    vel.limit(7);
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
   }
   
   abstract void display();
   
   void checkEdges(){
     if(right < 0) loc.x = width;
     if(left > width) loc.x = 0;
     if(bottom < 0) loc.y = height;
     if(top > height) loc.y = 0;
   }
   int compareTo(Object a)
   {
      GameObject b = (GameObject) a;
      if(rank > b.rank)
         return 1;
      else if(rank == b.rank)
         return 0;
      else
         return -1; 
   }
  
}

