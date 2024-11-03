extends Node2D

var p1Score: int = 0
var p2Score: int = 0

var p1Label: Label
var p2Label: Label

func _ready():
	p1Label = $CanvasLayer/Player1Score
	p2Label = $CanvasLayer/Player2Score
	
	p1Label.text = str(p1Score)
	p2Label.text = str(p2Score)

func _on_ball_scored(isPlayer1: bool):
	if isPlayer1:
		p1Score += 1
		p1Label.text = str(p1Score)
	else:
		p2Score += 1
		p2Label.text = str(p2Score)
		
	$Score.play()
		


func _on_ball_is_playing(isPlaying: bool):
	$CanvasLayer/Helper1Text.visible = not isPlaying
	$CanvasLayer/Helper2Text.visible = not isPlaying
	$CanvasLayer/Helper3Text.visible = not isPlaying
