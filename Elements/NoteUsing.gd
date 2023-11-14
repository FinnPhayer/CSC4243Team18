extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = $Tween
var mouseOn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2.ZERO
	tween.interpolate_property(self, "scale", Vector2.ZERO, Vector2(2,2),.5,Tween.TRANS_ELASTIC)
	tween.start()
