 /// @description updating the step event
// Player Input
//to alter the keys in here, just go into the folder "Input"m then "00 Configuration" and change input_config_verbs

key_left = input_check("left"); //la tecla que usas y su funcion
key_right = input_check("right");
key_jump = input_check_pressed("jump");


// Calculate movement
var move = key_right - key_left; //direction to move towards
 
hsp = lerp(hsp,move * walksp,.3); //make the horizontal speed transition towards the walk speed

if (ON_FLOOR)
{
	jumpBuffer = jumpBufferReset //set the amount of frames that the player has until he can't jump
}
else
{
	jumpBuffer = max (jumpBuffer - 1,0)
	//remove 1 from the jump buffer until it's equal to 0 if the player isn't on the floor
	//this is part of the coyote timing thing
	
	vsp += grv; //apply the gravity to the vertical speed 
}

if (jumpBuffer > 0) and (key_jump)
{
	vsp = jumpSpd; //altura del salto del personaje
	jumpBuffer = 0 //set jump buffer to 
	audio_play_sound(sfx_jump,10,false);
}

#region collisions
	
//horizontal
if (place_meeting(x + hsp,y,obj_Wall)) //if colliding with a wall when applying the horizontal speed
{
	var _isOnSlope = false //setting variables
	var _tol = abs(hsp) + 4 //amount of tolerance so that the player can go up a slope
		
	for (var i = 0; i < _tol; i++) //for each pixel within the tolerance
	{
		if (!place_meeting(x + hsp,y - i,obj_Wall)) //if not colliding with a pixel within the tolerance
		{
			_isOnSlope = true //show that the player is on a slope
			y -= i //make the player go "i" pixels up
			
			//note about this for loop:
			//this for loop checks to see if the player isn't colliding with anything until the value i
			//is either equal to the amount set in tolerance or if the player isn't colliding with a pixel
			//within the tolerance
			
			//if the player isn't colliding with a pixel within the tolerance, make the player go up
			//if the player is colliding with a pixel within the tolerance, don't do anything
			break;
		}
	}
		
	if (!_isOnSlope) //if the player isn't within a slope (set on the for loop above)
	{
		while (abs(hsp) > 0.1) //while their horizontal speed is higher than .1
		{
			hsp *= 0.5 //half it (and give it to the next person)
			if (!place_meeting(x + hsp,y,obj_Wall)) x += hsp //if halfing the speed makes it so that the player isn't touching a wall
			//make add the horizontal speed to the x postion
		}
		hsp = 0 //make the speed 0
	}
}
	
else //if not colliding with a wall when applying the horizontal speed
{
	var _isOnSlope = false //setting variables
	var _tol = abs(hsp) + 4 //setting tolerance
		
	for (var i = 0; i < _tol; i++) //for each pixel within the tolerance
	{
		if (!place_meeting(x + hsp,y + i,obj_Wall)) and (place_meeting(x + hsp,y + (i + 1),obj_Wall)) and (ON_FLOOR)
		//if there's a slope to go down in (and the player is on the floor, this is to avoid him from just breaking shit)
		{
			_isOnSlope = true //set the slope bool to true
			y += i //make the player go down the slope
			break;
		}
	}
}
	
x += hsp //add the horizontal speed
	
//vertical
	
if (place_meeting(x,y + vsp,obj_Wall)) //if adding the vertical speed makes the player collide with a wall
{	
	while (abs(vsp) > 0.1) //while the vertical speed is higher than .1
	{
		vsp *= 0.5 //half it
		if (!place_meeting(x,y + vsp,obj_Wall)) y += vsp //and add it to the y axis
	}
	vsp = 0 //set the vertical speed to 0
}
	
y += vsp //apply the vertical speed
	
#endregion
	

//Animation
if (!ON_FLOOR)
{
	sprite_index = sPlayerR; 
	image_speed = 0; //la velocidad de la imagen, como no queremos que muestre de mas, entonces se pone 0
	if (sign(vsp) > 0) image_index = 1; else image_index = 0;
}
else
{
	image_speed = 1; // el = la mayoria del tiempo es imporante, no se te olvide
	
	if (round(hsp) == 0)  // si se usa el == significa comparacion 
	{
		sprite_index = sPlayer; //si usa el 0 va a estar normal
	}
	else
	{
		sprite_index = sPlayerR; //si no, va a caminar normalmente
	}
}

if (hsp != 0) image_xscale = sign(hsp); //horizontal, si se pone 2 o mas, el sprite va a ser mas ancho y si es menor, el sprite se va a voltear

