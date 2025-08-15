extends RigidBody3D

const move_strenght := 600
const MAX_SPEED := 10.0
const deceleration_strength = 900
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized()
	if input_dir:
		apply_force(Vector3(input_dir.x, 0, input_dir.y) * delta * move_strenght)
	else:
		apply_force(Vector3(-signf(linear_velocity.x), 0, -signf(linear_velocity.y)) * delta * deceleration_strength)
	if linear_velocity.length() > MAX_SPEED:
		print("speed lim reached " + str(count))
		count += 1
		linear_velocity /= 1.20
	
