extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	StandAlone.PlayerScore +=  1 #adds one to the PlayerScore everytime the level is complete
	$VBoxContainer/HBoxContainer/Number.text = str(StandAlone.PlayerScore)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#starts the level 
func _on_start_button_pressed():
	StandAlone.LevelReset() #Resets some values and begins the level anew
	get_tree().change_scene_to_file("res://Codes and Screens/MainGame.tscn") #Swtiches to the main game screen
	
