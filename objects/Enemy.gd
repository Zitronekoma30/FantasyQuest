extends KinematicBody2D


export var health = 10
export var damage = 1

var cooldown = 10

enum ENEMY_STATE{
	IDLE,
	ATTACKING,
}

var state = ENEMY_STATE.IDLE
var player

#signals
signal died


func _ready():
	$AnimationPlayer.play("idle")


func _process(delta):
	if state == ENEMY_STATE.IDLE:
		if cooldown > 0:
			cooldown -= 1
		if cooldown == 0:
			state = ENEMY_STATE.ATTACKING
	if state == ENEMY_STATE.ATTACKING:
		attack()
	player = get_tree().get_nodes_in_group("Player")[0]

func attack():
	pass


func take_damage(damage):
	$CPUParticles2D.emitting = true
	health -= damage
	if health <= 0:
		die()
		pass


func die():
	$AnimationPlayer.play("die")
	emit_signal("died", self)


func _on_HitBox_area_entered(area):
	if area.is_in_group("projectiles") and not area.is_in_group("evil"):
		if "damage" in area:
			take_damage(area.damage)
			area.queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()
