/// @description play music if music not playing

if (!audio_is_playing(levelMusic)) //if the level's music isn't playing
//this is to avoid it from playing the same audio over and over again
//which will be bad for your ears but also will cause lag
{
	audio_play_sound(levelMusic,10,true);
	//play the sound with a priority of 10 and make it loop
}
