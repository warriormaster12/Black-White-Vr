extends RigidBody3D
class_name Interactable3D

var collision:Node3D = null


# Called when the node enters the scene tree for the first time.
func _ready():
	for i_child in get_children():
		if i_child is CollisionShape3D or CollisionPolygon3D:
			collision = i_child


func _interact(target:RayCast3D = null):
	if target:
		freeze = true
		collision.disabled = true
		if target.is_colliding() and not target.get_collider().is_in_group(self.get_groups()[0]):
			global_position = target.get_collision_point() + Vector3(0, 0.45,0)
		else:
			global_position = target.to_global(target.target_position)
		global_rotation.z = target.global_rotation.z
		global_rotation.y = target.global_rotation.y
	else:
		freeze = false
		collision.disabled = false
