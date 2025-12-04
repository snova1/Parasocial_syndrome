@tool
extends Area2D

enum Direction { DERECHA, IZQUIERDA }

@export var target_scene: PackedScene
@export var target_zone: NodePath
@export var direction: Direction = Direction.DERECHA :
	set(value):
		direction = value

@onready var arrow := $"Direction Out"
var colshape := get_node_or_null("CollisionShape2D")

var prevMsg: String = ""
var newMsg: String = ""

func _ready():
	if Engine.is_editor_hint():
		set_process(true)

func _process(delta):
	if Engine.is_editor_hint():
		# Busca errores
		colshape = get_node_or_null("CollisionShape2D")
		newMsg = ""
		
		if not arrow:
			newMsg = "No hay flecha"
		
		if colshape == null:
			newMsg = "Falta un CollisionShape2D hijo"
		elif (colshape.shape == null) or not (colshape.shape is SegmentShape2D):
			newMsg = "El CollisionShape2D hijo debe ser un segmento 2D"
		
		# Envía un error solo si el mensaje cambia
		if newMsg != "" and newMsg != prevMsg:
			push_error("[Linear Scene Changer] " + newMsg)
			prevMsg = newMsg
		
		# Si no hay errores actualiza la flecha
		if newMsg == "":
			_update_arrow()

func _on_body_entered(body):
	if not (body is Jugador):
		return
	
	colshape = get_node_or_null("CollisionShape2D")
	
	if (colshape == null) or (colshape.shape == null) or not (colshape.shape is SegmentShape2D):
		return
	
	var colseg = colshape.shape as SegmentShape2D
	var a = colshape.to_global(colseg.a)
	var b = colshape.to_global(colseg.b)
	var p = body.global_position

	var ap = p - a
	var ab = b - a

	var t = ab.dot(ap) / ab.length_squared()
	t = clamp(t, 0.0, 1.0)

	print("Posición relativa en el segmento:", t)

func _update_arrow():
	var shape := colshape.shape as SegmentShape2D

	# Puntos en espacio LOCAL del CollisionShape2D
	var a = shape.a
	var b = shape.b

	# Convertir al espacio del SceneChanger
	var a_global = colshape.to_global(a)
	var b_global = colshape.to_global(b)
	var a_local = to_local(a_global)
	var b_local = to_local(b_global)

	# Centro
	var midpoint = (a_local + b_local) / 2
	arrow.position = midpoint

	# Rotación
	var dir_vec = (b_local - a_local).normalized().orthogonal()
	if direction == Direction.IZQUIERDA:
		dir_vec = -dir_vec

	arrow.rotation = dir_vec.angle()
