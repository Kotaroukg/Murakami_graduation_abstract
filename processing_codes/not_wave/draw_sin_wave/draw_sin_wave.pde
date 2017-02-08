void setup(){
  size(920,600);
  background(255);
  strokeWeight(2);
for(int i = 100; i < 820; i++){
  point(i,height/2 + 100*-sin(radians(i-100)));
}
line(100,50,100,height-50);
line(50,height/2, width-50, height/2);

tateue(100,50);
yokomigi(width-50,height/2);

stroke(0,0,255);
line(190,height/2-100,190,height/2);
tateue(190,height/2-100);
tatesita(190,height/2);

line(370,height/2+100,370,height/2);
tatesita(370,height/2+100);
tateue(370,height/2);

line(195,height/2-110,545,height/2-110);
yokomigi(545,height/2-110);
yokohidari(195,height/2-110);


line(375,height/2+110,725,height/2+110);
yokomigi(725,height/2+110);
yokohidari(375,height/2+110);


stroke(255,0,0);
strokeWeight(15);
point(190,height/2-100);
point(550,height/2-100);
point(190,height/2);
point(370,height/2+100);
point(730,height/2+100);




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

