extends CanvasLayer


func _ready():
	pass


func _on_KinematicPlayer2D_pokeball_taken(pokeball_count):
	print(pokeball_count)
	$TextureRect/Label.text = str(pokeball_count)
