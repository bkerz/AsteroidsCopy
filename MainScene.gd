extends Node2D
export(PackedScene) var projectile_scene
export(PackedScene) var asteroid_scene
export(PackedScene) var dead_popup
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_Player_player_shoot():
	var projectile = projectile_scene.instance()
	projectile.position = $Player.position
	projectile.rotation_degrees = $Player.rotation_degrees
	#var vector = Vector2(sin(deg2rad($Player.rotation_degrees)) * 2100, -1 * cos((deg2rad($Player.rotation_degrees))) * 2100)
	#projectile.linear_velocity = vector
	print("Player: ", $Player.rotation_degrees)
	print("Projectile: ", projectile.rotation_degrees)
	add_child(projectile)
	#pass # Replace with function body.


func _on_Timer_timeout():
	var asteroid = asteroid_scene.instance()
	var asteroid_path = get_node("AsteroidPath/AsteroidPathLocation")
#	var offset_unit = 	floor(asteroid_path.unit_offset * 100.0 % 25)
	asteroid_path.offset = randi()
	var direction = asteroid_path.rotation + PI / 2
	direction += rand_range(-PI / 8, PI / 8)

	asteroid.position = asteroid_path.position
	asteroid.rotation = direction

	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)

	asteroid.linear_velocity = velocity.rotated(direction)

	asteroid.connect("add_point", self, "on_add_point")

	add_child(asteroid)

func on_add_point():
	var new_points := int($Label.text) + 1
	$Label.text = String(new_points)
