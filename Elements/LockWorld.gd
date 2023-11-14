extends Node2D

var mouseOn = false
export var correctCombo = [4, 3, 7, 9, 1]
var currentOrder = [3,8,3,6,5]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	for i in range(5):
#		var randomNumber = randi() % 9 + 1
#		currentOrder.append(randomNumber)


func _process(delta):
	# Check for mouse button press
	if Input.is_action_just_pressed("mouse_clicked") and mouseOn and !IManager.interacting:
		IManager.show_lock(currentOrder, correctCombo, self)


func _on_ClickableArea_mouse_entered():
	mouseOn = true


func _on_ClickableArea_mouse_exited():
	mouseOn = false
