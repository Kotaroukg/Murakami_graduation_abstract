void setup(){
  size(1200,600);
  background(255);
  strokeWeight(6);
for(int i = 40; i < 400; i++){
  point(i,height/2 + 100*-sin(radians(2*i-80)));
}


for(int i = 400; i < 1031; i++){
  point(i,height/2 + 100*-sin(radians(2*i-800)));
}



line(400,50,400,height-50);
line(30,height/2, width-50, height/2);

tateue(400,50);
yokomigi(width-50,height/2);



strokeWeight(3);
stroke(0,0,255);
line(400,150,1031,150);
yokomigi(1031,150);


line(400,450,580,450);
yokomigi(580,450);
yokohidari(400,450);

stroke(0);
strokeWeight(2);
for(int a = 50; a < 600; a += 50){
  line(580,a,580,a+25);
}
for(int a = 50; a < 600; a += 50){
  line(1031,a,1031,a+25);
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

