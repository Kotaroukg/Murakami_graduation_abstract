import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class finished_wave_diffraction extends PApplet {

//\u56de\u6298\u73fe\u8c61
Elementary_waves[] elementary_waves_array;
Parallel_waves p1;

boolean keyReleased = false;
boolean check_mode = false;
boolean check = false;
boolean slider_dragged = false;
boolean slider_dragged2 = false;
boolean collision_flag  = false;
boolean draw_start = false;
boolean change_mode_flag = false;

int number_wave_point = 0;
int size = 400;
int point_regulation = 4;
int s_p = size/point_regulation;
int maximum_waves_number = 13;
float below_size = size/4*3; 
float[][] point = new float[s_p][s_p];
float[][] point_distance = new float[s_p*maximum_waves_number][s_p];
float slit_width = 20.0f; //\u70b9\u6e90\u306f\u5e38\u306b10\u9593\u9694
float lambda = 30.0f;
float wave_v;

public void setup(){  
  colorMode(HSB, 360,100,100,100);
  size(size+250,size);
  frameRate(20);
}

public void draw(){  
  background(255);
  if(draw_start == true){
    strokeWeight(point_regulation);
    draw_wave();  
  }else{
    setting();
    if(change_mode_flag==true){
      create();
      wave_v = elementary_waves_array[0].lambda / elementary_waves_array[0].period; 
      draw_start = true;
    }
  }
}

public void setting(){
  slider2(size+50,20,size-50,30,20.0f,120.0f,6);
  strokeWeight(5);
  number_wave_point = (int)slit_width/10+1;//\u70b9\u6e90\u306e\u6570
  stroke(300,100,100);
  rect(0,below_size,size/2-slit_width/2,10);
  rect(size/2+slit_width/2,below_size,size/2-slit_width/2,10);
  stroke(0);
  for(int i = 0; i < number_wave_point; i++){
    point(size/2-slit_width/2+10*i,below_size);
  }
}

public void create(){
  make_elementary_waves();
  p1 = new Parallel_waves(size,elementary_waves_array[0].lambda, elementary_waves_array[0].period);
  for(int i = 0; i < number_wave_point; i++){
    elementary_waves_array[i].created_time = millis();
  }
  p1.created_time = millis();
}

public void make_elementary_waves(){
  elementary_waves_array = new Elementary_waves[number_wave_point];
  for(int i = 0; i < elementary_waves_array.length; i++){
    Elementary_waves elementary_waves = new Elementary_waves(size/2-slit_width/2+10*i,below_size,lambda,3.0f);
    elementary_waves_array[i] = elementary_waves;
    int s_p_n = s_p * i;
    for(int j = 0; j < s_p; j++){
      for(int k = 0; k < s_p; k++){
        point_distance[j+s_p_n][k] = distance_calculate(elementary_waves_array[i].center_x, //\u3053\u3053\u306fs
        elementary_waves_array[i].center_y, j*point_regulation, k*point_regulation);
      }
    }
  }
}

public float distance_calculate(float center_x, float center_y, float x, float y){
  float a = dist(center_x,center_y,x,y);
  return a;
}

public void keyReleased() {
  keyReleased = true;
  change_mode_flag = true;
}

public void keyPressed(){
  if((keyPressed == true) && keyReleased == true &&((key == 's') ||  (key == 'S'))){
    keyReleased = false;
  }
  if((keyPressed == true) && keyReleased == true && ((key == 'b') ||  (key == 'B'))){
    keyReleased = false;
    draw_start = false;
    collision_flag = false;
  }
}

public void draw_wave(){
  int number_wave_point2 = number_wave_point*2;
  for(int i = 0; i < s_p; i++){
    for(int j = 0; j < s_p; j++){
      for(int k = 0; k < number_wave_point; k++){
        float range;
        if(collision_flag == true){
          range = elementary_waves_array[k].range_to_calculate();//\u73fe\u5728\u306e\u6ce2\u306e\u6700\u5148\u7aef\u306e\u8ddd\u96e2\u3092\u8a08\u7b97
        }else{
          range = 0;
        }
        if(point_distance[i+s_p*k][j] < range){ //\u30af\u30e9\u30b9\u914d\u5217\uff0c\u5404\u70b9\u3068\u6ce2\u3054\u3068\u306e\u8ddd\u96e2\u3068\u7bc4\u56f2\u3092\u6bd4\u8f03
          float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j],
            elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
          if(j*point_regulation < below_size)point[i][j] += y; //\u753b\u9762\u4e0a\u90e8\u306a\u3089\u5024\u3092\u8db3\u3059.
        }else{

        }
      }//k\u306f\u3053\u3053\u307e\u3067
      point[i][j] += number_wave_point;
      p1.draw_parallel_waves(i,j);
      if(point[i][j] != 0.0f){
        stroke( (number_wave_point2- point[i][j])*(230/number_wave_point2),100,100);
        point(i*point_regulation,j*point_regulation);
        point[i][j] = 0;
      }else if(j*point_regulation > below_size && point[i][j] != 0.0f){
        stroke((number_wave_point2- point[i][j])*(230/(number_wave_point*2)),100,100);
        point(i*point_regulation,j*point_regulation);
        point[i][j] = 0;
      }else{
        point[i][j] = number_wave_point;
        if(j == 40) println(point[i][j]);
        point(i*point_regulation,j*point_regulation);
      }
    }
  }

  stroke(300,100,100);
  rect(0,below_size,size/2-slit_width/2,10);
  rect(size/2+slit_width/2,below_size,size/2-slit_width/2,10);

  strokeWeight(6);

  for(int a = 0; a < number_wave_point; a++){
    point(elementary_waves_array[a].center_x, elementary_waves_array[a].center_y);
  }
  slider(size+20,20,size-50,30,10.0f,200.0f,40);
}


