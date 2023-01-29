extends KinematicBody2D
signal player_shoot


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var explosion_scene
export var force:float
export var rotation_velocity:float

var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():

	screen_size = get_viewport_rect().size
	pass # Replace with function body.


func _process(delta):

	if Input.is_action_pressed("move_left"):
		rotation_degrees -= rotation_velocity
	if Input.is_action_pressed("move_right"):
		rotation_degrees += rotation_velocity
	if Input.is_action_pressed("move_up"):
		var rotation = rotation_degrees * (PI / 180)
		move_and_slide(Vector2(sin(rotation) * force, -1 * cos(rotation) * force), Vector2(0, 0))
	
	should_show_fire()
	

	if Input.is_action_just_pressed("shoot"):
		shoot()

func should_show_fire() -> void:
	if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right") || Input.is_action_pressed("move_up"):
		$Fire.visible = true
		return
	else:
		$Fire.visible = false
		

func shoot():
	emit_signal("player_shoot")
	
func _on_Area2D_body_entered(body):
	if body.get_groups().has("Asteroid"):
		var explosion = explosion_scene.instance()
		explosion.position = position
		explosion.one_shot = true
		explosion.emitting = true
		get_tree().current_scene.add_child(explosion)
		get_tree().change_scene("res://MainMenu.tscn")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


