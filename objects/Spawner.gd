extends Position2D

var enemy_types = []
var spawning = true
var current_enemy = null

var enemies_alive = 0

func _process(delta):
	if current_enemy == null and spawning:
		if rand_range(-10,10) > 9:
			spawn_enemy()
			
	#print(enemies_alive_sp)
	
	
func spawn_enemy():
	enemies_alive += 1
	current_enemy = enemy_types[randi() % enemy_types.size()].instance()
	get_tree().current_scene.get_node("Enemies").add_child(current_enemy)
	current_enemy.position = global_position
	current_enemy.connect("died", self, "enemy_died")
	get_parent().enemies_alive += 1
	
func enemy_died(enemy):
	#get_parent().increment_kills()
	current_enemy = null
	enemies_alive = 0
	get_parent().enemies_killed += 1
