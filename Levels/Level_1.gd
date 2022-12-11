extends Node3D
@export var samples:Array[AudioStream]
signal play_audio(sample:Array[AudioStream])
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("play_audio",samples)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
