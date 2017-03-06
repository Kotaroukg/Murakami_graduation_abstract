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

public class finished_wave_interference extends PApplet {


Elementary_waves[] elementary_waves_array;
Sliders[] sliders_array;
boolean keyReleased = false;
boolean check_mode = false;
boolean lambda_mode = false;
int number_wave_point = 0;
int size = 400; 
int point_regulation = 4;
int s_p = size/point_regulation;
int maximum_waves_number = 5;
float check_y = s_p/2;
float[][] point = new float[s_p][s_p];
float[][] point_distance = new float[s_p*maximum_waves_number][s_p];
float wave_v;

public void setup(){  
  colorMode(HSB, 360,100,100,100);
  size(size+(maximum_waves_number+1) * 95,size);
  frameRate(30);
  elementary_waves_array = new Elementary_waves[maximum_waves_number];
  sliders_array = new Sliders[maximum_waves_number+1];//check\u7528\u306e\u30b9\u30e9\u30a4\u30c0\u30fc\u3067\u30d7\u30e9\u30b9\uff11
  make_elementary_waves(); //\u5168\u3066\u306e\u70b9\u6e90\u306e\u30a4\u30f3\u30b9\u30bf\u30f3\u30b9\u3092\u4f5c\u6210
  make_sliders();
}

public void make_elementary_waves(){
  for(int i = 0; i < elementary_waves_array.length; i++){
    Elementary_waves elementary_waves = new Elementary_waves(width/2-50,size/2,30.0f,3.0f,2.0f,10.0f,20.0f,100.0f);//\u3068\u308a\u3042\u3048\u305a\u4f5c\u3063\u3066\u3044\u308b.
    elementary_waves_array[i] = elementary_waves;
  }
  wave_v = elementary_waves_array[0].lambda / elementary_waves_array[0].period; 
}

public void make_sliders(){
  Sliders sliders = new Sliders(size+20,20,size-50,30,0,s_p,40,0,"y = ");
    sliders_array[0] = sliders;
    sliders_array[0].draw_flag = true;
  for(int i = 1; i < sliders_array.length; i++){
    sliders = new Sliders(size+20+i*95,20,size-50,30,elementary_waves_array[i-1].period_min,elementary_waves_array[i-1].period_max,40,1, "period = ");
    sliders_array[i] = sliders;
  }
}


public void draw(){  
  background(255);
  strokeWeight(point_regulation);
  if(check_mode == true){
    draw_check();
  }else{
    draw_wave();
  }
}


public void keyPressed(){
  if((keyPressed == true) && keyReleased == true &&((key == 'c') ||  (key == 'C'))){
    keyReleased = false;
    check_mode = true;
  }
  if((keyPressed == true) && keyReleased == true && ((key == 'b') ||  (key == 'B'))){
    keyReleased = false;
    check_mode = false;
  }
  if((keyPressed == true) && keyReleased == true && ((key == 'l') ||  (key == 'L'))){
    for(int i = 0; i < number_wave_point; i++){
      sliders_array[i+1].min = elementary_waves_array[i].lambda_min;
      sliders_array[i+1].max = elementary_waves_array[i].lambda_max;
      sliders_array[i+1].variable_name = "lambda = ";
    }
    keyReleased = false;
    lambda_mode = true;
  }
  if((keyPressed == true && lambda_mode == true) && keyReleased == true && ((key == 'p') ||  (key == 'P'))){
    for(int i = 0; i < number_wave_point; i++){
      sliders_array[i+1].min = elementary_waves_array[i].period_min;
      sliders_array[i+1].max = elementary_waves_array[i].period_max;
      sliders_array[i+1].variable_name = "period = ";
    }
    keyReleased = false;
    lambda_mode = false;
  }
}


public void mousePressed() { //\u65b0\u3057\u3044\u7d20\u5143\u6ce2\u3092\u4e00\u3064\u751f\u6210\uff0e
  int s_p_n = s_p * number_wave_point;
  if(mouseX < size && lambda_mode == false){
    if(maximum_waves_number>number_wave_point){
      elementary_waves_array[number_wave_point].center_x = mouseX;
      elementary_waves_array[number_wave_point].center_y = mouseY;
      elementary_waves_array[number_wave_point].created_time = millis();
      sliders_array[number_wave_point+1].draw_flag = true;
      for(int i = 0; i < s_p; i++){
        for(int j = 0; j < s_p; j++){//s_p_n\u306f\uff10\u2192\uff11\u3078\u3068\u5897\u3048\u308b\u3000\u3064\u307e\u308a\u6700\u521d\u306e\u6ce2\u306e\u4f4d\u76f8\u306f0~s_p\u307e\u3067\u5165\u3063\u3066\u308b
          point_distance[i+s_p_n][j] = distance_calculate(elementary_waves_array[number_wave_point].center_x, //\u3053\u3053\u306fs
          elementary_waves_array[number_wave_point].center_y, i*point_regulation, j*point_regulation);
        }
      }
      number_wave_point++;
    }
  }
}


public void keyReleased() {
  keyReleased = true;
}

public float distance_calculate(float center_x, float center_y, float x, float y){
  float a = dist(center_x,center_y,x,y);
  return a;
}

public float range_to_calculate(int i){
  float a = (millis()-elementary_waves_array[i].created_time)*elementary_waves_array[i].lambda/elementary_waves_array[i].period/1000.0f;
  return a;
}


public void draw_wave(){
  int number_wave_point2 = number_wave_point*2;
  for(int i = 0; i < s_p; i++){
    for(int j = 0; j < s_p; j++){
      for(int k = 0; k < number_wave_point; k++){
        float range = range_to_calculate(k);//\u73fe\u5728\u306e\u6ce2\u306e\u6700\u5148\u7aef\u306e\u8ddd\u96e2\u3092\u8a08\u7b97
        //sliders_array[k].draw_slider();
        if(point_distance[i+s_p*k][j] < range){ //\u30af\u30e9\u30b9\u914d\u5217\uff0c\u5404\u70b9\u3068\u6ce2\u3054\u3068\u306e\u8ddd\u96e2\u3068\u7bc4\u56f2\u3092\u6bd4\u8f03
          float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j],
          elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
          point[i][j] += y;
        }else{
        }
      }
      point[i][j] += number_wave_point;
      if(number_wave_point != 0 || point[i][j] != 0.0f)
      {
        stroke( (number_wave_point2- point[i][j])*(230/number_wave_point2),100,100);
        point(i*point_regulation,j*point_regulation);
        point[i][j] = 0;
      }else{
        point(i*point_regulation,j*point_regulation);
      }
    }
  } 
  stroke(300,100,100,100);
  line(0,check_y*point_regulation,size,check_y*point_regulation);
  strokeWeight(10);
  for(int a = 0; a < number_wave_point; a++){
    point(elementary_waves_array[a].center_x, elementary_waves_array[a].center_y);
    text(a+1, elementary_waves_array[a].center_x-10,elementary_waves_array[a].center_y-10); 
  }
  check_y = sliders_array[0].draw_slider((float)check_y);
  for(int i = 0; i < number_wave_point; i++){//\u30b9\u30e9\u30a4\u30c0\u30fc\u3092\u63cf\u5199 \u30b9\u30e9\u30a4\u30c0\u30fc\u306e\u65b9\u306f\uff0b\uff11\u3057\u3066\u3044\u308b
    if(lambda_mode == false){
      elementary_waves_array[i].period = sliders_array[i+1].draw_slider(elementary_waves_array[i].period);
      elementary_waves_array[i].lambda = elementary_waves_array[i].period * wave_v;
  }else{
    elementary_waves_array[i].lambda = sliders_array[i+1].draw_slider(elementary_waves_array[i].lambda);
     elementary_waves_array[i].period = elementary_waves_array[i].lambda / wave_v;
  }
  }
}



