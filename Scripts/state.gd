class_name State
extends Node

# @export var animation_name: String

var parent: CharacterBody3D

var GRAVITY : float = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter() -> void:
	#TODO
	# if animation_name != null:
		# parent.animation.play(animation_name)
	pass

func exit() -> void:
	pass
	
func process_input(event: InputEvent) -> State:
		return null

func process_frame(delta: float) -> State:
		return null

func process_physics(delta: float) -> State:
	return null
