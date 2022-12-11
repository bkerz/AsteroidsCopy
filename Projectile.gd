extends Area2D
signal projectile_hit

export var velocity:int = 500

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _process(delta):
	position.y += delta * velocity * cos(deg2rad(rotation_degrees)) * -1
	position.x += delta * velocity * sin(deg2rad(rotation_degrees))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Projectile_body_entered(body):
	var groups:Array = body.get_groups()
	if groups.has("Asteroid"):
		queue_free()
