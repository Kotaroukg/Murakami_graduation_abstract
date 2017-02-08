  Elementary_waves[] elementary_waves_array;
  boolean keyReleased = false;
  boolean check_mode = false;
  int number_wave_point = 1;
  int size = 300; 
  int point_regulation = 4;
  int s_p = size/point_regulation;
  int maximum_waves_number = 6;
  int create_point_flag = 0;
  int point_width = 5;
  float max_phase = 0;
  int max_phase_x;
  int max_phase_y;
  float[][] point = new float[s_p][s_p];
  float[][] point_distance = new float[s_p*maximum_waves_number][s_p];
  float[] distance_i_point_to_e_point = new float[maximum_waves_number];
  boolean[][] point_draw_flag  = new boolean[s_p][s_p];
  boolean check = false;
  boolean slider_dragged = false;
  boolean draw_line_point = true;
  
  float lambda = 40.0;
  float period = 1.5;
  float refractive_index = 0.5;
  float record_lambda;
  
  
  void setup(){  
    colorMode(HSB, 360,100,100);
    size(size+200,size);
    frameRate(30);
    elementary_waves_array = new Elementary_waves[maximum_waves_number];
    make_waves_instance(); //全ての点源のインスタンスを作成
    calculate_i_point_to_e_point();
  }
  
  
  void make_waves_instance(){
    for(int i = 0; i < elementary_waves_array.length; i++){
      if(i == 0){Elementary_waves elementary_waves = new Elementary_waves(0,0,lambda,period); elementary_waves_array[i] = elementary_waves;}
      else{
        //Elementary_waves elementary_waves = new Elementary_waves((size-point_width)/2 + (i-1)*(point_width/ (maximum_waves_number-2)),size/2,lambda*2.0,3.0); 
        Elementary_waves elementary_waves = new Elementary_waves(100+point_width/(maximum_waves_number-2)*(i-1),size/2,lambda*refractive_index,period); 
        elementary_waves_array[i] = elementary_waves;
      }
      int s_p_n = s_p * i;
      for(int j = 0; j < s_p; j++){
        for(int k = 0; k < s_p; k++){
        point_distance[j+s_p_n][k] = distance_calculate(elementary_waves_array[i].center_x, //ここはs
          elementary_waves_array[i].center_y, j*point_regulation, k*point_regulation);
      }
    }
  }
}

