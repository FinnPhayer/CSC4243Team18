extends Node2D


onready var tween = $Tween
var solved = false
var movingBook = false
var solveTimerStarted = false
var worldElement = null
# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2.ZERO
	tween.interpolate_property(self, "scale", Vector2.ZERO, Vector2(6,6),.4,Tween.TRANS_ELASTIC)
	tween.start()

func clear_mouse_from_shelves():
	for child in $Shelves.get_children():
		child.mouseOn = false

func place_book(bookToMove:Node2D, originalShelf:Node2D):
	for child in $Shelves.get_children():
		if child.mouseOn:
			originalShelf.remove_child(bookToMove)
			child.add_child(bookToMove)
	if check_solved() and solveTimerStarted == false:
		solveTimerStarted = true
		$SolveTimer.start()
		solved = true

func check_solved():
	for child in $Shelves.get_children():
		if !check_one_shelf(child, child.color):
			return false
	return true

func check_one_shelf(shelf, correctColor):
	for child in shelf.get_children():
		if child.get_name().match("Book*"):
			if child.color != correctColor:
				return false
	return true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var comboGuess = []
#	for child in $Digits.get_children():
#		comboGuess.append(child.sprite.frame + 1)
#	if check_combo(comboGuess, correctCombo):
#		solved = true
#	if worldElement != null:
#			worldElement.currentOrder = comboGuess
#	if solved and solvedTimerStarted == false:
#		solvedTimerStarted = true
#		$SolveTimer.start()
#
#func _on_SolveTimer_timeout():
#	IManager.lock_solved(self)
#	solvedTimerStarted = false


func _on_SolveTimer_timeout():
	IManager.bookshelf_solved(self)
	solveTimerStarted = false
