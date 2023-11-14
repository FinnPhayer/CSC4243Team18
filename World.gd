extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var roomScenes = [preload("res://Rooms/Room1.tscn"),
			 preload("res://Rooms/Room2.tscn"),
			 preload("res://Rooms/Room3.tscn")]

var rooms = []
var currentRoom = 0
onready var tween = $Tween
var elements = [preload("res://Elements/LockUsing.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	for room in roomScenes:
		var roomObject = room.instance()
		rooms.append(roomObject)
		add_child(roomObject)
	for room in rooms:
		room.position.y = -1000
	rooms[currentRoom].position.y = 0

func go_right():
	var nextRoom = currentRoom + 1
	if nextRoom >= len(rooms):
		nextRoom = 0
	tween.interpolate_property(rooms[nextRoom], "position", Vector2(640,0),Vector2(0,0),.5,Tween.TRANS_CUBIC)
	tween.interpolate_property(rooms[currentRoom], "position", Vector2(0,0),Vector2(-640,0),.5,Tween.TRANS_CUBIC)
	tween.start()
	currentRoom = nextRoom

func go_left():
	var nextRoom = currentRoom - 1
	if nextRoom < 0:
		nextRoom = len(rooms) - 1
	tween.interpolate_property(rooms[nextRoom], "position", Vector2(-640,0),Vector2(0,0),.5,Tween.TRANS_CUBIC)
	tween.interpolate_property(rooms[currentRoom], "position", Vector2(0,0),Vector2(640,0),.5,Tween.TRANS_CUBIC)
	tween.start()
	currentRoom = nextRoom

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
