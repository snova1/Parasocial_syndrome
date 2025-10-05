extends "res://Scripts/Rooms/BaseNivel.gd"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var puerta_o: puerta = $Puertas/Puerta_O
@onready var initial: Node2D = $"."
@onready var silla: RigidBody2D = $Silla
@onready var curtain: Area2D = $curtain
@onready var jugador: Jugador = $Jugador
@onready var cutting_free: AudioStreamPlayer2D = $CuttingFree
@onready var fader: ColorRect = $Fader
@onready var tutorial: Label = $Tutorial
var estado = 0  # 0 = Movimiento, 1 = Interacción

@onready var interactuables: Node = $interactuables
@onready var keypad: Control = $Node2D/keypad

var key = preload("res://Scenes/keypad.tscn")

signal cutscene_finished
signal mural_shown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial.get_node("curtain/Sprite2D").visible=false
	initial.get_node("TextureRect").visible=false
	puerta_o.get_node("CollisionShape2D").disabled =Status.cannot_leave_basement
	silla.visible=false
	silla.get_node("CollisionShape2D").disabled = true
	initial.get_node("colisiones/CollisionShape2D3").disabled=true
	initial.get_node("interactuables/metalbox/CollisionShape2D").disabled=true
	Status.player_free.connect(_on_player_free)
	Status.end_screen.connect(_on_end_screen)
	Status.keypad.connect(_on_keypad)
	Status.curtain_big.connect(_on_curtain_open)
	Status.mural.connect(_on_show_mural)
	Status.enable_navigation.connect(_on_enable_navigation)
	if(Status.cannot_leave_basement):
		tutorial.text="Muévete con las flechas direccionales hacia la mesa"
	else:
		estado=1
	super()
	if (!Status.cannot_leave_basement):
		restaurar_estado_sotano()

func _process(delta):
	if estado==1 and Input.is_action_just_pressed("Interact"):
		tutorial.visible=false

func restaurar_estado_sotano():
	# Silla liberada
	if !Status.player_tied:
		silla.visible = true 
		silla.get_node("CollisionShape2D").disabled = false
		# Posición final si la tienes guardada, opcional
		# silla.global_position = Status.silla_pos

	# Cortina abierta
	if Status.curtain_status == "open":
		$curtain/Sprite2D.visible = true

	# Caja metálica desbloqueada
	if Status.bookcase_status == "":
		initial.get_node("colisiones/CollisionShape2D3").disabled = false
		initial.get_node("colisiones/box_down").visible = true
		initial.get_node("interactuables/metalbox/CollisionShape2D").disabled = false

	# Puerta desbloqueada
	puerta_o.get_node("CollisionShape2D").disabled = Status.cannot_leave_basement == true

	# Interacción con mesa ya hecha
	if !Status.cannot_leave_basement:
		tutorial.visible = false
		estado = 1

func _on_player_free():
	fader.visible=true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	cutting_free.play()
	await cutting_free.finished
	jugador.set_estado_atada()
	silla.visible=true
	silla.get_node("CollisionShape2D").disabled = false
	jugador.set_global_position(jugador.get_global_position()-Vector2(-20,30))
	silla.set_global_position(jugador.get_global_position()+Vector2(20,30))
	animation_player.play("fade_to_normal")	
	await animation_player.animation_finished	
	fader.visible=false	
	cutscene_finished.emit()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		fader.visible=true
		animation_player.play("fade_to_black")
		await animation_player.animation_finished
		initial.get_node("colisiones/CollisionShape2D3").disabled=false
		initial.get_node("colisiones/box_down").visible=true
		initial.get_node("interactuables/metalbox/CollisionShape2D").disabled=false
		Status.bookcase_status=""
		silla.set_global_position(silla.get_global_position()+Vector2(48,190))
		jugador.set_global_position(jugador.get_global_position()+Vector2(20,0))
		await get_tree().create_timer(2.0).timeout
		Status.chair_status[1]=""
		animation_player.play("fade_to_normal")	
		await animation_player.animation_finished
		fader.visible=false

func _on_enable_navigation():
	puerta_o.get_node("CollisionShape2D").disabled = Status.cannot_leave_basement

func _on_end_screen():
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://end.tscn")
	

func _on_curtain_open():
	initial.get_node("curtain/Sprite2D").visible=true
	var sprite = $TextureRect
	sprite.visible=true
	await get_tree().create_timer(1.5).timeout
	sprite.visible=false
	mural_shown.emit()

func _on_show_mural():
	var sprite = $TextureRect
	var label=$TextureRect/Label
	sprite.visible=true
	label.visible=true
	get_tree().paused = true
	await wait_for_escape()
	sprite.visible=false
	label.visible=false

func wait_for_escape():
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("Escape"):
			get_tree().paused = false
			return 

func _on_keypad():
	if !(keypad.visible):
		keypad.visible = true
		keypad.button_focus()
	else:
		keypad.visible = false


func _on_table_body_entered(body: Node2D) -> void:
	if body.name=="Jugador" and estado==0:
		estado=1
		tutorial.text = "Interactúa con la mesa con Z"
