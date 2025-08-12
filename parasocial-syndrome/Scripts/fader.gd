extends CanvasLayer

@onready var rect: ColorRect = $ColorRect
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var canvas: CanvasLayer = $"."

func fade_in() -> void:
	canvas.visible=true
	anim.play("fade_in")
	await anim.animation_finished
	canvas.visible=false

func fade_out() -> void:
	canvas.visible=false
	anim.play("fade_out")
	await anim.animation_finished
	canvas.visible=false
