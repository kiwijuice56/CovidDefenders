extends AudioStreamPlayer

export var hurt: AudioStreamSample

func play_sound(sound: AudioStreamSample):
	stream = sound
	playing = true
