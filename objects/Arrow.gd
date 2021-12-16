extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 6
var damage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("projectiles")


func _process(delta):
	position.x += speed

func flip():
	$Sprite.flip_h = true
	speed = -speed
