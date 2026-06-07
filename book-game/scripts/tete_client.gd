extends AnimatedSprite2D

@export var clienttexture : Dictionary[String, Texture]
@export var client : String 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.sprite_frames.add_frame(animation, clienttexture.get(client), 1, -1)
	self.sprite_frames.set_animation_loop(animation,true)
	self.play(animation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
