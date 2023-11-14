extends Node2D

var mouseOn = false

func _ready():
	pass


func _process(delta):
	# Check for mouse button press
	if Input.is_action_just_pressed("mouse_clicked") and mouseOn and !IManager.interacting:
		IManager.show_shelf(self)

func _on_ClickableArea_mouse_entered():
	mouseOn = true

func _on_ClickableArea_mouse_exited():
	mouseOn = false
