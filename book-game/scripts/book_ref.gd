extends Node

@export var _book_colors : Dictionary[String, Color]

func check_legal(ident:String):
	if not _book_colors.has(ident):
		printerr("Illegal book identifier " + ident)

func get_color(ident):
	check_legal(ident)
	return _book_colors[ident]
