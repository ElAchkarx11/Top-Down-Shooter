if(instance_exists(obj_player)){
	
	draw_text(obj_camera.x - 500, obj_camera.y - 100, string(obj_player.bullets) + "/" + string(obj_player.remaining_bullets));

}
