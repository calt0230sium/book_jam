extends Node2D

@onready var demande = $Demande
@onready var teteclient = $TeteClient

@export var clients = {0: [Image.load_from_file("res://icon.svg"), ["blabla1", "blabla2"]]}
var client = 0

func pick_client(clients) -> int:
	if len(clients) > 0:
		client = randi() % len(clients)
	return client
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	client = pick_client(clients) 
	teteclient.set("texture", clients.get(client)[0])
	demande.set("text", clients.get(client)[1][0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	demande.set("text", clients.get(client)[1].pick_random())
