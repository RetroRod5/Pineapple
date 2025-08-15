extends CharacterBody3D

var current_direction : Vector3 = Vector3(0.0, 0.0, 0.0)
var current_speed := 0.0
const MAX_SPEED := 10
const JUMP_VELOCITY := 4.5

func _ready() -> void:
	Performance.add_custom_monitor("char vars", get_speed)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if current_speed < MAX_SPEED:
			current_speed += 0.2
			
		velocity.x = current_direction.x * current_speed
		velocity.z = current_direction.z * current_speed
		
		if !direction.is_equal_approx(current_direction) :
			current_direction.x = direction.x + (current_direction.x - direction.x) / 2
			current_direction.z = direction.z + (current_direction.z - direction.z) / 2
		
	else:
		if current_speed > 0:
			current_speed -= 0.2
	velocity.x = current_direction.x * current_speed
	velocity.z = current_direction.z * current_speed
	move_and_slide()
	
func get_speed() -> float:
	return current_speed
