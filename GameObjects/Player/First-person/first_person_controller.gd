extends CharacterBody3D

@export_category("movement")
@export var walk_speed:float = 10.0

@export_category("settings")
@export var mouse_sens:float = 0.3

@onready var head:Node3D = $Head
@onready var interaction_ray:RayCast3D = $Head/Camera3D/InteractionRay

var interactable_target:Interactable3D = null
var toggle_interaction:bool = false

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	if GameInstance.get("vrInterfaceFound"):
		queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	interaction_ray.add_exception(self)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp($Head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
	if event.is_action_pressed("exit_game"):
		get_tree().quit()
	if event.is_action_pressed("Interact"):
		if toggle_interaction:
			toggle_interaction = false
		else:
			if interaction_ray.is_colliding() and interaction_ray.get_collider().is_in_group("interactable"):
				toggle_interaction = true
				interactable_target = interaction_ray.get_collider()
	
	if event.is_action_pressed("debug"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if interactable_target != null:
		if toggle_interaction:
			interaction_ray.target_position.z = -3.0
			interactable_target._interact(interaction_ray)
			
		else:
			interactable_target._interact()
			interaction_ray.target_position.z = -5.0
			interactable_target = null

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		#hard coded mass
		velocity.y -= gravity * 3.0 * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * walk_speed
		velocity.z = direction.z * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)
		velocity.z = move_toward(velocity.z, 0, walk_speed)

	move_and_slide()
