int w = 30, h = 30, bs = 20;
int dir = 2;
int dx[] = {0,0,1,-1};
int dy[] = {1,-1,0,0};
int foodx = (int)random(0,w), foody = (int)random(0,h);
boolean gameover = false;
int score = 0;

ArrayList <Integer> x = new ArrayList<Integer>();
ArrayList <Integer> y = new ArrayList<Integer>();

void setup(){
  size(600,600);
  x.add(5);
  x.add(5);
  x.add(5);
  y.add(5);
  y.add(5);
  y.add(5);
}

void draw(){
  background(200);

  // Drawing grid
  for (int i = 0; i < w; i++){
    line(i * bs, 0, i * bs, height);
  }
  for (int i = 0; i < h; i++){
    line(0, i * bs, width, i * bs);
  }
  
  // Drawing "snake"
  for (int i = 0; i < x.size(); i++){
    fill(0);
    rect(x.get(i) * bs, y.get(i) * bs, bs, bs);
  }
  
  // While the game is going on
  if (!gameover){
    fill(255, 0 , 0);
    rect(foodx * bs, foody * bs, bs, bs);
    
    if (frameCount % 5 == 0){
      x.add(0, x.get(0) + dx[dir]);
      y.add(0, y.get(0) + dy[dir]);
      
      if (x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h){
        gameover = true;
      }
      
      for (int i = 1; i < x.size(); i++){
        if (x.get(0) == x.get(i) && y.get(0) == y.get(i) ) gameover = true;
      }
      
      // Eating food
      if (x.get(0) == foodx && y.get(0) == foody){
        foodx = (int)random(0,w);
        foody = (int)random(0,h);
        score++;
      }
      else{
        x.remove(x.size() - 1);
        y.remove(y.size() - 1);
      }
    
    }  
  }
  else{ // If player lost
    gameEnd(); 
  }
}

// Player movement
void keyPressed(){
  int newdir = keyCode == DOWN ? 0 : (keyCode == UP ? 1 : (keyCode == RIGHT ? 2 : (keyCode == LEFT ? 3 : -1)));
  if (newdir != -1 && (x.size() <= 1 || !(x.get(1) == x.get(0) + dx[newdir] && y.get(1) == y.get(0) + dy[newdir])))
    dir = newdir;
}

void gameEnd(){
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("GAME OVER\nFinal Score : " + score + "\nPress SPACE To Restart", width / 2, height / 2);
    if (keyPressed && key == ' '){
      x.clear();
      y.clear();
      x.add(5);
      x.add(5);
      x.add(5);
      y.add(5);
      y.add(5);
      y.add(5);
      foodx = 12;
      foody = 10;
      score = 0;
      gameover = false;
    }
}