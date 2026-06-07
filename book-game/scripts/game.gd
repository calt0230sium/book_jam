extends Node2D

@export var SCROLL_SPEED = 0.

@onready var shelf = $Shelf
@onready var debug = $debug
@onready var cursor = $Cursor
@onready var book_zoom = $BookZoom

@onready var shelf_max_pos = 0.
@onready var shelf_min_pos = - (shelf.get_width() - get_viewport().get_visible_rect().size.x)

var book_in_hand = ""
var is_zooming = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hide the mouse cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func has_book_in_hand():
	return book_in_hand != ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not is_zooming:
		
		# Move the shelf
		var dir = 0.
		if Input.is_action_pressed("ui_left"): dir = 1
		elif Input.is_action_pressed("ui_right"): dir = -1
		var goal_x = shelf.position.x + SCROLL_SPEED * delta * dir
		shelf.position.x = min(shelf_max_pos, max(shelf_min_pos, goal_x))
	
		# Check if zooming
		if Input.is_action_just_pressed("right_click") and has_book_in_hand():
			is_zooming = true
			book_zoom.zoom_on_book(book_in_hand)
			cursor.hide()
		
	elif Input.is_action_just_pressed("right_click"):
		is_zooming = false
		book_zoom.disable()
		cursor.show()


func put_book_in_hand(book_ident:String):
	if has_book_in_hand():
		printerr("Cannot put book in non-empty hand")
	SoundManager.play_sound("tour")
	book_in_hand = book_ident
	debug.text = book_ident
	cursor.take_book(book_ident)

func remove_book_from_hand():
	if not has_book_in_hand():
		printerr("Cannot remove from empty hand")
	book_in_hand = ""
	debug.text = ""
	cursor.free_hand()

func _on_shelf_try_to_place_book(cell):
	if has_book_in_hand():
		# Successfully place the book on the shelf
		var book_ident = book_in_hand
		remove_book_from_hand()
		cell.place_book(book_ident)


func _on_shelf_try_to_take_book(book_ident, cell):
	if not has_book_in_hand():
		put_book_in_hand(book_ident)
		cell.take_book()
