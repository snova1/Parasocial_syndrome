class_name Jugador extends CharacterBody2D

var cardinal_direction: Vector2=Vector2.DOWN
var direction: Vector2=Vector2.ZERO
var move_speed: float=100.0
var state: String="still"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction.x=Input.get_action_strength("derecha")-Input.get_action_strength("izquierda")
	direction.y=Input.get_action_strength("abajo")-Input.get_action_strength("arriba")
	
	if direction.length() > 0:
		direction = direction.normalized()
		state = "moving"
		cardinal_direction = direction
	else:
		state = "still"
	pass


func _physics_process(delta: float) -> void:
	velocity=direction*move_speed
	move_and_slide()
	
	if state == "moving":
		if cardinal_direction.y > 0:
			animation_player.play("caminar_abajo")
		elif cardinal_direction.y < 0:
			animation_player.play("caminar_arriba")
		elif cardinal_direction.x > 0:
			animation_player.play("caminar_derecha")
		elif cardinal_direction.x < 0:
			animation_player.play("caminar_izquierda")
	elif state == "still":
		animation_player.stop()
