//上から描写していく
//先に円から描写して,下を四角で囲む

void setup(){
  size(1100,800);
  background(255);

noFill();
stroke(255,0,0);
strokeWeight(3);
  for(int i = 0; i < 5; i++){
    ellipse(550,650,i*100,i*100);
  }

noStroke();
fill(255);
rect(0,650,1100,800);



  
  
 fill(0); 
rect(0,650,535,60);
rect(565,650,1100,60);


  strokeWeight(6);
  stroke(255,0,0);
  point(550,650);









}




void yokomigi(int x,int y){
  line(x,y,x-20,y+10);
  line(x,y,x-20,y-10);
}
void yokohidari(int x,int y){
  line(x,y,x+20,y+10);
  line(x,y,x+20,y-10);
}

void tatesita(int x,int y){
  line(x,y,x-10,y-20);
  line(x,y,x+10,y-20);
}

void tateue(int x,int y){
  line(x,y,x-10,y+20);
  line(x,y,x+10,y+20);
}


