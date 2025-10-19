extends RigidBody2D

var friction = 5.0  # Ajusta según la sensación deseada

func _integrate_forces(state):
	# Si no hay una fuerza externa aplicada, reduce la velocidad gradualmente
	if linear_velocity.length() > 0.1:
		linear_velocity = linear_velocity.lerp(Vector2.ZERO, friction * state.get_step())
	else:
		linear_velocity = Vector2.ZERO

@export var safe_area: Rect2 = Rect2(Vector2(410, 190), Vector2(300, 290))
@export var return_force: float = 50.0   


func _physics_process(delta):
	if not safe_area.has_point(global_position):		
		var direction = (safe_area.get_center() - global_position).normalized()		
		apply_central_force(direction * return_force)
