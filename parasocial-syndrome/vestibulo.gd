extends "res://Scripts/BaseNivel.gd"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal letter_read

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	Status.letter.connect(_on_show_letter)
	Status.finish_letter.connect(_on_finish_letter)
	Status.end_screen.connect(_on_end_screen)
	Status.resume.connect(_on_resume_gameplay)


func _on_cutscene_trigger_body_entered(body: Node2D) -> void:
	if (body is Jugador) and (!Status.cutscene_played):
		Status.cutscene_played = true
		body.control_enabled = false  
		body.direction = Vector2.ZERO
		body.state = "still"
		body.velocity = Vector2.ZERO
		Input.action_release("arriba")
		Input.action_release("abajo")
		Input.action_release("izquierda")
		Input.action_release("derecha")
		var balloon: Node= Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		await balloon.start(resource,"out_of_basement")
		body.control_enabled = true

func _on_show_letter():
	animation_player.play("show_letter")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	letter_read.emit()

func _on_finish_letter():
	animation_player.play("hide_letter")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	letter_read.emit()

func _on_end_screen():
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	var balloon: Node= Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	await balloon.start(resource,"end_demo")

func _on_resume_gameplay():
	animation_player.play("fade_normal")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