public void slider(int position_x, int position_y, int slider_height, int slider_width, float min, float max, int number_tickmarks){

  int num_separator = (int)map(elementary_waves_array[0].lambda, min, max, 0, number_tickmarks-1); //temper=\u30b0\u30ed\u30fc\u30d0\u30eb min~max\u306e\u7bc4\u56f2\u3092\uff10\u304b\u3089number_tickmarks\u306b\u5909\u63db
  float cordinate_y = position_y + slider_height - ((float)slider_height / (number_tickmarks-1))*num_separator;
  fill(255);
  noStroke();                                                        //text\u6d88\u3059\u305f\u3081
  rect(position_x, position_y + slider_height, slider_width+50, 30); 
  stroke(1);
  rect(position_x, position_y, slider_width, slider_height);
  fill(0);
  rect(position_x, cordinate_y, slider_width, position_y + slider_height - cordinate_y);
  text( "lambda="+nf(elementary_waves_array[0].lambda,1,1), position_x, position_y + slider_height + 20);
  if(mousePressed==false) slider_dragged=false;
  if(mouseX >= position_x & mouseX <= position_x + slider_width & mouseY<=cordinate_y+10 & mouseY>= cordinate_y-10){
    if(mousePressed){
      slider_dragged= true;
    }
  }
  if(slider_dragged){
     num_separator+= (int)((cordinate_y - mouseY)/((float)slider_height / (number_tickmarks-1))); // int\u306b\u3057\u306a\u3044\u3068js\u3067\u6574\u6570\u306b\u306a\u3089\u306a\u3044
     num_separator = constrain(num_separator, 0, number_tickmarks-1);
     for(int i = 0; i < number_wave_point; i++){
       elementary_waves_array[i].lambda=map(num_separator, 0, number_tickmarks-1, min, max);
     }
     for(int i = 0; i < number_wave_point; i++){
       elementary_waves_array[i].period = elementary_waves_array[i].lambda / wave_v;
     }
   }
 }

 public void slider2(int position_x, int position_y, int slider_height, int slider_width, float min, float max, int number_tickmarks){

  int num_separator = (int)map(slit_width, min, max, 0, number_tickmarks-1); //temper=\u30b0\u30ed\u30fc\u30d0\u30eb min~max\u306e\u7bc4\u56f2\u3092\uff10\u304b\u3089number_tickmarks\u306b\u5909\u63db
  float cordinate_y = position_y + slider_height - ((float)slider_height / (number_tickmarks-1))*num_separator;
  fill(255);
  noStroke();                                                        //text\u6d88\u3059\u305f\u3081
  rect(position_x, position_y + slider_height, slider_width+50, 30); 
  stroke(1);
  rect(position_x, position_y, slider_width, slider_height);
  fill(0);
  rect(position_x, cordinate_y, slider_width, position_y + slider_height - cordinate_y);
  text( "slit_width="+nf(slit_width,1,0), position_x, position_y + slider_height + 20);
  if(mousePressed==false) slider_dragged2=false;
  if(mouseX >= position_x & mouseX <= position_x + slider_width & mouseY<=cordinate_y+10 & mouseY>= cordinate_y-10){
    if(mousePressed){
      slider_dragged2= true;
    }
  }
  if(slider_dragged2){
    num_separator+= (int)((cordinate_y - mouseY)/((float)slider_height / (number_tickmarks-1))); // int\u306b\u3057\u306a\u3044\u3068js\u3067\u6574\u6570\u306b\u306a\u3089\u306a\u3044
    num_separator = constrain(num_separator, 0, number_tickmarks-1);
    slit_width=round(map(num_separator, 0, number_tickmarks-1, min, max));
  }
}

