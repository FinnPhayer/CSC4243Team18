extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sprite = $Sprite
var dragging = false
var mouseOn = false
export var color = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mouse_clicked") and mouseOn and get_parent().get_parent().get_parent().solved == false:
			dragging = true
			get_parent().get_parent().get_parent().movingBook = true
	if dragging:
		if Input.is_action_just_released("mouse_clicked"):
			dragging = false
			get_parent().get_parent().get_parent().movingBook = false
			get_parent().get_parent().get_parent().place_book(self, get_parent())


func _on_ClickableArea_mouse_entered():
	mouseOn = true


func _on_ClickableArea_mouse_exited():
	mouseOn = false
