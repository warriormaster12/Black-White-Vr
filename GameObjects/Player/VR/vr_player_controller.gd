extends XROrigin3D

@onready var controllerLeft:XRController3D = $LeftHand
@onready var controllerRight:XRController3D = $RightHand

var lastInteractedObject:Interactable3D = null
var interacting:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$RightHand/FunctionTeleport.visible = true
	$LeftHand/FunctionTeleport.visible = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if controllerRight.get_is_active():
		if controllerRight.is_button_pressed("primary_click"):
			if lastInteractedObject != null:
				lastInteractedObject._interact_vr(controllerRight)
				interacting = true
		else: 
			if lastInteractedObject != null:
				lastInteractedObject._interact_vr(null)
				interacting = false
		if controllerLeft.get_is_active():
			if controllerLeft.is_button_pressed("primary_click"):
				if lastInteractedObject != null:
					lastInteractedObject._interact_vr(controllerLeft)
					interacting = true
			else: 
				if lastInteractedObject != null:
					lastInteractedObject._interact_vr(null)
					interacting = false




func _on_left_area_3d_body_entered(body):
	if body.is_in_group("interactable"):
		lastInteractedObject = body


func _on_right_area_3d_body_entered(body):
	if body.is_in_group("interactable"):
		lastInteractedObject = body




func _on_right_area_3d_body_exited(body):
	if body.is_in_group("interactable"):
		if !interacting:
			lastInteractedObject = null


func _on_left_area_3d_body_exited(body):
	if body.is_in_group("interactable"):
		if !interacting:
			lastInteractedObject = null
