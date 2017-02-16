void setup(){
  background(255);
  size(1000,1000);
  //translate(250,-500);
  line(0,500,1000,500);
  strokeWeight(5);
//波源5個
  int thita = 40;
  float point_width = 100.0;
  int point_number = 5;
  int kiroku = point_number;
  int time = 1;
  
  noFill();
  int start_x_point = 200;
  fill(255,0,0,80);
 for(int i2 = start_x_point; i2 <= start_x_point+point_width*kiroku; 
  i2+=point_width){
ellipse(i2,500,point_width*sin(radians(thita))*2*point_number*time,point_width*sin(radians(thita))*2*point_number*time);
  
point_number--;
  }
fill(255);
rect(0,500,1000,500);
point_number = kiroku;
stroke(0,255,0,100);
fill(0,255,0,100);
strokeWeight(15);
   for(int i = start_x_point; i < start_x_point+point_width*kiroku; 
  i+=point_width){
  point(i,500);
  point(i,500);
  point(i,500);
  point(i,500);
  }
  
  strokeWeight(30);
  stroke(0);
  fill(0);
  textSize(30);
  text("angle =" + thita, 600,100);
  text("point_number = " + kiroku, 600,160);
}
