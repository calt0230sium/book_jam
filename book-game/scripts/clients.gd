extends Node2D

@onready var demande = $DemandeText
@onready var teteclient = $TeteClient

@export var clients : Array[Client]
@export var currentclient : Client
@export var currentdemande = ""
@export var currentbook : BookRef


func pick_client(clients) -> void:
	var i = 0
	if len(clients) > 0:
		i = randi() % len(clients)
	currentclient = clients[i]
	
func if_receive(book) -> void:
	currentbook = book
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	pick_client(clients)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
