extends KinematicBody2D


export var speed = 500
export var health = 10
export var mana = 3
export var damage = 5
var player_class = "archer"
var velocity = Vector2()
var cooldown_attack = 0
var cd_atk_default = 7

#signals
signal change_hp_mp

#preload
var obj_arrow = preload("res://objects/Arrow.tscn")

func _ready():
	update_hp_mp()
	add_to_group("Player")

func _process(delta):
	get_input(delta)
	move_player(delta)
	if cooldown_attack > 0:
		cooldown_attack -= 1
	
func get_input(delta):
	velocity = Vector2()
	if Input.is_action_pressed("walk_right"):
		velocity.x += speed 
	if Input.is_action_pressed("walk_left"):
		velocity.x -= speed
	if Input.is_action_pressed("walk_up"):
		velocity.y -= speed
	if Input.is_action_pressed("walk_down"):
		velocity.y += speed
	
	if Input.is_action_just_pressed("attack"):
		attack()
		
func move_player(delta):
	if velocity.length() > 0:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
	move_and_slide(velocity, Vector2.UP)
	
func attack():
	if player_class == "archer":
		if cooldown_attack == 0:
			var current_arrow = obj_arrow.instance()
			current_arrow.position = position + $WeaponPoint.position
			get_owner().add_child(current_arrow)
			current_arrow.damage = damage
			cooldown_attack = cd_atk_default
		

func take_damage(damage: int):
	health -= damage
	update_hp_mp()
	if health <= 0:
		die()
	else:
		$HitParticles.emitting = true
		$Tween.interpolate_property(self, "position", position, Vector2(position.x-damage*10, position.y), 0.03)
		$Tween.start()


func update_hp_mp():
	emit_signal("change_hp_mp", health, mana)


func die():
	print("you died")


func _on_Hitbox_area_entered(area):
	if area.is_in_group("evil") and area.is_in_group("projectiles"):
		take_damage(area.damage)
		area.queue_free()
