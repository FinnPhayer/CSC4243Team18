extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sprite = $Sprite
onready var transition = $TransitionSprite
var mouseOn = false
var dragging = false
var mousePos

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")
	transition.hide()
	randomize()



func _process(delta):
	if Input.is_action_just_pressed("mouse_clicked") and mouseOn and get_parent().get_parent().solved == false:
		mousePos = get_global_mouse_position()
		dragging = true
	if dragging:
		$AnimationPlayer.play("arrowbounce")
		if Input.is_action_just_released("mouse_clicked"):
			var difference = get_global_mouse_position().y - mousePos.y
			if difference > 10:
				transition.flip_v = false
				sprite.frame = (sprite.frame + 1) % 9
			elif difference < -10:
				transition.flip_v = true
				var temp = sprite.frame
				temp -= 1
				if temp <= -1:
					temp = 8
				sprite.frame = temp
			else:
				pass
			dragging = false
			$AnimationPlayer.play("RESET")
			transition.show()
			transition.play("spin")
			

func shuffle():
	sprite.frame = randi() % 9

func _on_ClickableArea_mouse_entered():
	mouseOn = true

func _on_ClickableArea_mouse_exited():
	mouseOn = false


func _on_TransitionSprite_animation_finished():
	transition.frame = 0
	transition.stop()
	transition.hide()
