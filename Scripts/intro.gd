extends Node2D

const Balloon = preload("res://Dialogue/balloon.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String="start"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var antagonista: CharacterBody2D = $Antagonista
@onready var fader: ColorRect = $Fader

signal finished

var my_timer

func _ready() -> void:
	antagonista.visible=false
	fader.visible=true
	Status.cutscene.connect(_on_cutscene)
	do_start_diag()

func do_start_diag():
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource,dialogue_start)

func _on_cutscene(name: String):
	animation_player.play(name)
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	finished.emit()
