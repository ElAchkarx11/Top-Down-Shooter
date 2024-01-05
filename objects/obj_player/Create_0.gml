//Speed player
my_speed = 8;

weapon_active = false;
global.weapon_name = obj_pistol;
actual_weapon = [obj_pistol, obj_revolver]

//maximum bullets and current bullets
bullets = 5;
remaining_bullets = 5;
combo = false;

_inimigos_atingidos = ds_list_create();


state = PLAYER_STATE.FREE;

enum PLAYER_STATE
{
FREE,
ATTACK

}

