extends Node2D

signal try_to_take_book
signal try_to_place_book

@onready var background = $Background
@onready var cells_container = $Cells

func _ready():
	for cell in cells_container.get_children():
		cell.try_to_take.connect(on_try_to_take_book.bind(cell))
		cell.try_to_place.connect(on_try_to_place_book.bind(cell))

func get_width():
	return background.texture.get_size().x * background.scale.x

func on_try_to_take_book(book_ident, cell):
	try_to_take_book.emit(book_ident, cell)
		
func on_try_to_place_book(cell):
	try_to_place_book.emit(cell)
