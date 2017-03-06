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

public class finished_reflection extends PApplet {

//\u53cd\u5c04\u306e\u30d7\u30ed\u30b0\u30e9\u30e0

Incident_waves f_wave;
int angle = 40;

Elementary_waves[] elementary_waves_array;
boolean keyReleased = false;
boolean check_mode = false;
int number_wave_point = 0;
int size = 400; 
int point_regulation = 4;
int s_p = size/point_regulation;
int maximum_waves_number = 5; 
int create_point_flag = 0;
float point_width;
float surface = size/5*3;

float[][] point = new float[s_p][s_p];
float[][] point_distance = new float[s_p*maximum_waves_number][s_p];
boolean[][] point_draw_flag  = new boolean[s_p][s_p];
boolean check = false;
boolean slider_dragged = false;
boolean draw_line_point = true;

//float lambda = 300.0;
//float period = 3.0;
float record_lambda;
float cross_line_x;
int cross_line_x_i;

float average_slope = 0;
int average_slope_count = 0;


float max_phase = 0;
int max_phase_x;
int max_phase_y;

float y_to_x;

float max_line_flag;

float wave_period = 5.0f;


float incident_x_speed;


public void setup() {  
  colorMode(HSB, 360, 100, 100);
  size(size+200, size);
  frameRate(10);
  //println(frameRate);
  f_wave = new Incident_waves();
  f_wave.calculate_cross_line_x();
  elementary_waves_array = new Elementary_waves[maximum_waves_number];
  make_waves_instance(); //\u5168\u3066\u306e\u70b9\u6e90\u306e\u30a4\u30f3\u30b9\u30bf\u30f3\u30b9\u3092\u4f5c\u6210
  //calculate_refraction_angle();
}


public void make_waves_instance() {
  for (int i = 0; i < elementary_waves_array.length; i++) {
    
    Elementary_waves elementary_waves = new Elementary_waves(((-cross_line_x)+(float)point_width*(i-2.0f)), surface, f_wave.speed*cos(radians(angle))*frameRate*wave_period, wave_period);
    elementary_waves_array[i] = elementary_waves;
    int s_p_n = s_p * i;
    for (int j = 0; j < s_p; j++) {
      for (int k = 0; k < s_p; k++) {
        point_distance[j+s_p_n][k] = distance_calculate(elementary_waves_array[i].center_x, //\u3053\u3053\u306fs
        elementary_waves_array[i].center_y, j*point_regulation, k*point_regulation);
      }
    }
  }
}


public void draw() {  
  background(255);
  strokeWeight(point_regulation);
  draw_wave();
}




public float distance_calculate(float center_x, float center_y, float x, float y) {
  float a = dist(center_x, center_y, x, y);
  return a;
}

public void draw_wave() { //\u6ce2\u304c\u4e00\u3064\u306e\u30d0\u30fc\u30b8\u30e7\u30f3
  f_wave.draw_incident_waves();
  int number_wave_point2 = number_wave_point*2;
  for (int i = cross_line_x_i; i < s_p; i++) {/////////
    for (int j = 0; j < s_p/5*3; j++) {
      for (int k = 0; k < number_wave_point; k++) {
        float range = elementary_waves_array[k].range_to_calculate();//\u73fe\u5728\u306e\u6ce2\u306e\u6700\u5148\u7aef\u306e\u8ddd\u96e2\u3092\u8a08\u7b97
        float range2 = range - (elementary_waves_array[k].lambda); //\u3053\u3053\u3092\u6d88\u305b\u3070\u6ce2\u304c\u5897\u3048\u308b

        if (point_distance[i+s_p*k][j] < range && point_distance[i+s_p*k][j] > range2) { //\u30af\u30e9\u30b9\u914d\u5217\uff0c\u5404\u70b9\u3068\u6ce2\u3054\u3068\u306e\u8ddd\u96e2\u3068\u7bc4\u56f2\u3092\u6bd4\u8f03

          float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j], 
            elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
          point[i][j] += y;
        } else {
        }
      }//k\u306f\u3053\u3053\u307e\u3067

      point[i][j] += number_wave_point;
      if (number_wave_point != 0) {
        stroke( (number_wave_point2- point[i][j])*(230/number_wave_point2),100,100);
      } else {
        stroke(115, 100, 100);//\u6ce2\u304c\u4e00\u3064\u3082\u751f\u307e\u308c\u3066\u306a\u3044\u6642\u753b\u9762\u3092\u7dd1\u306b\u3059\u308b
      }

      //max_phase\u306e\u8a08\u7b97
      if(number_wave_point>4){//\u5168\u3066\u306e\u6ce2\u6e90\u304c\u52d5\u4f5c\u3057\u59cb\u3081\u3066\u304b\u3089.
        if(max_phase < point[i][j])
        {
          max_phase = point[i][j];
          max_phase_x = i;
          max_phase_y = j;
        }
      }


      point[i][j] = 0;//\u521d\u671f\u5316
      point(i*point_regulation, j*point_regulation);

      //\u3053\u3053\u307e\u3067j\u304c\u56de\u3063\u3066\u3044\u308b
    }
  }//\u3053\u3053\u307e\u3067i