public void draw_check(){ 
//stroke(0,0,0,0);
  for(int i = 0; i < s_p; i++){
    for(int j = 0; j < s_p; j++){
      for(int k = 0; k < number_wave_point; k++){
        float range = range_to_calculate(k);//\u73fe\u5728\u306e\u6ce2\u306e\u6700\u5148\u7aef\u306e\u8ddd\u96e2\u3092\u8a08\u7b97
        if(point_distance[i+s_p*k][j] < range){ //\u30af\u30e9\u30b9\u914d\u5217\uff0c\u5404\u70b9\u3068\u6ce2\u3054\u3068\u306e\u8ddd\u96e2\u3068\u7bc4\u56f2\u3092\u6bd4\u8f03
          float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j],
            elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
          point[i][j] -= y;
        }
      }
      if(j==check_y) point(i*point_regulation,(size/2+(point[i][j]*145.0f/(float)number_wave_point)));
      point[i][j] = 0;
    }
  }

  for(int i = 0; i < 11; i++){
    stroke(0,0,0,100);
    text((float)number_wave_point-(float)i*2*(float)number_wave_point/10.0f,size+10,56+i*29.5f);
    stroke(230,100,50,50);
    strokeWeight(1);
    line(0,52+i*29.5f,size,52+i*29.5f);
  }
  stroke(0,0,0,100);
  strokeWeight(5);
  line(0,size/2,size,size/2);
  line(size,0,size,size);
}

