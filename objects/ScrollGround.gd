extends Node


var start_pos
var speed = -0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = $TileMap2.position


func _process(delta):
	$TileMap.position.x += speed
	$TileMap2.position.x += speed
	
func _on_Area2D2_body_entered(body):
	if body.name == "Return":
		$TileMap2.position = start_pos


func _on_Area2D_body_entered(body):
	if body.name == "Return":
		$TileMap.position = start_pos
