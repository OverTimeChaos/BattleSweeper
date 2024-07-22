extends Node2D


# Called when the node enters the scene tree for the first time.
func _process(delta): #corrects the spirtes of the ship every frame
	$BoxContainer/Front.frame = StandAlone.destroyer[0]
	$BoxContainer/Back.frame =  StandAlone.destroyer[1]

func rotating():
	$BoxContainer.rotation = 0

