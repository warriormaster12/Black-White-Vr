extends XROrigin3D

@onready var controllerLeft:XRController3D = $LeftHand
@onready var controllerRight:XRController3D = $RightHand

var lastInteractedObject:Interactable3D = null
var interacting:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if !GameInstance.get("vrInterfaceFound"):
		queue_free()
	$RightHand/FunctionTeleport.visible = true
	$LeftHand/FunctionTeleport.visible = true







