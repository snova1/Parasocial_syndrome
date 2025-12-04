extends CharacterBody2D

class_name Jugador

var is_tied = true # Comienza atada
@onready var tied: Sprite2D = $Tied
@onready var normal: Sprite2D = $Normal
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var finder_interaccion: Area2D = $Int_area/Finder_interaccion
var cardinal_direction: Vector2=Vector2.DOWN
var direction: Vector2=Vector2.ZERO
var move_speed: float
var state: String="still"
var control_enabled := true
var testing =true

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func set_estado_atada():
	if testing:
		is_tied = false
	else:
		is_tied = Status.player_tied

	tied.visible = is_tied
	normal.visible = !is_tied

	move_speed = 50.0 if (is_tied and not testing) else 200.0
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_estado_atada()
	NavegacionManager.on_trigger_player_spawn.connect(_on_spawn)

func _on_spawn(position: Vector2, direction: String):
	global_position=position
	animation_player.play("caminar_"+direction)
	animation_player.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not control_enabled:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	velocity=direction*move_speed
	for i in get_slide_collision_count():
		var c := get_slide_collision(i)
		if c.get_collider() is RigidBody2D and Status.chair_status[1] == "push":
			var push_dir = -c.get_normal()
			var target_velocity = self.velocity.project(push_dir)
			c.get_collider().linear_velocity = 0.5*target_velocity
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

func _unhandled_input(event: InputEvent) -> void:
	if not control_enabled:
		return
	
	if Input.is_action_just_pressed("Interact"):
		state="still"
		direction = Vector2.ZERO
		var actionables=finder_interaccion.get_overlapping_areas()
		if actionables.size()>0:
			actionables.sort_custom(func(a, b): return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position))
			if actionables[0] is not puerta:
				actionables[0].action()
			return
	
	direction.x=Input.get_action_strength("derecha")-Input.get_action_strength("izquierda")
	direction.y=Input.get_action_strength("abajo")-Input.get_action_strength("arriba")
	
	if direction.length() > 0:
		direction = direction.normalized()
		state = "moving"
		cardinal_direction = direction
	else:
		state = "still"
	pass	
