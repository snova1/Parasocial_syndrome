extends Node
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
var current_tween: Tween
var music=preload("res://bgm_interactive.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.stream=music

func start_exploration() -> void:
	audio.volume_db = -80
	audio.play()

	var playback = audio.get_stream_playback()
	if playback is AudioStreamPlaybackInteractive:
		playback.switch_to_clip_by_name("Exploración")

	var tween = get_tree().create_tween()
	tween.tween_property(audio, "volume_db", -6, 0.1)

func stop_music() -> void:
	if current_tween:
		current_tween.kill() 
	current_tween = get_tree().create_tween()
	current_tween.tween_property(audio, "volume_db", -80, 2.0)
	current_tween.finished.connect(_on_fade_out_complete)

func _on_fade_out_complete():
	audio.stop()
	audio.volume_db = -6 # Reset for next play
	
func hide_music() -> void:
	audio.volume_db = -80
	audio.play()

	var playback = audio.get_stream_playback()
	if playback is AudioStreamPlaybackInteractive:
		playback.switch_to_clip_by_name("Hide_Now")

	var tween = get_tree().create_tween()
	tween.tween_property(audio, "volume_db", -6, 0.1)
