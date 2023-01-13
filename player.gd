extends Node2D

export var plane_force: float

onready var plane: RigidBody2D = get_node("Plane")
onready var plane_animated: AnimatedSprite = get_node("Plane/PlaneAnimated")
onready var constants: Node = get_node("/root/Constants")

func _ready():
	plane_animated.playing = true

func _input(event: InputEvent):
	if event is InputEventKey and event.scancode == KEY_SPACE:
		plane.apply_impulse(Vector2.UP, Vector2(0, -plane_force))

func _physics_process(delta: float):
	check_collision_bodies()

func check_collision_bodies():
	var bodies: Array = plane.get_colliding_bodies()
	for body in bodies:
		if body.get_name() == constants.FLOOR_NODE or constants.OBSTACLE_NODE in body.get_name():
			lose()

func lose():
	var error: int = get_tree().change_scene("res://scenes/main.tscn")
