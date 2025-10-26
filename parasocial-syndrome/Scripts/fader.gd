extends CanvasLayer

@onready var rect: ColorRect = $ColorRect
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var canvas: CanvasLayer = $"."

func hidecanvas() ->void:
	canvas.visible=false

func fade_in() -> void:
	canvas.visible=true
	anim.play("fade_in")
	await anim.animation_finished

func fade_out() -> void:
	canvas.visible=true
	anim.play("fade_out")
	await anim.animation_finished
	canvas.visible=false

func flashback() ->void:
	canvas.visible=true
	print(canvas.visible)
	anim.play("flashback")
	await anim.animation_finished
	canvas.visible=false
