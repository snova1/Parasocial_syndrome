extends Sprite2D

@export var move_distance_right: float = 80.0
@export var move_distance_down: float = 220.0
@export var move_speed: float = 100.0


enum State { IDLE, MOVING_RIGHT, MOVING_DOWN, WAITING, MOVING_UP, MOVING_LEFT }

var state = State.IDLE
var moved = 0.0



func _process(delta):
	var move_amount = move_speed * delta

	match state:
		State.MOVING_RIGHT:
			moved += move_amount
			if moved >= move_distance_right:
				move_amount -= (moved - move_distance_right)
				moved = 0.0
				state = State.MOVING_DOWN
			position += Vector2.RIGHT * move_amount

		State.MOVING_DOWN:
			moved += move_amount
			if moved >= move_distance_down:
				move_amount -= (moved - move_distance_down)
				moved = 0.0
				state = State.WAITING
			position += Vector2.DOWN * move_amount

		State.MOVING_UP:
			moved += move_amount
			if moved >= move_distance_down:
				move_amount -= (moved - move_distance_down)
				moved = 0.0
				state = State.MOVING_LEFT
			position += Vector2.UP * move_amount

		State.MOVING_LEFT:
			moved += move_amount
			if moved >= move_distance_right:
				move_amount -= (moved - move_distance_right)
				moved = 0.0
				state = State.IDLE
				visible = false
			position += Vector2.LEFT * move_amount

		State.WAITING, State.IDLE:
			pass  # Do nothing

func start_or_retreat():
	match state:
		State.WAITING:
			state = State.MOVING_UP
		State.IDLE:
			visible = true
			state = State.MOVING_RIGHT
		_:
			pass  # Do nothing if already moving
