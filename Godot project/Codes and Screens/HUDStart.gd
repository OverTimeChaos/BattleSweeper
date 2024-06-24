extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_quit_button_pressed():
	get_tree().quit() #quits the game
	
#starts the game 
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Codes and Screens/MainGame.tscn") #Swtiches to the main game screen
	StandAlone.BeginGame() #Resets values and begins the game anew
