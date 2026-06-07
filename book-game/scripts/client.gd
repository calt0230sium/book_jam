extends Node2D
class_name Client

@onready var demandetext = $DemandeText
@onready var teteclient = $TeteClient

@export var listdemandes : Array[Demande]
@export var client = ""
@export var demande : Demande

func pick_demande(listdemandes) -> void:
	var i = 0
	if len(listdemandes) > 0:
		i = randi() % len(listdemandes)
	demande = listdemandes[i]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_demande(listdemandes)
	demandetext.set("text", demande.get("demande"))
	teteclient.set("client", client)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
