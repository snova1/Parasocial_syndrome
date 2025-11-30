extends RigidBody2D

@onready var jugador: Jugador = %Jugador
var friction = 5.0  # Ajusta según la sensación deseada

func _integrate_forces(state):
	# Si no hay una fuerza externa aplicada, reduce la velocidad gradualmente
	if linear_velocity.length() > 0.1:
		linear_velocity = linear_velocity.lerp(Vector2.ZERO, friction * state.get_step())
	else:
		linear_velocity = Vector2.ZERO

var grabbed := false
var offset := Vector2.ZERO

func grab():
	jugador.move_speed *= 0.6
	offset = global_position - jugador.global_position
	grabbed = true
	jugador.forced_direction = jugador.cardinal_direction
	jugador.is_dir_forced = true
	collision_layer = 0

func release():
	jugador.move_speed /= 0.6
	grabbed = false
	jugador.is_dir_forced = false
	collision_layer = 1


func _process(delta):
	if grabbed:
		if Input.is_action_pressed("Interact"):
			global_position = jugador.global_position + offset
		else:
			release()