class Parallel_waves{
  float start_y;
  float lambda;
  float period;
  float created_time;

  Parallel_waves(float _start_y,float _lambda, float _period){
    start_y = _start_y;
    lambda = _lambda;
    period = _period;
    created_time = millis(); 
  }

  public float now_displacement_y(float distance, float lambda, float period, float time_adjustment){
    float time_phase_adjustment;
    time_phase_adjustment = ((millis()-time_adjustment)/1000.0f)*(360.0f / period); //\u3053\u3053\u3067\u6642\u9593\u5dee\u3092\u8a08\u7b97\u3057\u3066\u3044\u308b\u2192\u5909\u6570\u3067\u958b\u59cb\u6642\u523b\u3092\u8a18\u9332\u2192\u3053\u308c\u3092\u4ee3\u5165\u3059\u308c\u3070\u3044\u3044\uff0e
    float distance_lambda_adjustment = (distance%lambda)/lambda*(360.0f);
    float y = sin(radians(time_phase_adjustment - distance_lambda_adjustment));
    return y;
  }

  public float range_to_calculate(){
    float a = (millis()-created_time)*lambda/period/1000.0f;
    return a;
  }

  public void draw_parallel_waves(int i,int j){
    float range = p1.range_to_calculate();
    if(range > size - below_size && collision_flag == false){
      collision_flag = true;
      for(int k = 0; k < number_wave_point; k++){
        elementary_waves_array[k].created_time = millis();
      }
    }
    if(j*point_regulation > below_size){
      if(size - j*point_regulation < range){ //\u30af\u30e9\u30b9\u914d\u5217\uff0c\u5404\u70b9\u3068\u6ce2\u3054\u3068\u306e\u8ddd\u96e2\u3068\u7bc4\u56f2\u3092\u6bd4\u8f03
        float y = p1.now_displacement_y(p1.start_y-(j+1)*point_regulation, elementary_waves_array[0].lambda, elementary_waves_array[0].period, p1.created_time);
        point[i][j] += y*number_wave_point;
      }
    }else{

    }
    point(i*point_regulation,j*point_regulation);
  }
}

class Elementary_waves{
  float center_x;
  float center_y;
  float lambda;
  float period;
  float created_time;
  float range_to_calculate;
  boolean draw_flag;

  Elementary_waves(float _center_x, float _center_y, float _lambda, float _period){
    center_x = _center_x;
    center_y = _center_y;
    lambda = _lambda;
    period = _period;
    created_time = 0;
    draw_flag = false;
  }

  public float now_displacement_y(float distance, float lambda, float period, float time_adjustment){
    float time_phase_adjustment;
    time_phase_adjustment = ((millis()-time_adjustment)/1000.0f)*(360.0f / period); //\u3053\u3053\u3067\u6642\u9593\u5dee\u3092\u8a08\u7b97\u3057\u3066\u3044\u308b\u2192\u5909\u6570\u3067\u958b\u59cb\u6642\u523b\u3092\u8a18\u9332\u2192\u3053\u308c\u3092\u4ee3\u5165\u3059\u308c\u3070\u3044\u3044\uff0e
    float distance_lambda_adjustment = (distance%lambda)/lambda*(360.0f);
    float y = sin(radians(time_phase_adjustment - distance_lambda_adjustment));
    return y;
  }

  public float range_to_calculate(){
    float distance = (millis()-created_time)*lambda/period/1000.0f;
    return distance;
  }
}



  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "finished_wave_diffraction" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
