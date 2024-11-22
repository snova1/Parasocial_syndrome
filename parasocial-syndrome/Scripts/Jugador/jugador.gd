class_name Jugador extends CharacterBody2D


var move_speed: float=100.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction:Vector2=Vector2.ZERO
	direction.x=Input.get_action_strength("derecha")-Input.get_action_strength("izquierda")
	direction.y=Input.get_action_strength("abajo")-Input.get_action_strength("arriba")
	
	velocity=direction*move_speed
	
	pass


func _physics_process(delta: float) -> void:
	move_and_slide()
