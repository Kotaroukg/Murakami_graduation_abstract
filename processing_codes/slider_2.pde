
class Sliders{
  int position_x;
  int position_y;
  int slider_height;
  int slider_width;
  float min;
  float max;
  int number_tickmarks;
  int correspond_to_wave_number;

  Sliders(int _position_x; int _position_y; int _slider_height; int _slider_width;
    float _min;float _max;int _number_tickmarks; int _correspond_to_wave_number){
    center_x = _potision_x;
    center_y = _position_y;
    slider_height = _slider_height;
    slider_width = _slider_width;
    min = _min;
    max = _max;
    number_tickmarks = _number_tickmarks;
    correspond_to_wave_number = _correspond_to_wave_number;

  }

  void draw_slider(){
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
     println("aaaaaaaaaaaaaa");
     num_separator+= (int)((cordinate_y - mouseY)/((float)slider_height / (number_tickmarks-1))); // intにしないとjsで整数にならない
     num_separator = constrain(num_separator, 0, number_tickmarks-1);
     elementary_waves_array[correspond_to_wave_number].period = map(num_separator, 0, number_tickmarks-1, min, max);
     //elementary_waves_array[correspond_to_wave_number].lambda =elem 
  }
}






