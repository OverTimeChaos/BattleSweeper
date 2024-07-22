extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready ():
	StandAlone.BeginGame()
func _process(delta): #corrects the spirtes of the ship every frame
	
	$BoxContainer/Front.frame = StandAlone.carrier[0]
	$BoxContainer/Middle.frame = StandAlone.carrier[1]
	$BoxContainer/Middle2.frame = StandAlone.carrier[2]
	$BoxContainer/Middle3.frame = StandAlone.carrier[3]
	$BoxContainer/Back.frame = StandAlone.carrier[4]
func rotating():
	$BoxContainer.rotation = 0