  stroke(0);
  rect(0, surface, size, 2);
  stroke(0);
  f_wave.draw_line();

  strokeWeight(6);
  for (int a = 0; a < number_wave_point; a++) {
    point(elementary_waves_array[a].center_x, elementary_waves_array[a].center_y);
  }
  slider(size+20, 20, size-50, 30, 10.0f, 200.0f, 40);


    if(max_phase_y!=0 &&max_phase_y*point_regulation < surface-20  ){//y\u306e\u6700\u9ad8\u5ea7\u6a19\u304c\u8868\u9762\u96e2\u308c\u305f\u3089,average\u8a08\u7b97\u3057\u3066\u63cf\u5199\u3000
      int max_phase_x_p = max_phase_x*point_regulation;
      int max_phase_y_p = max_phase_y*point_regulation;
      average_slope += (surface-(float)max_phase_y_p)/(max_phase_x_p-elementary_waves_array[2].center_x);
      average_slope_count++;
      stroke(210);
      line(elementary_waves_array[maximum_waves_number/2].center_x, surface,
        max_phase_x_p, max_phase_y_p);
    
    float a = average_slope/(float)average_slope_count;
    //println(a);
    stroke(300,100,100);
    line(elementary_waves_array[2].center_x,elementary_waves_array[2].center_y,
      elementary_waves_array[2].center_x+500,elementary_waves_array[2].center_y-500*a);
    stroke(0);
  //println(max_phase_y);
}
  
  if(angle < 35){
    if(max_phase_y < 3 && max_phase_x*point_regulation > -cross_line_x+10){
      stroke(300,100,100);
      float a = average_slope/(float)average_slope_count;
      //println(average_slope);
      //println(average_slope_count);
      line(elementary_waves_array[2].center_x,elementary_waves_array[2].center_y,
        elementary_waves_array[2].center_x+500,elementary_waves_array[2].center_y-500*a);
      for(float count = 1.0f; count < 90.0f; count+=0.1f){
        if( tan(radians(count)) > a ){
          println(90-count-0.1f);
          break;
        }
        
      }
      noLoop();
      stroke(0);
      
    }
  }else{//35\u5ea6\u4ee5\u4e0a
    if(max_phase_x > 97 && max_phase_x*point_regulation > -cross_line_x+10) {
      stroke(300,100,100);
      float a = average_slope/(float)average_slope_count;
      //println(a);
      //println(average_slope);
      //println(average_slope_count);
      line(elementary_waves_array[2].center_x,elementary_waves_array[2].center_y,
      elementary_waves_array[2].center_x+500,elementary_waves_array[2].center_y-500*a);
      
      for(float count = 0.1f; count < 90.0f; count+=0.1f){
        if( tan(radians(count)) > a ){
          println(90-count-0.1f);
          break;
        }
      }
      stroke(0);
      noLoop();
    }
  }
  max_phase = 0;
}




class Incident_waves {
  float x, y;
  float speed;
  Incident_waves() {
    speed = 4.0f;
    y_to_x =  (cos(radians(angle)))/ (sin(radians(angle)));
    x =  (speed * y_to_x);
    y = 0;
    incident_x_speed = x;
    point_width = incident_x_speed; 
  }

  public void draw_line() {
    if (angle != 0) {
      //x = (y * cos(radians(angle)))/ (sin(radians(angle)));
      //line(0,y,x,0);
      if (y >= surface)check_create_elementary_waves(x, y);
      line(-cross_line_x, 0, -cross_line_x, size);//\u5782\u7dda
      //line(-cross_line_x,size/2, -cross_line_x + size/2 * tan(radians(refraction_angle)),size);
      fill(255);
      noStroke();
      //rect(0,size/2, size,size/2+10);
      rect(size, 0, width-size+5, height+10);
      draw_incident_line();
    } else {
    }
    y += speed;
    //check_create_elementary_waves();
  }

