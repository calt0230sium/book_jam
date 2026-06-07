extends Control

@export var ROT_SPEED: float
@export var MOVE_DURATION: float

@onready var book:Node3D = $SubViewportContainer/SubViewport/Node3D/Book
@onready var book_target_position = book.position

# Cover elements
@onready var book_front_cover: MeshInstance3D = $SubViewportContainer/SubViewport/Node3D/Book/Covers/FrontCover
@onready var book_back_cover: MeshInstance3D = $SubViewportContainer/SubViewport/Node3D/Book/Covers/BackCover
@onready var book_binding: MeshInstance3D = $SubViewportContainer/SubViewport/Node3D/Book/Covers/Binding


var book_start_position = Vector3(0, -20, 0)
var book_move_trans = Tween.TRANS_QUINT

func _ready():
	hide()

func mesh_instance_set_color(mi:MeshInstance3D, color:Color):
	mi.mesh.material.albedo_color = color

func zoom_on_book(ident:String):
	book.rotation = Vector3.ZERO
	var color = BookRef.get_color(ident)
	mesh_instance_set_color(book_front_cover, color)
	mesh_instance_set_color(book_back_cover, color)
	mesh_instance_set_color(book_binding, color)
	show()
	
	# Make the book rise
	book.position = book_start_position
	book.rotation = Vector3(0, PI/2, 0)
	var move_tween = create_tween()
	move_tween.set_trans(book_move_trans)
	move_tween.set_ease(Tween.EASE_OUT)
	move_tween.tween_property(book, "position", book_target_position, MOVE_DURATION)
	move_tween.tween_property(book, "rotation", Vector3.ZERO, MOVE_DURATION)


func disable():
	
	# Make the book disappear
	book.position = book_target_position
	var move_tween = create_tween()
	move_tween.set_trans(book_move_trans)
	move_tween.set_ease(Tween.EASE_IN)
	move_tween.tween_property(book, "rotation", Vector3(0, PI/2, 0), MOVE_DURATION)
	move_tween.tween_property(book, "position", book_start_position, MOVE_DURATION)
	move_tween.tween_callback(hide)
	
	
func _process(delta):
	if visible:
		if Input.is_action_pressed("ui_left"):
			book.rotate(Vector3(0, 1, 0), -ROT_SPEED * delta)
		elif Input.is_action_pressed("ui_right"):
			book.rotate(Vector3(0, 1, 0), ROT_SPEED * delta)
		elif Input.is_action_pressed("ui_up"):
			book.rotate(Vector3(1, 0, 0), -ROT_SPEED * delta)
		elif Input.is_action_pressed("ui_down"):
			book.rotate(Vector3(1, 0, 0), ROT_SPEED * delta)
