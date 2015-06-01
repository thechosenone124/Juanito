
import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context
ArrayList<GameObject> go = new ArrayList<GameObject>();
ArrayList<GameObject> bullets = new ArrayList<GameObject>();
ArrayList<GameObject> evilbullets = new ArrayList<GameObject>();
ArrayList<GameObject> powerups = new ArrayList<GameObject>();
Ship ship;
Boss boss;
int x = 0;
int gameState = 0;
PImage defaultShip;
PImage firingShip;
PImage juan;
PImage juanito;
PImage bossImage;
PImage firstProtector;
PImage secondProtector;
PImage defeat;
PImage tame;
PImage background;
PImage power;
boolean[] keys;
boolean juanitoTime = false;
Juanito juajua;
BossProtector one; 
BossProtector two; 
BossProtector three; 
BossProtector four; 
float c;
int score = 0;
boolean musicPlaying;
boolean uncensored = false;
int seconds = 1;
int bossWackiness=5;
Background back1;
Background back2;
int timeBetweenJuan=60;
void setup()
{
  size(1100, 800);
  background(0, 0, 0);
  musicPlaying = false;
  
  defaultShip=loadImage("spaceship.png");
  firingShip=loadImage("SHOOP_DA_WHOOP!!!.png");
  juan=loadImage("jmonster.png");
  juanito=loadImage("monsterj.png");
  bossImage=loadImage("Boss.png");
  firstProtector=loadImage("TheHead.png");
  secondProtector=loadImage("HeadThe.png");
  defeat=loadImage("Game Over.png");
  tame=loadImage("Tame Game Over.png");
  background=loadImage("Background.png");
  power=loadImage("healme.png");
  
  ship = new Ship(defaultShip, new PVector(width/2, height/6*5));
  boss = new Boss(bossImage, new PVector(width/2, height/2));
  one = new BossProtector(firstProtector, new PVector(200,0), .04);
  two = new BossProtector(secondProtector, new PVector(0,200), .04);
  three = new BossProtector(firstProtector, new PVector(-200,0), .04);
  four = new BossProtector(secondProtector, new PVector(0,-200), .04);
  keys = new boolean[5];
  juajua = new Juanito(juanito);
  minim = new Minim(this);
  go = new ArrayList<GameObject>();
  bullets = new ArrayList<GameObject>();
  evilbullets = new ArrayList<GameObject>();
  
  if(gameState==2)
  {
   juan = loadImage("victory.png"); 
  }
  if(gameState==0||gameState==2)
  {
  for (int i = 0; i<width/juan.width-6; i++)
  {
    go.add(new Juan(juan, new PVector(juan.width/2,(juan.height*i)+juan.height*1.5)));
  }
  for (int i = 0; i<width/juan.width-6; i++)
  {
    go.add(new Juan(juan, new PVector(width-juan.width/2,(juan.height*i)+juan.height*1.5)));
  }
  for (int i = 0; i<height/juan.height+4; i++)
  {
    go.add(new Juan(juan, new PVector((juan.width*i)+juan.height*1.5,juan.height/2)));
  }
  for (int i = 0; i<height/juan.height+4; i++)
  {
    go.add(new Juan(juan, new PVector((juan.width*i)+juan.height*1.5,height-juan.height/2)));
  }
    go.add(new Juan(juanito, new PVector(juanito.width/2,juanito.height/2))); 
    go.add(new Juan(juanito, new PVector(juanito.width/2,height-juanito.height/2))); 
    go.add(new Juan(juanito, new PVector(width-juanito.width/2,juanito.height/2))); 
    go.add(new Juan(juanito, new PVector(width-juanito.width/2,height-juanito.height/2))); 
    ship = new Ship(defaultShip, new PVector(width/2, height/2));
  }
}

void draw()
{
   switch(gameState) {
     case 0:
       menu();
       break;
     case 1: 
       runGame();
       break;
     case 2:
       gameOver();
       break;
}
}

