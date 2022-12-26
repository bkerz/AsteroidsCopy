extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var explosion_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	var groups: Array = area.get_groups()
	if 	groups.has("Projectile"):
		var explosion = explosion_scene.instance()
		explosion.position = position
		explosion.one_shot = true
		explosion.emitting = true
		get_tree().current_scene.add_child(explosion)
		queue_free()

	pass # Replace with function body.
	
func _on_Asteroid_body_entered(body):
	var groups: Array = body.get_groups()
	if 	groups.has("Asteroid"):
		var explosion = explosion_scene.instance()
		explosion.position = position
		explosion.one_shot = true
		explosion.emitting = true
		get_tree().current_scene.add_child(explosion)
		queue_free()
	pass # Replace with function body.
