extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var correctCombo = []
onready var tween = $Tween
var solved = false
var currentOrder = []
var worldElement = null
var solvedTimerStarted = false
# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2.ZERO
	tween.interpolate_property(self, "scale", Vector2.ZERO, Vector2(4,4),.4,Tween.TRANS_ELASTIC)
	tween.start()
	var i = 0
	for child in $Digits.get_children():
		child.sprite.frame = currentOrder[i] - 1
		i += 1

func check_combo(guess:Array, answer:Array):
	if len(guess) == len(answer):
		for i in range(len(answer)):
			if guess[i] != answer[i]:
				return false
		return true
	else:
		return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var comboGuess = []
	for child in $Digits.get_children():
		comboGuess.append(child.sprite.frame + 1)
	if check_combo(comboGuess, correctCombo):
		solved = true
	if worldElement != null:
			worldElement.currentOrder = comboGuess
	if solved and solvedTimerStarted == false:
		solvedTimerStarted = true
		$SolveTimer.start()
		
func _on_SolveTimer_timeout():
	IManager.lock_solved(self)
	solvedTimerStarted = false
