extends Control

var health_texture = preload("res://assets/sprites/objects/Health.png")
var health_sprites = []

var mana_texture = preload("res://assets/sprites/objects/Mana.png")
var mana_sprites = []


func setup_sprites(hp, mana):
	for sprite in health_sprites:
		sprite.queue_free()
	for sprite in mana_sprites:
		sprite.queue_free()
	
	health_sprites = []
	mana_sprites = []
		
	for num in hp:
		var spr = Sprite.new()
		add_child(spr)
		spr.texture = health_texture
		spr.position = Vector2((num+1)*8, 15)
		health_sprites.append(spr)
		
	for num in mana:
		var spr = Sprite.new()
		add_child(spr)
		spr.texture = mana_texture
		spr.position = Vector2((num+1)*8, 30)
		mana_sprites.append(spr)


func _on_Player_change_hp_mp(hp, mp):
	setup_sprites(hp, mp)
