extends Node2D

signal try_to_take
signal try_to_place

@onready var texture = $Texture

@export var book_ident = ""
var contains_book = false

func _ready():
	update_from_ident()

func update_from_ident():
	contains_book = book_ident != ""
	texture.visible = contains_book
	if contains_book:
		texture.modulate = BookRef.get_color(book_ident)

func take_book():
	if not contains_book:
		printerr("Cannot take book in empty cell")
		return
	var ident = book_ident
	book_ident = ""
	update_from_ident()
	return ident #unused?

func place_book(ident):
	if contains_book:
		printerr("Cannot place book on non-empty cell")
		return
	book_ident = ident
	update_from_ident()


func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_released("left_click"):
		if contains_book: try_to_take.emit(book_ident)
		else: try_to_place.emit()
