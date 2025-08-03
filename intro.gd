extends Node2D

const Balloon = preload("res://Dialogue/balloon.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String="start"
@onready var cutscene_kieran: Sprite2D = $cutsceneKieran

var my_timer

func _ready() -> void:
	Status.kieran_go.connect(intro_go_kieran)
	# Create a new Timer instance
	my_timer = Timer.new()
	# Set its properties
	my_timer.wait_time = 2.0 # 2 seconds
	my_timer.one_shot = true

	# Add the timer to the scene tree. This is important!
	# If you don't add it to the tree, it won't be processed.
	add_child(my_timer)

	# Connect the timeout signal from the code
	my_timer.timeout.connect(do_start_diag)

	# Start the timer
	my_timer.start()


	#  Put your delayed code here

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

	

func do_start_diag():
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource,dialogue_start)
	my_timer.queue_free()
	
func intro_go_kieran():	
	
	cutscene_kieran.start_or_retreat()
