extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var color = 1
var mouseOn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Shelf_mouse_entered():
	if get_parent().get_parent().get_name() == "BookshelfUsing":
		if get_parent().get_parent().movingBook:
			get_parent().get_parent().clear_mouse_from_shelves()
			mouseOn = true

func _on_Shelf_mouse_exited():
	mouseOn = false