  public void draw_incident_waves() {
    if (angle != 0) {
      x = (y * cos(radians(angle)))/ (sin(radians(angle)));
      line(0, y, x, 0);

    } else {
    }
  }

  public void check_create_elementary_waves(float x, float y) {

    for (int i = 0; i < elementary_waves_array.length; i++) {
      float collision_x = (((y-surface)/y) * x);
      //println(i + "   " + collison_x);
      strokeWeight(12);
      point(elementary_waves_array[i].center_x, elementary_waves_array[i].center_y);
      strokeWeight(point_regulation);
      if (collision_x > elementary_waves_array[i].center_x && elementary_waves_array[i].collision_check_flag == false) {
        elementary_waves_array[i].created_time = millis();
        elementary_waves_array[i].collision_check_flag = true;
        number_wave_point++;
        create_point_flag++;
      }
    }
  }


  public void calculate_cross_line_x() {
    float a = tan(radians(angle));
    float b = (-1.0f) / a; //\u63a5\u7dda\u306e\u65b9\u7a0b\u5f0f\u306e\u305f\u3081\u306ba*b\u304c-1\u306b\u306a\u308b\u3088\u3046\u306b\u8abf\u6574
    cross_line_x = surface/b;
    //println(cross_line_x);
    cross_line_x_i = (int)((-cross_line_x)/point_regulation + 1);
  }

  public void draw_incident_line() {
    stroke(0);
    line(0, 0, -cross_line_x, surface);
    line(-cross_line_x, surface, -2*cross_line_x, 0);
  }
}



class Elementary_waves {
  float center_x;
  float center_y;
  float lambda;
  float period;
  float created_time;
  float range_to_calculate;
  boolean draw_flag;
  boolean collision_check_flag;

  Elementary_waves(float _center_x, float _center_y, float _lambda, float _period) {
    center_x = _center_x;
    center_y = _center_y;
    lambda = _lambda;
    period = _period;
    created_time = 0; //\u3068\u308a\u3042\u3048\u305a\u4ee3\u5165\u3057\u3066\u3044\u308b
    draw_flag = false;
    collision_check_flag = false;
  }

  public float now_displacement_y(float distance, float lambda, float period, float time_adjustment){
    float time_phase_adjustment;
    time_phase_adjustment = ((millis()-time_adjustment)/1000.0f)*(360.0f / period); //\u3053\u3053\u3067\u6642\u9593\u5dee\u3092\u8a08\u7b97\u3057\u3066\u3044\u308b\u2192\u5909\u6570\u3067\u958b\u59cb\u6642\u523b\u3092\u8a18\u9332\u2192\u3053\u308c\u3092\u4ee3\u5165\u3059\u308c\u3070\u3044\u3044\uff0e
    float distance_lambda_adjustment = (distance%lambda)/lambda*(360.0f);
    float y = sin(radians(time_phase_adjustment - distance_lambda_adjustment));
    return y;
  }


  public float range_to_calculate() {
    float a = (millis()-created_time)*lambda/period/1000.0f;
    return a;
  }
}




public void slider(int position_x, int position_y, int slider_height, int slider_width, float min, float max, int number_tickmarks) {

  int num_separator = (int)map(elementary_waves_array[0].lambda, min, max, 0, number_tickmarks-1); //temper=\u30b0\u30ed\u30fc\u30d0\u30eb min~max\u306e\u7bc4\u56f2\u3092\uff10\u304b\u3089number_tickmarks\u306b\u5909\u63db
  float cordinate_y = position_y + slider_height - ((float)slider_height / (number_tickmarks-1))*num_separator;
 

  text( "lambda="+nf(elementary_waves_array[0].lambda, 1, 1), position_x, position_y + slider_height + 20);

  //nf = \u6570\u5024\u306e\u30d5\u30a9\u30fc\u30de\u30c3\u30c8\u3000\u4eca\u56de\u306e\u5834\u5408\u306f\u5c0f\u6570\u70b9\u4ee5\u4e0a\uff11\uff0c\u5c0f\u6570\u70b9\u4ee5\u4e0b\uff11
  if (mousePressed==false) slider_dragged=false;
  if (mouseX >= position_x & mouseX <= position_x + slider_width & mouseY<=cordinate_y+10 & mouseY>= cordinate_y-10) {
    if (mousePressed) {
      slider_dragged= true;
    }
  }

}



  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "finished_reflection" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
