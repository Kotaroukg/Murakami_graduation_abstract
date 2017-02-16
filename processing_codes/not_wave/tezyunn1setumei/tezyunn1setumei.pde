void setup(){
  size(1180,900);
  scale(1.3);
  background(255);
  strokeWeight(3);
  //380=center
  for(int i = 150; i < 600; i++){
  point(i,height/2-200 + 100*-sin(radians(i-200)));
}
line(0,height/2-200,800,height/2-200);
yokomigi(800,height/2-200);
line(380,50,380,height);

  for(int i = 150; i < 600; i++){
  point(i,height/2+50 + 100*-sin(radians(i-290)));
}
line(0,height/2+50,800,height/2+50);
yokomigi(800,height/2+50);

tateue(380,50);

for(int count = 50; count < 600; count += 30){
  line(470,count,470,count+15);
  
}


for(int count = 50; count < 600; count += 30){
  line(290,count,290,count+15);
  
}


stroke(0,0,255);
line(295,height/2-350,375,height/2-350);
yokomigi(375,height/2-350);
yokohidari(295,height/2-350);

line(385,height/2-350,465,height/2-350);
yokomigi(465,height/2-350);
yokohidari(385,height/2-350);


stroke(255,0,0);
strokeWeight(8);
line(650,200,750,200);
yokomigi(750,200);

line(650,450,750,450);
yokomigi(750,450);





stroke(255,0,0);
strokeWeight(15);
point(380,height/2-200);
point(380,height/2+50);


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

