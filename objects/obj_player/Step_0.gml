#region Controls
//setting the Controls
	 var _kb_left = keyboard_check(ord("A"));
	 var _kb_right = keyboard_check(ord("D"));
	 var _kb_up = keyboard_check(ord("W"));
	 var _kb_down = keyboard_check(ord("S"));

	// setting the mouse button that makes player shoot
	 var _mb_attack = mouse_check_button_pressed(mb_left);
	 
	 var _equip_weapon = keyboard_check_pressed(ord("E"));
	 var _drop_weapon = keyboard_check_pressed(ord("F"));
	 


	//setting the keyboard key that makes the playe reload
	 var _reload = keyboard_check_pressed(ord("R"));
	 
#endregion;
	 
#region Movimentation



 // multipliyng the values of the keys for the speed of the player
	var _velh = (_kb_right - _kb_left) * my_speed;
	var _velv = (_kb_down - _kb_up) * my_speed;

	var _moving = _kb_down || _kb_up || _kb_left || _kb_right;

	// using move and collide to set where to colide and for what direction to move
	move_and_collide(_velh, _velv, obj_wall, 4,0,0, my_speed, my_speed);


#endregion;

#region Attack
	
	if(weapon_active && _drop_weapon){
			weapon_active = false;
			var _rotation_speed = 2;
			
			
			with(instance_create_layer(x, y, layer, global.weapon_name)){
			
				speed = 30;
				
				
				direction = other.image_angle ;
				
			
			}
			
	
	}
	
	//setting direction for the place where mouse is
	var _dir = point_direction(x, y, mouse_x, mouse_y);

	//this part of the code makes change the position of de x and y plus fifty
	var _xx = lengthdir_x(50, _dir);
	var _yy = lengthdir_y(50, _dir);

	//this block of code make the camera moviment more smooth
	image_angle =  _dir;

	var _current_frame = 0;

	#region Shoot
		// this condition bracket makes the player shoot just if the button was pressed and bullets are bigger than zero
		if(_mb_attack && bullets > 0 && weapon_active){
			bullets--;
	
			//Tentar fazer outra arma para pegar
			//create the layer with the object that representes shoot with speed 10 and direction of the image angle
			with(instance_create_layer(x + _xx, y + _yy, "Shoot", obj_shoot)){
				speed = 40;
		
				direction = other.image_angle;
			}
		}

		//this condition bracket makes the player reload, setting the bullets equal to remaining bullets
		if(_reload){
	
			bullets = remaining_bullets;

	}
	#endregion;
	
	#region Melee attack
	
		if(_mb_attack && !weapon_active){
			
			
			state = PLAYER_STATE.ATTACK;
			image_index = 0;
		}
	
	#endregion;
	
#endregion;

switch (state){

	case PLAYER_STATE.FREE: 
		
		
		if (_moving) {
			sprite_index = spr_player_moving;
		} else{ 
			sprite_index = spr_player_idle;
		};
		
	break;
	
	case PLAYER_STATE.ATTACK: 
	
	
	
	var _inimigos_na_hitbox = ds_list_create();
	var _inimigos = instance_place_list(x, y, obj_enemy,_inimigos_na_hitbox, false);
	
	if(_inimigos) > 0 {
		for(var _i = 0; _i < _inimigos; _i++){
		
			var _inimigo_id = _inimigos_na_hitbox[| _i];
			
			if(ds_list_find_index(_inimigos_atingidos, _inimigo_id)) == -1{
				ds_list_add(_inimigos_atingidos, _inimigo_id);
				
				with(_inimigo_id){
				
					instance_destroy(_inimigo_id);
				}
			}
		
		}
	}
	ds_list_destroy(_inimigos_na_hitbox);
	
	
	
	
	
		sprite_index = spr_player_idle_attack;
		mask_index = spr_player_idle_attack_hb;
			
//Tentantiva de fazer um combo de glpes
		if(image_index >= 4){
			if (mouse_check_button_pressed(mb_right)){
				combo = true;
				
			}
			
		}
		
		if(fim_da_animacao()){
			
			mask_index = spr_player_moving;
			ds_list_clear(_inimigos_atingidos);
			state = PLAYER_STATE.FREE;	
		}
	break;
		

}
	
function fim_da_animacao(){
    var _sprite = sprite_index;
    var _image = image_index;
    if(argument_count > 0)   _sprite = argument[0];
    if(argument_count > 1)  _image = argument[1];
    var _type = sprite_get_speed_type(sprite_index);
    var _spd = sprite_get_speed(sprite_index)*image_speed;
    if(_type == spritespeed_framespersecond)
        _spd = _spd/room_speed;
    if(argument_count > 2) _spd = argument[2];
    return _image + _spd >= sprite_get_number(_sprite);
}	
	

// creating a best method to equip\unequip weapon
//In this case, a for repetition is coded to run the Array of guns
//to verifiy which weapon the player is colliding, and then set the wapon name and wapon active

for (var _i = 0 ; _i < array_length(actual_weapon); _i++){

	if place_meeting(x, y, actual_weapon[_i]){
	
		if _equip_weapon && !weapon_active {
			weapon_active = true;
			global.weapon_name = actual_weapon[_i];
		}
	
	}
	
	if _mb_attack {
	
		actual_weapon[_i].bullet--;
	
	}

}

show_debug_message(global.weapon_name)