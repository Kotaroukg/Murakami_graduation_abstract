//上から描写していく
//先に円から描写して,下を四角で囲む

void setup(){
  size(1000,800);
  background(255);
  strokeWeight(2);









  
  stroke(0,0,255);
noFill();
  for(int ia = 0; ia < 1001; ia+=100){
    ellipse(ia,400,200,200);
  }
  fill(255);
  noStroke();
  rect(0,350,width,height);

//円2
    stroke(0,0,255);
noFill();
  for(int ib = 0; ib < 1001; ib+=100){
    ellipse(ib,500,200,200);
  }
  fill(255);
  noStroke();
  rect(0,450,width,height);


//円3
  stroke(0,0,255);
noFill();
  for(int ic = 0; ic < 1001; ic+=100){
    ellipse(ic,600,200,200);
  }
  fill(255);
  noStroke();
  rect(0,550,width,height);

















  stroke(255,0,0);
  line(0,300,width,300);
  line(0,400,width,400);
  line(0,500,width,500);
  line(0,600,width,600);

  strokeWeight(10);
    for(int i = 100; i < 901; i+=100){
    point(i,600);
  }

stroke(0,0,255);
strokeWeight(5);
line(500,620,500,750);
tateue(500,620);

stroke(0);
for(int j = 200; j < 1000; j+= 200){
  line(j,150,j,280);
  tateue(j,150);
  

}


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