class Sliders{
  int position_x;
  int position_y;
  int slider_height;
  int slider_width;
  int digit;
  int num_separator;
  int number_tickmarks;
  float min;
  float max;
  float cordinate_y;
  String variable_name;
  boolean draw_flag;
  boolean slider_dragged;

  Sliders(int _position_x, int _position_y, int _slider_height, int _slider_width, float _min, float _max, int _number_tickmarks,int _digit, String _variable_name){
    position_x = _position_x;
    position_y = _position_y;
    slider_height = _slider_height;
    slider_width = _slider_width;
    min = _min;
    max = _max;
    number_tickmarks = _number_tickmarks;
    digit = _digit;
    variable_name = _variable_name;
    draw_flag = false;
    slider_dragged = false;
  }

  public float draw_slider(float variable_value){
    if(draw_flag == true){
      num_separator = (int)map(variable_value, min, max, number_tickmarks-1,0); //temper=\u30b0\u30ed\u30fc\u30d0\u30eb min~max\u306e\u7bc4\u56f2\u3092\uff10\u304b\u3089number_tickmarks\u306b\u5909\u63db
      cordinate_y = position_y + slider_height - ((float)slider_height / (number_tickmarks-1))*num_separator; 
      fill(255);
      noStroke();                                                        //text\u6d88\u3059\u305f\u3081
      rect(position_x, position_y + slider_height, slider_width+50, 30); 
      stroke(1);
      rect(position_x, position_y, slider_width, slider_height);
      fill(0);
      rect(position_x, cordinate_y, slider_width, position_y + slider_height - cordinate_y);
      if(variable_name == "y = "){text(variable_name + nf(variable_value*point_regulation,1,digit), position_x, position_y + slider_height + 20);
      }else{
        text(variable_name + nf(variable_value,1,digit), position_x-20, position_y + slider_height + 20);
      }
      if(mousePressed==false) slider_dragged=false;
      if(mouseX >= position_x & mouseX <= position_x + slider_width & mouseY<=cordinate_y+10 & mouseY>= cordinate_y-10){
        if(mousePressed){
          slider_dragged= true;
        }
      }
      if(slider_dragged){
        num_separator+= (int)((cordinate_y - mouseY)/((float)slider_height / (number_tickmarks-1))); // int\u306b\u3057\u306a\u3044\u3068js\u3067\u6574\u6570\u306b\u306a\u3089\u306a\u3044
        num_separator = constrain(num_separator, 0, number_tickmarks-1); //\u76ee\u76db\u308a\u3092\uff10\u304b\u3089\uff14\uff10\u307e\u3067\u306b\u5236\u9650\u3059\u308b
        if(digit == 0){
          variable_value = (max-min) - round(map(num_separator, 0, number_tickmarks-1, min, max)); // \uff10\u304b\u3089\u76ee\u76db\u308a\u3092minmax\u306b\u5909\u63db
        }else{
          variable_value = (max+min) - map(num_separator, 0, number_tickmarks-1, min, max);
        }

        
        return variable_value;
      }else{
        return variable_value;
      }
    }else{
      return variable_value;
    }
  }
}


class Elementary_waves{
  float center_x;
  float center_y;
  float lambda;
  float period;
  float created_time;
  float period_max;
  float period_min;
  float lambda_max;
  float lambda_min;

  Elementary_waves(float _center_x, float _center_y, float _lambda, float _period, 
    float _period_min, float _period_max, float _lambda_min, float _lambda_max){
    center_x = _center_x;
    center_y = _center_y;
    lambda = _lambda;
    period = _period;
    period_max = _period_max;
    period_min = _period_min;
    lambda_max = _lambda_max;
    lambda_min = _lambda_min;
    created_time = 0; //\u3068\u308a\u3042\u3048\u305a\u4ee3\u5165\u3057\u3066\u3044\u308b
  }

  public float now_displacement_y(float distance, float lambda, float period, float time_adjustment){
    float time_phase_adjustment;
    time_phase_adjustment = ((millis()-time_adjustment)/1000.0f)*(360.0f / period); //\u3053\u3053\u3067\u6642\u9593\u5dee\u3092\u8a08\u7b97\u3057\u3066\u3044\u308b\u2192\u5909\u6570\u3067\u958b\u59cb\u6642\u523b\u3092\u8a18\u9332\u2192\u3053\u308c\u3092\u4ee3\u5165\u3059\u308c\u3070\u3044\u3044\uff0e
    float distance_lambda_adjustment = (distance%lambda)/lambda*(360.0f);
    float y = sin(radians(time_phase_adjustment - distance_lambda_adjustment));
    return y;
  }


  /*float range_to_calculate(){
    float a = (millis()-created_time)*lambda/period/1000.0;
    return a;
  }*/
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "finished_wave_interference" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
