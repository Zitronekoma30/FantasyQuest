extends "res://objects/Enemy.gd"

var obj_arrow = preload("res://objects/Bone.tscn")


func attack():
	shoot()
	cooldown = 100
	state = ENEMY_STATE.IDLE

func shoot():
	var current_arrow = obj_arrow.instance()
	get_tree().current_scene.add_child(current_arrow)
	current_arrow.position = position
	current_arrow.damage = damage
	current_arrow.set_direction(position, player.position)
