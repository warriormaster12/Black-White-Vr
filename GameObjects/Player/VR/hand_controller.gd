extends XRController3D
@export var impulse_factor:float = 0.13
var interacting:bool = false
var lastInteractedObject:Interactable3D = null

var area:Area3D = null
var velocity:Vector3 = Vector3.ZERO
var last_position:Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Area3D:
			area = child

	if area != null:
		area.body_entered.connect(_body_entered)
		area.body_exited.connect(_body_exited)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_is_active():
		velocity = (global_transform.origin - last_position)/delta
		if is_button_pressed("primary_click"):
			if lastInteractedObject != null:
				lastInteractedObject._interact_vr(self)
				interacting = true
		else:
			if lastInteractedObject != null:
				lastInteractedObject._interact_vr(null)
				if interacting:
					lastInteractedObject.apply_impulse(velocity * impulse_factor, Vector3.ZERO)
				interacting = false
		last_position = global_transform.origin

func _body_entered(body):
	if body.is_in_group("interactable"):
		lastInteractedObject = body

func _body_exited(body):
	if body.is_in_group("interactable"):
		if !interacting:
			lastInteractedObject = null