void calculate_i_point_to_e_point(){
  for(int i = 1; i < elementary_waves_array.length; i++){
      //distance_i_point_to_e_point[i-1] = dist(0,0,(size-point_width)/2 + (i-1)*(point_width/ (maximum_waves_number-2)),size/2);
      distance_i_point_to_e_point[i-1] = dist(0,0,elementary_waves_array[i].center_x,size/2);
      println(distance_i_point_to_e_point[i-1]);
    }
  }
  
  
  void draw(){  
    background(255);
    //println(frameRate);
    strokeWeight(point_regulation);
    if(check_mode == true){
      //draw_check();
    }else{
      draw_wave();
      line(0,0,elementary_waves_array[maximum_waves_number/2].center_x,size/2);
      //text("fuck", );
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
  
  void keyReleased() {
    keyReleased = true;
  }
  
  float distance_calculate(float center_x, float center_y, float x, float y){
    float a = dist(center_x,center_y,x,y);
    return a;
  }

  void draw_wave(){ //波が一つのバージョン
    for(int i = 0; i < s_p; i++){
      int i_p = i * point_regulation;
      for(int j = 0; j < s_p; j++){
        for(int k = 0; k < number_wave_point; k++){
          float range = elementary_waves_array[k].range_to_calculate();//現在の波の最先端の距離を計算
          float range2 = range - elementary_waves_array[k].lambda; //ここを消せば波が増える
          if(point_distance[i+s_p*k][j] < range && point_distance[i+s_p*k][j] > range2){ //クラス配列，各点と波ごとの距離と範囲を比較
          //if(point_distance[i+s_p*k][j] < range){
            float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j],
              elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
            
            if(k != 0) 
            {
              if(i_p>elementary_waves_array[maximum_waves_number/2].center_x)point[i][j] += y;
            }else{
              if(j<s_p/2 && i_p < elementary_waves_array[maximum_waves_number/2].center_x) point[i][j] += y;//入射波の話
            }
            if(create_point_flag < maximum_waves_number-1){
              if(range > distance_i_point_to_e_point[create_point_flag])
              {
                elementary_waves_array[number_wave_point].created_time = millis();
                number_wave_point++;
                create_point_flag++;
              }
            }
          }else{
          }
        }//kはここまで
        //if (i == 50) println(point[i][j]);
        if(number_wave_point != 0 || point[i][j] != 0.0){
          if(j<s_p/2 && i_p < elementary_waves_array[maximum_waves_number/2].center_x){
            point[i][j] += 1.0;
            stroke(point[i][j]*115.0,100,100);//230/2
          }else if(number_wave_point > 1){
            if(j > s_p/2){
            if(max_phase > point[i][j] && draw_line_point == true) {
              max_phase = point[i][j];
              max_phase_x = i;
              max_phase_y = j;
              if(max_phase_y > s_p - 3) draw_line_point = false;
              //if(max_phase_x > s_p - 3 || max_phase_y > s_p -3) draw_line_point = false;
            }
          }
            point[i][j] += (number_wave_point-1);

            stroke(point[i][j]*(230.0/((number_wave_point-1)*2.0)),100,100);
            
          }
          point(i*point_regulation,j*point_regulation);
          point[i][j] = 0;
          
        }else{
         point(i*point_regulation,j*point_regulation);
       }
       
       //ここまでjが回っている
     }
   }
    //rect(0,size/2,size,size);
    stroke(300,100,100);
    rect(0,size/2,size,2);
    strokeWeight(6);
    
    for(int a = 0; a < number_wave_point; a++){
      point(elementary_waves_array[a].center_x, elementary_waves_array[a].center_y);
      text(a, elementary_waves_array[a].center_x-10,elementary_waves_array[a].center_y-10); 
    }
    slider(size+20,20,size-50,30,10.0,200.0,40);

    line(elementary_waves_array[maximum_waves_number/2].center_x,elementary_waves_array[maximum_waves_number/2].center_y,max_phase_x*point_regulation,max_phase_y*point_regulation);
    max_phase = 0;
  }

  
  void slider(int position_x, int position_y, int slider_height, int slider_width, float min, float max, int number_tickmarks){
    
    int num_separator = (int)map(elementary_waves_array[0].lambda, min, max, 0, number_tickmarks-1); //temper=グローバル min~maxの範囲を０からnumber_tickmarksに変換
    float cordinate_y = position_y + slider_height - ((float)slider_height / (number_tickmarks-1))*num_separator;
    fill(255);
    noStroke();                                                        //text消すため
    rect(position_x, position_y + slider_height, slider_width+50, 30); 
    stroke(1);
    rect(position_x, position_y, slider_width, slider_height);
    fill(0);
    //rect(position_x, cordinate_y, slider_width, position_y + slider_height - cordinate_y);
    rect(position_x, cordinate_y, slider_width, position_y + slider_height - cordinate_y);
    
    text( "lambda="+nf(elementary_waves_array[0].lambda,1,1), position_x, position_y + slider_height + 20);
    
    //nf = 数値のフォーマット　今回の場合は小数点以上１，小数点以下１
    if(mousePressed==false) slider_dragged=false;
    if(mouseX >= position_x & mouseX <= position_x + slider_width & mouseY<=cordinate_y+10 & mouseY>= cordinate_y-10){
      if(mousePressed){
        slider_dragged= true;
      }
    }
    
    if(slider_dragged){
       //println("aaaaaaaaaaaaaa");
       num_separator+= (int)((cordinate_y - mouseY)/((float)slider_height / (number_tickmarks-1))); // intにしないとjsで整数にならない
       num_separator = constrain(num_separator, 0, number_tickmarks-1);
       for(int i = 0; i < number_wave_point; i++){
         elementary_waves_array[i].lambda=map(num_separator, 0, number_tickmarks-1, min, max);
       }
       float a = elementary_waves_array[0].lambda / record_lambda;
       for(int i = 0; i < number_wave_point; i++){
         elementary_waves_array[i].period= elementary_waves_array[i].period * a;
       }
       record_lambda = elementary_waves_array[0].lambda;
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
  

