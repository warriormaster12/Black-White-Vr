extends Area3D

@export var audio_sample:AudioStream

signal speak_to_manager(karen:AudioStream)

@onready var collision:CollisionShape3D = get_child(0)


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(on_body_entered)
	area_entered.connect(on_area_entered)
	
func on_body_entered(body):
	pass
	
func on_area_entered(area):
	print(area.get_owner().name)
	if area.get_owner().name == "VRPlayer":
		emit_signal(speak_to_manager.get_name(),audio_sample)
		if collision != null: 
			collision.disabled = true
		
		
