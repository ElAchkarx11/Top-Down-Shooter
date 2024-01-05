// set the direction of the enemy for player
var _dir = point_direction(x, y, obj_player.x, obj_player.y);

// the image angle gonna be the same as _dir, to start to follows player
image_angle = _dir;

// setting the speed and the direction for move and collide
var _xx = lengthdir_x(enemy_speed, _dir);
var _yy = lengthdir_y(enemy_speed, _dir);

//moving and colliding for the same position as the player
move_and_collide(_xx, _yy, colisions);


