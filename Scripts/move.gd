extends State

@export var IdleState : State

const SPEED_MULT := 15
@export var SPEED_CURVE : Curve
var curve_in : float

func enter() -> void :
	curve_in = 0.001
	
func exit() -> void :
	pass
	
func process_physics(delta : float) -> State :
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := ( Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var state = null
	if direction:
		# player is inputting direction
		if curve_in > 2:
			curve_in = 2.0
		if (direction + parent.velocity.normalized()).length() < 0.25 :
			# if player is braking
			parent.velocity = parent.velocity.normalized() * SPEED_CURVE.sample(curve_in) * SPEED_MULT
			curve_in = ( curve_in / (1 + delta * 10) ) - delta * 0.01
		else :
			# if player is inputing a direction
			parent.velocity = parent.velocity.normalized().lerp(direction, 0.15) * SPEED_CURVE.sample(curve_in) * SPEED_MULT
			curve_in += delta / 5.0
	else:
		# if there's no input but player is still moving
		parent.velocity = parent.velocity.normalized() * SPEED_CURVE.sample(curve_in) * SPEED_MULT
		curve_in -= delta
		
	parent.move_and_slide()
	
	if curve_in < 0.001:
		state = IdleState
	return state

func process_input(event : InputEvent) -> State :
	return null

func process_frame(delta : float) -> State :
	return null
