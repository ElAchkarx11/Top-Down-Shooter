if(instance_exists(obj_player)){
	
	draw_text(view_camera[0] + 50, view_camera[0] + 50, string(obj_player.bullets) + "/" + string(obj_player.remaining_bullets));

}