void keyPressed()
{
  if(keyCode==UP)
    keys[0]=true;
  if(keyCode==DOWN)
    keys[1]=true;
  if(keyCode==LEFT)
    keys[2]=true;
  if(keyCode==RIGHT)
    keys[3]=true;
  if(key==' ')
    keys[4]=true;
  if(key=='e')
     uncensored=true;
}
void keyReleased()
{
  if(keyCode==UP)
    keys[0]=false;
  if(keyCode==DOWN)
    keys[1]=false;
  if(keyCode==LEFT)
    keys[2]=false;
  if(keyCode==RIGHT)
    keys[3]=false;
  if(key==' ')
    keys[4]=false;
}
void menu()
{
  background(0, 0, 0);
  textSize(32);
  textAlign(CENTER,BOTTOM);
  text("DECLARE WAR", width/2, height/4); 
  textAlign(CENTER,TOP);
  text("TO PLAY", width/2, height/4+32); 
  for(int i = 0; i < go.size(); i++)
  {
    if(go.get(i).loc.x<juan.width/2)
      go.get(i).loc.x=30;
    if(go.get(i).loc.x==juan.width/2 && go.get(i).loc.y>juan.height)
      go.get(i).vel = new PVector(0,-1);
    else if(go.get(i).loc.y==juan.height/2 && go.get(i).loc.x<width-juan.width/2)
      go.get(i).vel = new PVector(1,0);
    else if(go.get(i).loc.x==width-juan.width/2 && go.get(i).loc.y<height-juan.height/2)
      go.get(i).vel = new PVector(0,1);
    else if(go.get(i).loc.y==height-juan.height/2 && go.get(i).loc.x>juan.width/2)
      go.get(i).vel = new PVector(-1,0);
    go.get(i).run();
  }
  if(bullets.size()>0)
  {
    for(int i = 0; i < bullets.size(); i++)
    {
      bullets.get(i).run(); 
      for(GameObject j: go)
      {
        if(checkCollision(bullets.get(i),j))
        {
          gameState=1;
          back1=new Background(background, new PVector(width/2, 0), new PVector(0, 5));
          back2=new Background(background, new PVector(width/2, height), new PVector(0, 5));
          setup();
          break;
        }
      }
    }
  }
  textAlign(CENTER,BOTTOM);
  text("YOUR SCORE", width/2, height/2);
  ship.run();
  if(keys[4])
    ship.fire();
  
}
void runGame()
{
  //background stuff
    if(juanitoTime)
  {
    colorMode(HSB);
    if (c >= 255)  c=0;  else  c++;
    background(c, 255, 255);
  }
  else
  {
    background(0, 0, 0);
    colorMode(RGB);
    back1.run();
    back2.run();
  }
  //text
  text(score+"", width/2, 50);
  textAlign(CENTER,BOTTOM);
  text(boss.health, width/2, height/4+32);  
  fill(200-boss.health/5, boss.health/5*2-20,0);
  rect(boss.loc.x-boss.health/8, boss.loc.y-boss.img.width+50, boss.health/4, 10);
  
  fill(200-ship.health*5, ship.health*5*2-20,0);
  rect(ship.loc.x-ship.health, ship.loc.y-ship.img.width-10, ship.health, 8);
  
  
  //BossProtectors
   one.run();
   two.run();
   three.run();
   four.run();
  ship.run();
  wackyBoss(10);
  
  //running the juans
  for(int i = 0; i < go.size(); i++)
  {
    go.get(i).run();
    if(go.get(i).vel.mag()<=0)
      {
      go.remove(i);
      score++;
      if (timeBetweenJuan > 15)
      {
      int chance = (int)random(5);
      if (chance == 3)
      timeBetweenJuan--;
      }
      if(juanitoTime)
      score++;
      }
  }
  //running the powerups
  for(int i = 0; i < powerups.size(); i++)
  {
    powerups.get(i).run();
    if(powerups.get(i).health<=0)
      {
      powerups.remove(i);
      }
  }
  
  //running the bullets
    if(bullets.size()>0)
    {
      for(int i = 0; i < bullets.size(); i++)
      {
        bullets.get(i).run();
        if(bullets.get(i).health<=0)
         bullets.remove(i);
      }
    }
  boss.run();
  //running the boss bullets
  if(evilbullets.size()>0)
  {
    for(int i = 0; i < evilbullets.size(); i++)
    {
      evilbullets.get(i).run(); 
      if(evilbullets.get(i).health<=0)
        evilbullets.remove(i);
    }
  }
  
    
    
    //juan spawner
    if(x>timeBetweenJuan)
    {
    createGameObject("juan", 1);
    x=0;
    }
    x++;
    
    //juanitotime trigger
    if(go.size()>20 && !juanitoTime)
      {
      juajua.loc = new PVector(width-ship.loc.x,height-ship.loc.y);
      juajua.health = 20;
      juanitoTime = true;
      }
    if(juanitoTime)
     {
       juajua.run();
       ship.controlFactor = 100;
       ship.velLimit = 10;
       text("IT'S JUANITO TIME!!!", 400, height/4); 
     }
     if(juanitoTime&&!musicPlaying)
     {
       player = minim.loadFile("Nyan Cat.mp3");
       player.loop();  
       musicPlaying=true;
     }
     if(!juanitoTime&&musicPlaying)
     {
       player.close();
       musicPlaying=false;
     }
      
      //controls
      if(keys[0])
      {
        ship.velocity(UP);
        ship.breaksWorking=true;
      }
      if(keys[1])
      {
        ship.velocity(DOWN);
        ship.breaksWorking=true;
      }
      if(keys[2])
      {
        ship.velocity(LEFT);
        ship.breaksWorking=true;
      }
      if(keys[3])
      {
        ship.velocity(RIGHT);
        ship.breaksWorking=true; 
      }
      if(keys[4])
        ship.fire();
      if(!(keys[0]||keys[1]||keys[2]||keys[3])&&ship.breaksWorking)
        ship.vel=new PVector(0,0);
      if(!keys[4])
        {
        ship.img=defaultShip;
        } 
        
      //gameover
      if(ship.health<=0)
      {
        if(musicPlaying)
        {
        player.close();
        minim.stop();
        musicPlaying=false;
        }
        gameState=2;
      } 
}

