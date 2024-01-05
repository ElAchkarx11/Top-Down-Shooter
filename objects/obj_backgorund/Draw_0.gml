var _temp = abs(sin(get_timer()/1000000));


_cor_1 = make_color_rgb(133 * _temp * 0.8,122 * _temp * 0.5,144 * _temp * 0.2);
_cor_2 = make_color_rgb(90 * _temp * 0.5,100 * _temp * 0.9,120 * _temp * 0.3);

draw_rectangle_color(x, y, room_height, room_width, _cor_1, _cor_2, _cor_2, _cor_2, false);