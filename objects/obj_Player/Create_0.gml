 /// @description basic variables
hsp = 0; //velocidad horizontal | horizontal speed
vsp = 0; //velocidad vertical | vertical speed

fric = .3; //friccion del personaje | friction of the character
//cuanto menor sea el número, más resbaladizo será el personaje | the smaller the number, the more slippery the character will be

grv = 0.3; //gravedad del personaje | gravity of the character

walksp = 2; //velocidad del personaje | speed of the character

//jumping variables

jumpSpd = -5 //velocidad de lo salto | vertical speed of the jump
jumpBuffer = 3 //Cantidad de fotogramas que puedes saltar después de abandonar el suelo. | amount of frames you have before you can't jump after leaving the floor
jumpBufferReset = jumpBuffer
