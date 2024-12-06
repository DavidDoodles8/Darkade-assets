/// @description Insert description here
// Player Input
key_left = keyboard_check(vk_left) ;
key_right = keyboard_check(vk_right) ;
key_jump = keyboard_check_pressed(vk_space) ;

// Calculate movement
var move = key_right - key_left; 

hsp = move * walksp;

//Horizontal Collision
if (place_meeting (x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign (hsp);
	}
	hsp = 0;
}
	

x = x + hsp;

//Vertical Collision
if (place_meeting (x,y+hsp,oWall))
{
	while (!place_meeting(x,y+hsp,oWall))
	{
		x = x + sign (hsp);
	}
	hsp = 0;
}
	

x = x + hsp;