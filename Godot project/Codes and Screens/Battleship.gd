extends Node2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #corrects the spirtes of the ship every frame
	$BoxContainer/Front.frame = StandAlone.battleship[0]
	$BoxContainer/Middle.frame = StandAlone.battleship[1]
	$BoxContainer/Middle2.frame = StandAlone.battleship[2]
	$BoxContainer/Back.frame = StandAlone.battleship[3]

