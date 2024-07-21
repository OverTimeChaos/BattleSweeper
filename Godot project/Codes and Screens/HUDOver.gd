extends CanvasLayer
var cutoff = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bottom/HBoxContainer/Number.text = str(StandAlone.PlayerScore)
	StandAlone.openfile() #opens and sorts the file by highest to smallest scores and archivers
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Enter"):
		await savefile() #saves the score of the player
		get_tree().change_scene_to_file("res://Codes and Screens/LeaderScreen.tscn") 
		
func savefile():
			if $Bottom/LineEdit.get_text() == "HUD":
				$Bottom/error.text = "Please Enter name"
				await get_tree().create_timer(1.0).timeout
				$Bottom/error.text = ""
			cutoff = StandAlone.scores[4]
			if StandAlone.PlayerScore < cutoff: #won't add player to score file if player score is under the lowest score
				$Bottom/error.text = "Not Saved
		Score lower then 5th highest score"
				await get_tree().create_timer(1.0).timeout
				pass 
			else:
				savingfile()
		#Swtiches to the leader board screen
func _on_line_edit_text_submitted(new_text):
		name = new_text #grabs the enter name

func savingfile():
	var config = ConfigFile.new()
	if name in StandAlone.names:
		var playernum =StandAlone.names.bsearch(name, true) #find where the repeated name exists in config file
		config.set_value(StandAlone.sections[playernum], "score", StandAlone.scores[playernum])
		
		
	StandAlone.scoresandnames[name] = StandAlone.PlayerScore #puts them into a dictionary
	StandAlone.scores.append (StandAlone.scoresandnames[name])  #puts the scores into an array
	StandAlone.Sortnew() # sorts everything all the scores with the new score
	

	#Assign new top 5 scores
	config.set_value("Player1", "player_name", StandAlone.names[0])
	config.set_value("Player1", "score", StandAlone.scores[0])
	config.set_value("Player2", "player_name", StandAlone.names[1])
	config.set_value("Player2", "score", StandAlone.scores[1])
	config.set_value("Player3", "player_name", StandAlone.names[2])
	config.set_value("Player3", "score", StandAlone.scores[2])
	config.set_value("Player4", "player_name", StandAlone.names[3])
	config.set_value("Player4", "score", StandAlone.scores[3])
	config.set_value("Player5", "player_name", StandAlone.names[4])
	config.set_value("Player5", "score", StandAlone.scores[4])
	config.save("user://scores.cfg")