void gameOver()
{
  if(ship.health<=0)
  {
       if(uncensored)
       { 
         if(!musicPlaying)
         {
           player = minim.loadFile("You Lose.mp3");
           player.play(); 
           musicPlaying=true;
         }
         image(defeat,width/2,height/2);
       }
       else
       image(tame,width/2,height/2);
  }
  else
  {
    colorMode(HSB);
    if (c >= 255)  c=0;  else  c++;
    background(c, 255, 255);
    textSize(32);
    textAlign(CENTER,BOTTOM);
    text("YOUR SCORE", width/2, height/2); 
    textAlign(CENTER,TOP);
    text(score+"", width/2, height/2); 
    juanitoTime=true;
    
    for(int i = 0; i < go.size(); i++)
    {
      if(go.get(i).loc.x<juan.width/2)
        go.get(i).loc.x=30;
      if(go.get(i).loc.x==juan.width/2 && go.get(i).loc.y>juan.height)
        go.get(i).vel = new PVector(0,-1);
      else if(go.get(i).loc.y==juan.height/2 && go.get(i).loc.x<width-juan.width/2)
        go.get(i).vel = new PVector(1,0);
      else if(go.get(i).loc.x==width-juan.width/2 && go.get(i).loc.y<height-juan.height/2)
        go.get(i).vel = new PVector(0,1);
      else if(go.get(i).loc.y==height-juan.height/2 && go.get(i).loc.x>juan.width/2)
        go.get(i).vel = new PVector(-1,0);
      go.get(i).run();
    }
  }
}
public void wackyBoss(int time)
{
  seconds++;
  if(seconds%(30*time)==0)
  {
    boss.vel=new PVector(random(-bossWackiness,bossWackiness),random(-bossWackiness,bossWackiness));
    bossWackiness++;
    one.distanceFromCenterChange=2;
    three.distanceFromCenterChange=2;
    print(boss.vel);
    powerups.add(new PowerUp(power, new PVector(random(width), random(height)), new PVector(0, 0)));
  }
}

void createGameObject(String type, int n)
{
   if(type.equals("juan"))
    {
        float x = random(width);
        float y = random(height);
        while((x>ship.left-50&&x<ship.right-50&&y>ship.top-50&&y<ship.bottom+50)||(x>boss.left-35&&x<boss.right-35&&y>boss.top-35&&y<boss.bottom+35))
        {
          x = random(width);
          y = random(height);
        }
        go.add( new Juan(juan, new PVector(x, y), new PVector(random(-n,n), random(-n,n))));
    }

  
  }
   boolean checkCollision(GameObject a, GameObject b)
   {
     
       if((a.left<=b.left&&a.right>b.left)||(b.left<a.left&&b.right>=a.left))  
        {
         if((a.top<=b.top && a.bottom>b.top)||(b.top<a.top&&b.bottom>=a.top))  
            {           
            return true;
            }
        }
           return false;
   }


