extends Sprite

func _ready():
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	# Inizializzo il vettore "velocity"
	var velocity = Vector2()
		
	# Aggiorno il vettore velocity in base all'input del giocatore
	if Input.is_key_pressed(KEY_UP):
		velocity.y = -1
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y = 1
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x = -1
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x = 1
	
	# Aggiorno la posizione del nodo Player.
	# La nuova posizione è uguale alla vecchia posizione sommata al vettore di spostamento normalizzato
	self.position += 250*velocity.normalized()*delta