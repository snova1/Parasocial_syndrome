class_name Jugador extends CharacterBody2D

var is_tied = true # Comienza atada
@onready var tied: Sprite2D = $Tied
@onready var normal: Sprite2D = $Normal
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var finder_interaccion: Area2D = $Int_area/Finder_interaccion
var cardinal_direction: Vector2=Vector2.DOWN
var direction: Vector2=Vector2.ZERO
var move_speed: float
var state: String="still"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func set_estado_atada(atada: bool):
	is_tied=atada
	tied.visible = is_tied
	normal.visible = !is_tied
	if is_tied:
		move_speed=50.0
	else:
		move_speed=200.0
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_estado_atada(is_tied)
	Status.player_free.connect(_on_player_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.


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

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact"):
		var actionables=finder_interaccion.get_overlapping_areas()
		if actionables.size()>0:
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

func _on_player_free(atada: bool):
	set_estado_atada(atada)
