extends TileMapLayer

var astar_grid = AStarGrid2D.new()
const layer = 0
const source = 0
@onready var jugador: CharacterBody2D = get_tree().get_root().get_node("Initial/Jugador")
@onready var kieran: CharacterBody2D = %kieran

var target_pos: Vector2i
var initial_pos = Vector2i(0,-40)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_pos = Vector2i(jugador.global_position/16)
	astar_grid.region = Rect2i(0,-40,31,31)
	astar_grid.cell_size = Vector2i(16,16)
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	for cell in get_used_cells():
		if astar_grid.is_in_boundsv(cell):
			astar_grid.set_point_solid(cell, _is_wall(cell))
	_show_path()
	pass # Replace with function body.

func _show_path():	
	var path_taken
	while true:
		target_pos = Vector2i(jugador.global_position/16)		
		path_taken = astar_grid.get_id_path(initial_pos, target_pos)
		for cell in path_taken: # este hace que las celdas cambien de color
			kieran.global_position = cell*16
			#set_cell(cell, source, Vector2i(randf_range(0,19),0)) # este hace que las celdas cambien de color
			await get_tree().create_timer(.2).timeout
		initial_pos = target_pos

func _is_wall(cell: Vector2i) -> bool:
	return get_cell_tile_data(cell).get_custom_data("Wall")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
