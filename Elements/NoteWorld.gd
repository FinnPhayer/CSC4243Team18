extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = $Tween
var mouseOn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	tween.interpolate_property(self, "scale", Vector2.ZERO, Vector2(4,4),.5,Tween.TRANS_ELASTIC)
	tween.start()


func _process(delta):
	if Input.is_action_just_pressed("mouse_clicked") and mouseOn and !IManager.interacting:
		IManager.show_hintbox()


func _on_ClickableArea_mouse_entered():
	mouseOn = true


func _on_ClickableArea_mouse_exited():
	mouseOn = false
