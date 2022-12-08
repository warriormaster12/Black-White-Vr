extends Node


var roskia_tasossa = 1
var roskia_koreissa = 0
var pisteet_per_roska = (100/roskia_tasossa)
var hyvyys = 0
var pahuus = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	roskia_tasossa = 0
	for child in get_tree().current_scene.get_children():
		if child.is_class("RigidBody3D"):
			roskia_tasossa+=1
	print(roskia_tasossa)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_roskis_good_roska_entered(name, count):
	roskia_koreissa += 1
	if name == "RoskisGood":
		hyvyys += pisteet_per_roska
	elif name == "RoskisBad":
		pahuus += pisteet_per_roska
	if roskia_koreissa == roskia_tasossa:
		pass
		

func _on_roskis_good_roska_exited(name, count):
	roskia_koreissa-=1
	if name == "RoskisGood":
		hyvyys -= pisteet_per_roska
	elif name == "RoskisBad":
		pahuus -= pisteet_per_roska


