extends Node
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
var music=preload("res://bgm_interactive.tres")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.stream=music

func start_exploration() -> void:
	audio.play()
