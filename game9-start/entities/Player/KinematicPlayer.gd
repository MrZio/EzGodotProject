extends KinematicBody2D

var pokeball_count = 0

signal pokeball_taken

func _ready():
	pass

func _process(delta):
	# Inizializzo il vettore "velocity"
	var velocity = Vector2()
		
	# Aggiorno il vettore velocity in base all'input del giocatore
	if Input.is_key_pressed(KEY_UP):
		velocity.y = -1
		$RayCast2D.cast_to = Vector2(0, -50)
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y = 1
		$RayCast2D.cast_to = Vector2(0, 50)
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x = -1
		$RayCast2D.cast_to = Vector2(-50, 0)
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x = 1
		$RayCast2D.cast_to = Vector2(50, 0)
	
	var movement = 250*velocity.normalized()*delta
	
	self.move_and_collide(movement)
	self.updateAnimatedSprite(velocity)
	
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		
		if collider != null and Input.is_key_pressed(KEY_SPACE) and "Pokeball" in collider.name:
			collider.queue_free()
			pokeball_count += 1
			emit_signal("pokeball_taken",pokeball_count)
	
	if pokeball_count > 0 and $PokeballCooldown.time_left == 0 and Input.is_key_pressed(KEY_E):
		$PokeballCooldown.start()
		pokeball_count -= 1
		#TODO: aggiorna UI
		launch_pokeball()


func updateAnimatedSprite(velocity):
	if velocity.x == -1:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play('walk_left')
	elif velocity.x == 1:
		# specchia la sprite per creare l'animazione di camminata verso destra
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play('walk_left')
	elif velocity.y == -1:
		$AnimatedSprite.play('walk_up')
	elif velocity.y == 1:
		$AnimatedSprite.play('walk_down')
	
	if velocity == Vector2():
		# se il giocatore si stava spostando verso sinistra
		if $AnimatedSprite.animation == 'walk_left':
			$AnimatedSprite.play('stand_left')
		elif $AnimatedSprite.animation == 'walk_up':
			$AnimatedSprite.play('stand_up')
		elif $AnimatedSprite.animation == 'walk_down':
			$AnimatedSprite.play('stand_down')
	
func launch_pokeball():
	var pokeball_scene = load("res://entities/pokeball/pokeball.tscn")
	var pokeball_node = pokeball_scene.instance()
	pokeball_node.position = self.position + $RayCast2D.cast_to.normalized()*32
	pokeball_node.apply_impulse(Vector2(),$RayCast2D.cast_to.normalized()*600)
	pokeball_node.set_angular_velocity(60)
	get_node("/root/Game").add_child(pokeball_node)
	
	
	
