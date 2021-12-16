extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 2
var damage = 0
var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("spin")
	add_to_group("projectiles")
	add_to_group("evil")


func _process(delta):
	position += Vector2(direction.x * speed, direction.y * speed)


func set_direction(pos1: Vector2, pos2: Vector2):
	direction = pos2 - pos1
	direction = direction.normalized()
