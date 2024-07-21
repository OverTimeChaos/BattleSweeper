extends CanvasLayer
var fileexists = FileAccess.file_exists("user://scores.cfg")
# Called when the node enters the scene tree for the first time.
func _ready(): 
	if fileexists == false: #if scores.cfg doesn't exist configs defualt file (usuaully on first boot up of the game)
		var config = ConfigFile.new()
		config.set_value("Player1", "player_name", "Player1")
		config.set_value("Player1", "score", 0)
		config.set_value("Player2", "player_name", "Player2")
		config.set_value("Player2", "score", 0)
		config.set_value("Player3", "player_name", "Player3")
		config.set_value("Player3", "score", 0)
		config.set_value("Player4", "player_name", "Player4")
		config.set_value("Player4", "score", 0)
		config.set_value("Player5", "player_name", "Player5")
		config.set_value("Player5", "score", 0)
		config.save("user://scores.cfg")

func _on_quit_button_pressed():
	get_tree().quit() #quits the game
	
#starts the game 
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Codes and Screens/MainGame.tscn") #Swtiches to the main game screen
	StandAlone.BeginGame() #Resets values and begins the game anew


func _on_credits_pressed(): #credits for all the help
	get_tree().change_scene_to_file("res://Codes and Screens/Credits.tscn")
