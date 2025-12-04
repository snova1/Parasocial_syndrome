extends "res://Scripts/Rooms/BaseNivel.gd"

@onready var antagonista: CharacterBody2D = $Antagonista
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal finished

func _ready() -> void:
	super()
	antagonista.visible=false
	antagonista._disable_collision()
	Status.cutscene.connect(_on_cutscene)
	
func _on_cutscene(name: String):
	animation_player.play(name)
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	finished.emit()
