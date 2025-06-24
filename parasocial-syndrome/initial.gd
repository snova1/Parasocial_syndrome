extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var initial: Node2D = $"."
@onready var silla: RigidBody2D = $Silla
@onready var curtain: Area2D = $curtain
@onready var jugador: Jugador = $Jugador
@onready var cutting_free: AudioStreamPlayer2D = $CuttingFree
@onready var fader: ColorRect = $Fader
@onready var tutorial: Label = $Tutorial
var estado = 0  # 0 = Movimiento, 1 = Interacción

const Balloon = preload("res://Dialogue/balloon.tscn")
var resource = load("res://Dialogue/cutscenes.dialogue")

@onready var interactuables: Node = $interactuables
@onready var keypad: Control = $Node2D/keypad

var key = preload("res://keypad.tscn")

signal cutscene_finished
signal mural_shown
signal show_hint
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial.get_node("curtain/Sprite2D").visible=false
	initial.get_node("TextureRect").visible=false
	silla.visible=false
	silla.get_node("CollisionShape2D").disabled = true
	initial.get_node("colisiones/CollisionShape2D3").disabled=true
	initial.get_node("interactuables/metalbox/CollisionShape2D").disabled=true
	Status.player_free.connect(_on_player_free)
	Status.demo_end.connect(_on_demo_end)
	Status.end_screen.connect(_on_end_screen)
	Status.keypad.connect(_on_keypad)
	Status.curtain_big.connect(_on_curtain_open)
	Status.mural.connect(_on_show_mural)
	tutorial.text="Muévete con las teclas de dirección hacia la mesa"

func _process(delta):
	if estado==1 and Input.is_action_just_pressed("Interact"):
		tutorial.visible=false

func _on_player_free(atada: bool):
	fader.visible=true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	cutting_free.play()
	await cutting_free.finished
	jugador.set_estado_atada(atada)
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

func _on_demo_end():
	fader.visible=true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	var balloon: Node= Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	await balloon.start(resource,"out_of_basement")

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
	show_hint.emit()

func wait_for_escape():
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("Escape"):
			get_tree().paused = false
			return 

func _on_keypad():
	if !(keypad.visible):
		keypad.visible = true
	else:
		keypad.visible = false


func _on_table_body_entered(body: Node2D) -> void:
	if body.name=="Jugador":
		estado=1
		tutorial.text = "Interactúa con la mesa con Z"
