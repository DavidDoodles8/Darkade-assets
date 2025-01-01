vsp += grv; //adding 

//Horizontal Collision
if (place_meeting (x+hsp,y,obj_Wall))
{
	while (!place_meeting(x+sign(hsp),y,obj_Wall))
	{
		x += sign(hsp);
	}
	hsp = -hsp;
}
x = x + hsp;

//Vertical Collision
if (place_meeting (x,y+vsp,obj_Wall))
{
	while (!place_meeting(x,y+sign(vsp),obj_Wall))
	{
		y += sign(vsp);
	}
	vsp = 0;
}
y = y + vsp;

//Animation
if (!place_meeting(x,y+1, obj_Wall))
{
	sprite_index = sEnemyR; 
	image_speed = 0; //la velocidad de la imagen, como no queremos que muestre de mas, entonces se pone 0
	if (sign(vsp) > 0) image_index = 1; else image_index = 0;
}
else
{
	image_speed = 1; // el = la mayoria del tiempo es imporante, no se te olvide
	if (hsp == 0)  // si se usa el == significa comparacion 
	{
		sprite_index = sEnemy; //si usa el 0 va a estar normal
	}
	else
	{
		sprite_index = sEnemyR; //si no, va a caminar normalmente
	}
}

if (hsp != 0) image_xscale = sign(hsp); //horizontal, si se pone 2 o mas, el sprite va a ser mas ancho y si es menor, el sprite se va a voltear