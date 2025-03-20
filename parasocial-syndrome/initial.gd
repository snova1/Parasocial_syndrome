extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var initial: Node2D = $"."
@onready var silla: RigidBody2D = $Silla
@onready var jugador: Jugador = $Jugador
@onready var cutting_free: AudioStreamPlayer2D = $CuttingFree
@onready var fader: ColorRect = $Fader
const Balloon = preload("res://Dialogue/balloon.tscn")
var resource = load("res://Dialogue/dialogue.dialogue")

@onready var interactuables: Node = $interactuables
@onready var keypad: Control = $Node2D/keypad

var key = preload("res://keypad.tscn")

signal cutscene_finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	silla.visible=false
	silla.get_node("CollisionShape2D").disabled = true
	Status.player_free.connect(_on_player_free)
	Status.demo_end.connect(_on_demo_end)
	Status.end_screen.connect(_on_end_screen)
	Status.keypad.connect(_on_keypad)

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
	fader.visible=false	
	await animation_player.animation_finished
	cutscene_finished.emit()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		fader.visible=true
		animation_player.play("fade_to_black")
		await animation_player.animation_finished
		Status.bookcase_status=""
		Status.door_status="has_key"
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
	await balloon.start(resource,"demo")

func _on_end_screen():
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://end.tscn")
	
func _on_keypad():
	if !(keypad.visible):
		keypad.visible = true
	else:
		keypad.visible = false
