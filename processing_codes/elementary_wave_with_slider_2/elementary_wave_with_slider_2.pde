Elementary_waves[] elementary_waves_array;
Sliders[] sliders_array;
boolean keyReleased = false;
boolean check_mode = false;
int number_wave_point = 0;
int size = 300; 
int point_regulation = 4;
int s_p = size/point_regulation;
int maximum_waves_number = 5;
float[][] point = new float[s_p][s_p];
float[][] point_distance = new float[s_p*maximum_waves_number][s_p];
boolean[][] point_draw_flag  = new boolean[s_p][s_p];
boolean check = false;


void setup(){  
  colorMode(HSB, 360,100,100);
  size(size+maximum_waves_number * 90,size);
  frameRate(30);
  elementary_waves_array = new Elementary_waves[maximum_waves_number];
  sliders_array = new Sliders[maximum_waves_number];
  make_elementary_waves(); //全ての点源のインスタンスを作成
  make_sliders();
}

void make_elementary_waves(){
  for(int i = 0; i < elementary_waves_array.length; i++){
    Elementary_waves elementary_waves = new Elementary_waves(width/2-50,size/2,40.0,5.0);//とりあえず作っている.
    elementary_waves_array[i] = elementary_waves;
  }
}

void make_sliders(){
  for(int i = 0; i < sliders_array.length; i++){
    Sliders sliders = new Sliders(size+20+i*80,20,size-50,30,1.0,10.0,20,i);
    sliders_array[i] = sliders;
  }
}


void draw(){  
  background(255);
  strokeWeight(point_regulation);
  if(check_mode == true){
    draw_check();
  }else{
    draw_wave();
  }
}


void keyPressed(){
  if((keyPressed == true) && keyReleased == true &&((key == 'c') ||  (key == 'C'))){
    keyReleased = false;
    check_mode = true;
  }
  if((keyPressed == true) && keyReleased == true && ((key == 'b') ||  (key == 'B'))){
    keyReleased = false;
    check_mode = false;
  }
}


void mousePressed() { //新しい素元波を一つ生成．
  int s_p_n = s_p * number_wave_point;
  if(mouseX < size){
    if(maximum_waves_number>number_wave_point){
      elementary_waves_array[number_wave_point].center_x = mouseX;
      elementary_waves_array[number_wave_point].center_y = mouseY;
      elementary_waves_array[number_wave_point].draw_flag = true;
      elementary_waves_array[number_wave_point].created_time = millis();
      sliders_array[number_wave_point].draw_flag = true;
    for(int i = 0; i < s_p; i++){
      for(int j = 0; j < s_p; j++){//s_p_nは０→１へと増える　つまり最初の波の位相は0~s_pまで入ってる
      point_distance[i+s_p_n][j] = distance_calculate(elementary_waves_array[number_wave_point].center_x, //ここはs
        elementary_waves_array[number_wave_point].center_y, i*point_regulation, j*point_regulation);
    }
  }
  number_wave_point++;
}

}
}


void keyReleased() {
  keyReleased = true;
}

float distance_calculate(float center_x, float center_y, float x, float y){
  float a = dist(center_x,center_y,x,y);
  return a;
}



void draw_wave(){
  for(int i = 0; i < s_p; i++){
    for(int j = 0; j < s_p; j++){
      for(int k = 0; k < number_wave_point; k++){
        float range = elementary_waves_array[k].range_to_calculate();//現在の波の最先端の距離を計算
        //sliders_array[k].draw_slider();
        if(point_distance[i+s_p*k][j] < range){ //クラス配列，各点と波ごとの距離と範囲を比較
          float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j],
            elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
          point[i][j] += y;
        }else{
        }
      }
      point[i][j] += number_wave_point;
      if(number_wave_point != 0 || point[i][j] != 0.0){stroke(point[i][j]*(230/(number_wave_point*2)),100,100);
        point(i*point_regulation,j*point_regulation);
        point[i][j] = 0;
      }else{
       point(i*point_regulation,j*point_regulation);
     }

     
   }
 } 
 stroke(300,100,100);
 strokeWeight(10);
 for(int a = 0; a < number_wave_point; a++){
  point(elementary_waves_array[a].center_x, elementary_waves_array[a].center_y);
  text(a+1, elementary_waves_array[a].center_x-10,elementary_waves_array[a].center_y-10); 
}
for(int i=0; i < number_wave_point; i++){
  sliders_array[i].draw_slider();
}

}


