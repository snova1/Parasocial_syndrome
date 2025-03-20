extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var initial: Node2D = $"."
@onready var silla: RigidBody2D = $interactuables/Silla

@onready var jugador: Jugador = $Jugador
@onready var cutting_free: AudioStreamPlayer2D = $CuttingFree
@onready var fader: ColorRect = $Fader

@onready var interactuables: Node = $interactuables
@onready var keypad: Control = $Node2D/keypad

var key = preload("res://keypad.tscn")

signal cutscene_finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	silla.visible=false
	silla.get_node("CollisionShape2D").disabled = true
	Status.player_free.connect(_on_player_free)
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
	
func _on_keypad():
	if !(keypad.visible):
		keypad.visible = true
	else:
		keypad.visible = false
	
	
