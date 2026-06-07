extends Control

@export var ROT_SPEED = 0.

@onready var book_mesh:MeshInstance3D = $SubViewportContainer/SubViewport/Node3D/Book

func _ready():
	disable()

func disable():
	hide()

func zoom_on_book(ident:String):
	book_mesh.rotation = Vector3.ZERO
	book_mesh.mesh.material.albedo_color = BookRef.get_color(ident)
	show()
	
func _process(delta):
	if visible:
		if Input.is_action_pressed("ui_left"):
			book_mesh.rotate(Vector3(0, 1, 0), -ROT_SPEED * delta)
		elif Input.is_action_pressed("ui_right"):
			book_mesh.rotate(Vector3(0, 1, 0), ROT_SPEED * delta)
		elif Input.is_action_pressed("ui_up"):
			book_mesh.rotate(Vector3(1, 0, 0), -ROT_SPEED * delta)
		elif Input.is_action_pressed("ui_down"):
			book_mesh.rotate(Vector3(1, 0, 0), ROT_SPEED * delta)
