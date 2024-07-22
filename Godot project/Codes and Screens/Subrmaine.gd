extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #corrects the spirtes of the ship every frame
	$BoxContainer/Front.frame= StandAlone.submarine[0]
	$BoxContainer/Middle.frame= StandAlone.submarine[1]
	$BoxContainer/Back.frame = StandAlone.submarine[2]
	
func rotating():
	$BoxContainer.rotation = 0
