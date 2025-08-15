extends CharacterBody3D


const SPEED = 15
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED_RAD = TAU
var current_speed := 0.0
var direction_rad := 0.0
@export var curve : Curve
var curve_in := 0.0

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
		if curve_in > 2:
			curve_in = 2.0
		print((direction + velocity.normalized()).length())
		if (direction + velocity.normalized()).length() < 0.25 :
			curve_in = 0
			velocity = velocity.lerp(Vector3.ZERO, 0.15)
			if velocity.length() < 0.1:
				velocity = Vector3.ZERO
			#velocity.z = sign(velocity.z) * curve.sample(curve_in) * SPEED
		else :
			velocity = velocity.normalized().lerp(direction, 0.15) * curve.sample(curve_in) * SPEED
			curve_in += delta / 5.0
	else:
		if curve_in < 0:
			curve_in = 0.0
		velocity = velocity.normalized().lerp(Vector3.ZERO, 0.15) * curve.sample(curve_in) * SPEED
		#velocity.x = sign(velocity.x) * curve.sample(curve_in) * SPEED
		#velocity.z = sign(velocity.z) * curve.sample(curve_in) * SPEED
		curve_in -= delta
	move_and_slide()
