extends Node


var audio_queue:Array[AudioStream]

@onready var audio_player:AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for current in audio_queue:
		if !audio_player.playing:
			audio_player.stream = current
			audio_player.play()
			audio_queue.pop_front()


func _on_area_3d_speak_to_manager(karen):
	audio_queue.append(karen)



func _on_level_play_audio(sample):
	for i in sample:
		audio_queue.append(i)