void draw_check(){ 

  for(int i = 0; i < s_p; i++){
    for(int j = 0; j < s_p; j++){
      for(int k = 0; k < number_wave_point; k++){
        float range = elementary_waves_array[k].range_to_calculate();//現在の波の最先端の距離を計算
        if(point_distance[i+s_p*k][j] < range){ //クラス配列，各点と波ごとの距離と範囲を比較
          float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j],
            elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
          point[i][j] += y;
        }
      }
      if(j==size/2/point_regulation) point(i*point_regulation,200+point[i][j]/number_wave_point*3);
    }
  }

}


 class Sliders{
  int position_x;
  int position_y;
  int slider_height;
  int slider_width;
  float min;
  float max;
  int number_tickmarks;
  int correspond_to_wave_number;
  boolean draw_flag;
  boolean slider_dragged;

  Sliders(int _position_x, int _position_y, int _slider_height, int _slider_width, float _min, float _max, int _number_tickmarks, int _correspond_to_wave_number){
    position_x = _position_x;
    position_y = _position_y;
    slider_height = _slider_height;
    slider_width = _slider_width;
    min = _min;
    max = _max;
    number_tickmarks = _number_tickmarks;
    correspond_to_wave_number = _correspond_to_wave_number;
    draw_flag = false;
    slider_dragged = false;

  }

  void draw_slider(){
    if(draw_flag == true){
  int num_separator = (int)map(elementary_waves_array[correspond_to_wave_number].period, min, max, 0, number_tickmarks-1); //temper=グローバル min~maxの範囲を０からnumber_tickmarksに変換
  float cordinate_y = position_y + slider_height - ((float)slider_height / (number_tickmarks-1))*num_separator;
  fill(255);
  noStroke();                                                        //text消すため
  rect(position_x, position_y + slider_height, slider_width+50, 30); 
  stroke(1);
  rect(position_x, position_y, slider_width, slider_height);
  fill(0);
  //rect(position_x, cordinate_y, slider_width, position_y + slider_height - cordinate_y);
  rect(position_x, cordinate_y, slider_width, position_y + slider_height - cordinate_y);
  
  text( "period="+nf(elementary_waves_array[0].period,1,1), position_x, position_y + slider_height + 20);
  //nf = 数値のフォーマット　今回の場合は小数点以上１，小数点以下１
  if(mousePressed==false) slider_dragged=false;
  if(mouseX >= position_x & mouseX <= position_x + slider_width & mouseY<=cordinate_y+10 & mouseY>= cordinate_y-10){
    if(mousePressed){
      slider_dragged= true;
    }
  }

  if(slider_dragged){
     num_separator+= (int)((cordinate_y - mouseY)/((float)slider_height / (number_tickmarks-1))); // intにしないとjsで整数にならない
     num_separator = constrain(num_separator, 0, number_tickmarks-1);
     elementary_waves_array[correspond_to_wave_number].period = map(num_separator, 0, number_tickmarks-1, min, max);
     //elementary_waves_array[correspond_to_wave_number].lambda =elem 
   }
 }
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
    created_time = 0; //とりあえず代入している
    //float[][] point_distance = new float[s_p][s_p];
    draw_flag = false;
  }

  float now_displacement_y(float distance, float lambda, float period, float time_adjustment){
    float time_phase_difference;
    time_phase_difference = ((millis()-time_adjustment)/1000.0)*(360.0 / period); //ここで時間差を計算している→変数で開始時刻を記録→これを代入すればいい．
    //time_phase_difference = ((millis()-time_adjustment)/1000.0) /lambda *(360.0); //ここで時間差を計算している→変数で開始時刻を記録→これを代入すればいい．
    float a; 
    a = (distance%lambda)/lambda*(360.0);
    float y = sin(radians(-time_phase_difference+a));
    return y;
  }


  float range_to_calculate(){
    float a = (millis()-created_time)*lambda/period/1000.0;
    return a;
  }
}



