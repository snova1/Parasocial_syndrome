extends CharacterBody2D

@onready var light_occluder_2d = $LightOccluder2D
@onready var nav_agent = $NavigationAgent2D
#@onready var jugador = get_tree().get_root().get_node("Hallway/Jugador")
@onready var animacion = $AnimationPlayer
var move_speed: float = 200.0

#func _process(delta: float):
	#await get_tree().create_timer(1.5).timeout
	## Establecer el destino del antagonista hacia el jugador
	#nav_agent.target_position = jugador.global_position
#
	## Obtener el siguiente punto en la ruta
	#var next_position = nav_agent.get_next_path_position()
	#var direction = (next_position - global_position).normalized()
#
	## Mover y reproducir animaciones
	#velocity = direction * move_speed
	#move_and_slide()
	#_update_animation(direction)

func _update_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):  # Movimiento horizontal
		if direction.x > 0:
			animacion.play("caminar_derecha")
		else:
			animacion.play("caminar_izquierda")
	else:  # Movimiento vertical
		if direction.y > 0:
			animacion.play("caminar_abajo")
		else:
			animacion.play("caminar_arriba")

func _quit_shadow():
	light_occluder_2d.hide()

func _enable_shadow():
	light_occluder_2d.show()

func _stop():
	animacion.stop()

func _see_up():
	animacion.play("caminar_arriba")
	animacion.stop()
	animacion.seek(0, true) # Va al tiempo 0 de la animación

func _walk_right():
	animacion.play("caminar_derecha")

func _walk_left():
	animacion.play("caminar_izquierda")

func _walk_down():
	animacion.play("caminar_abajo")

func _walk_up():
	animacion.play("caminar_arriba")

#func _disable_collision():
	#collision.disabled = true

#func _enable_collision():
	#collision.disabled = false
