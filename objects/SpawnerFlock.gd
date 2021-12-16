extends Node2D

export (int) var waves_amount = 10
export (int) var enemies_amount = 5
export (Array) var enemy_types
export (PackedScene) var boss_enemy

onready var spawners = get_children()
var wave_done = false
var enemies_killed = 0
var current_wave = 1
var enemies_alive = 0


func _ready():
	for spawner in spawners:
		spawner.enemy_types = enemy_types


func _process(delta):
	enemies_alive = 0
	for spawner in spawners:
		enemies_alive += spawner.enemies_alive
	print(enemies_alive)
	
	if enemies_killed > enemies_amount:
		end_wave()
		if enemies_alive == 0:
			give_reward()
		
		
		
func give_reward():
	print("yay")
	

func end_wave():
	wave_done = true
	for spawner in spawners:
		spawner.spawning = false
		
		
func start_wave():
	current_wave += 1
	enemies_killed = 0
	enemies_alive = 0
	if current_wave > waves_amount:
		print("done with all waves")
	else:
		wave_done = false
		for spawner in spawners:
			spawner.spawning = true
