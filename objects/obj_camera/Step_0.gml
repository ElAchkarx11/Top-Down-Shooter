if !instance_exists(_target) exit;

x = lerp(x, _target.x, 0.1);
y = lerp(y, _target.y-_height/4, 0.1);

camera_set_view_pos(view_camera[0], x-_width/2, y-_height/4);


//window_set_fullscreen(1);
