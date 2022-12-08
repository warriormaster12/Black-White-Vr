extends Area3D

signal roska_entered(name:String, count:int)
signal roska_exited(name:String, count:int)
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(roska_entered_roskakori)
	body_exited.connect(roska_exited_roskakori)

var roskia_yht = 0

func roska_entered_roskakori(body):
	if body.is_class("RigidBody3D"):
		roskia_yht+=1
		emit_signal("roska_entered",self.name, roskia_yht)

func roska_exited_roskakori(body):
	if body.is_class("RigidBody3D"):
		roskia_yht-=1
		emit_signal("roska_exited",self.name, roskia_yht)
		
