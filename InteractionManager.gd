extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var interacting = false
var lockScene = preload("res://Elements/LockUsing.tscn")
var chestScene = preload("res://Elements/Chest.tscn")
var bookshelfScene = preload("res://Elements/BookshelfUsing.tscn")
var noteUsingScene = preload("res://Elements/NoteUsing.tscn")
var noteWorldScene = preload("res://Elements/NoteWorld.tscn")
var doorScene = preload("res://Elements/DoorWorld.tscn")
var currentlyShowing = null
onready var closeButton = $CanvasLayer/CloseButton
onready var rightTween = $RotateRight/Tween
onready var leftTween = $RotateLeft/Tween
var mouseOnRight = false
var mouseOnLeft = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$RotateRight/AnimatedSprite.hide()
	$RotateLeft/AnimatedSprite.hide()
	$RotateRight/AnimatedSprite.scale = Vector2.ZERO
	$RotateLeft/AnimatedSprite.scale = Vector2.ZERO
	rightTween.interpolate_property($RotateRight/AnimatedSprite, "scale", Vector2.ZERO, Vector2(4,4),.6,Tween.TRANS_ELASTIC)
	leftTween.interpolate_property($RotateLeft/AnimatedSprite, "scale", Vector2.ZERO, Vector2(4,4),.6,Tween.TRANS_ELASTIC)
	closeButton.hide()
	$Sprite.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if interacting:
		$RotateLeft.hide()
		$RotateRight.hide()
		$Sprite.show()
	else:
		$RotateLeft.show()
		$RotateRight.show()
		$Sprite.hide()
	
	if Input.is_action_just_pressed("mouse_clicked") and mouseOnRight and !interacting:
		get_tree().get_root().get_node("World").go_right()
	if Input.is_action_just_pressed("mouse_clicked") and mouseOnLeft and !interacting:
		get_tree().get_root().get_node("World").go_left()
	
func show_lock(currentOrder:Array, correctCombo:Array, worldElement:Node2D):
	closeButton.show()
	interacting = true
	var lock = lockScene.instance()
	lock.worldElement = worldElement
	lock.correctCombo = correctCombo
	lock.currentOrder = currentOrder
	currentlyShowing = lock
	lock.position = get_viewport_rect().get_center()
	add_child(lock)

func lock_solved(lock:Node2D):
	closeButton.hide()
	var note = noteWorldScene.instance()
	note.position = lock.worldElement.position
	lock.worldElement.queue_free()
	lock.queue_free()
	print(get_tree().get_root().get_node("World").get_children())
	get_tree().get_root().get_node("World").rooms[get_tree().get_root().get_node("World").currentRoom].add_child(note)
	interacting = false

func show_note():
	closeButton.show()
	interacting = true
	var note = noteUsingScene.instance()
	currentlyShowing = note
	note.position = get_viewport_rect().get_center()
	add_child(note)

func bookshelf_solved(bookshelf:Node2D):
	closeButton.hide()
	var door = doorScene.instance()
	bookshelf.worldElement.queue_free()
	door.position = bookshelf.worldElement.position
	bookshelf.queue_free()
	add_child(door)
	interacting = false
	
	
	
	


func _on_CloseButton_pressed():
	closeButton.hide()
	interacting = false
	if currentlyShowing != null:
		currentlyShowing.queue_free()
		currentlyShowing = null

func show_shelf(worldElement:Node2D):
	closeButton.show()
	interacting = true
	var bookshelf = bookshelfScene.instance()
	currentlyShowing = bookshelf
	bookshelf.worldElement = worldElement
	bookshelf.position = get_viewport_rect().get_center()
	add_child(bookshelf)


func _on_RotateRight_mouse_entered():
	$RotateRight/AnimatedSprite.show()
	rightTween.start()
	mouseOnRight = true


func _on_RotateRight_mouse_exited():
	$RotateRight/AnimatedSprite.hide()
	rightTween.stop_all()
	rightTween.remove_all()
	rightTween.interpolate_property($RotateRight/AnimatedSprite, "scale", Vector2.ZERO, Vector2(4,4),.6,Tween.TRANS_ELASTIC)
	mouseOnRight = false


func _on_RotateLeft_mouse_entered():
	$RotateLeft/AnimatedSprite.show()
	leftTween.start()
	mouseOnLeft = true


func _on_RotateLeft_mouse_exited():
	$RotateLeft/AnimatedSprite.hide()
	leftTween.stop_all()
	leftTween.remove_all()
	leftTween.interpolate_property($RotateLeft/AnimatedSprite, "scale", Vector2.ZERO, Vector2(4,4),.6,Tween.TRANS_ELASTIC)
	mouseOnLeft = false
