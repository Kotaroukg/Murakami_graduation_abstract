//ゴリ押し

Elementary_waves[] elementary_waves_array;
boolean keyReleased = false;
boolean check_mode = false;
int number_wave_point = 0;
int size = 400; 
int point_regulation = 4;
int s_p = size/point_regulation;
int maximum_waves_number = 8;
float[][] point = new float[s_p][s_p];
float[][] point_distance = new float[s_p*maximum_waves_number][s_p];
boolean[][] point_draw_flag  = new boolean[s_p][s_p];
boolean check = false;


void setup(){  
  colorMode(HSB, 360,100,100);
  size(size+250,size);
  frameRate(30);
  elementary_waves_array = new Elementary_waves[maximum_waves_number];
  make_elementary_waves(); //全ての点源のインスタンスを作成
}

void make_elementary_waves(){
  for(int i = 0; i < elementary_waves_array.length; i++){
    Elementary_waves elementary_waves = new Elementary_waves(width/2-50,size/2,80.0,5.0);//とりあえず作っている.
    elementary_waves_array[i] = elementary_waves;
  }
}


void draw(){  
  background(255);
  //println(frameRate);
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
  if(maximum_waves_number>number_wave_point){
    elementary_waves_array[number_wave_point].center_x = mouseX;
    elementary_waves_array[number_wave_point].center_y = mouseY;
    elementary_waves_array[number_wave_point].draw_flag = true;
    elementary_waves_array[number_wave_point].created_time = millis();
    //if(number_wave_point == 1) elementary_waves_array[number_wave_point].period = 40.0;
    //if(number_wave_point == 1) elementary_waves_array[number_wave_point].lambda = 50.0;
    for(int i = 0; i < s_p; i++){
      for(int j = 0; j < s_p; j++){//s_p_nは０→１へと増える　つまり最初の波の位相は0~s_pまで入ってる
      point_distance[i+s_p_n][j] = distance_calculate(elementary_waves_array[number_wave_point].center_x, //ここはs
        elementary_waves_array[number_wave_point].center_y, i*point_regulation, j*point_regulation);
      }
    }
    number_wave_point++;
  }
  println(point_distance[0][0]);
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
        //if(i == 50) println(k + "               " + range);
        if(point_distance[i+s_p*k][j] < range){ //クラス配列，各点と波ごとの距離と範囲を比較
          float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j],
            elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
          point[i][j] += y;
        }else{
        }
      }
      point[i][j] += number_wave_point;
      //if (i == 50) println(point[i][j]);
       if(number_wave_point != 0 || point[i][j] != 0.0){stroke(point[i][j]*(230/(number_wave_point*2)),100,100);
      point(i*point_regulation,j*point_regulation);
      point[i][j] = 0;
       }
     
    }
  } 
  stroke(300,100,100);
  strokeWeight(10);
  for(int a = 0; a < number_wave_point; a++){
    point(elementary_waves_array[a].center_x, elementary_waves_array[a].center_y); 
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
      if(j==size/2/point_regulation) point(i*point_regulation,150+point[i][j]/number_wave_point*3);
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



