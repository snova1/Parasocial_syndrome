extends RigidBody2D

var friction = 5.0  # Ajusta según la sensación deseada

func _integrate_forces(state):
	# Si no hay una fuerza externa aplicada, reduce la velocidad gradualmente
	if linear_velocity.length() > 0.1:
		linear_velocity = linear_velocity.lerp(Vector2.ZERO, friction * state.get_step())
	else:
		linear_velocity = Vector2.ZERO
