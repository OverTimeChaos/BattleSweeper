extends CanvasLayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #corrects the spirtes of the ship every frame
	$BoxContainer/Front.frame = StandAlone.cruiser[0]
	$BoxContainer/Middle.frame = StandAlone.cruiser[1]
	$BoxContainer/Back.frame = StandAlone.cruiser[2]
func rotate():
	$BoxContainer.rotation = 0
