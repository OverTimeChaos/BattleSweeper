extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Bottom/HBoxContainer/Name and Number".text = str(StandAlone.names[0])+ " " + str(StandAlone.scores[0])+ "\n" + str(StandAlone.names[1]) + " "  + str(StandAlone.scores[1])+ "\n" + str(StandAlone.names[2]) + " " + str(StandAlone.scores[2]) + "\n"  + str(StandAlone.names[3])+ " " + str(StandAlone.scores[3])+ "\n" + str(StandAlone.names[4])+ " " + str(StandAlone.scores[4])  
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://Codes and Screens/MainGame.tscn") #Swtiches to the main game screen
	StandAlone.BeginGame() #Resets values and begins the game anew
