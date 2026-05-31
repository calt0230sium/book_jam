extends Node2D

@onready var book = $Book
@onready var hand = $Hand

enum state {BOOK, EMPTY}
var current_state = state.EMPTY
var color:Color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = get_viewport().get_mouse_position()

func free_hand():
	assert(current_state == state.BOOK)
	current_state = state.EMPTY
	book.frame = 0
	hand.frame = 0
	
func take_book(book_ident:String):
	assert(current_state == state.EMPTY)
	current_state = state.BOOK
	book.frame = 1
	hand.frame = 1
	book.modulate = BookRef.get_color(book_ident)
