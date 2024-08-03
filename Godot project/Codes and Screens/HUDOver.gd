extends CanvasLayer
var cutoff = 0
var passed = false
var username 
var interacted = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Bottom/HBoxContainer/Number.text = str(StandAlone.PlayerScore)
	StandAlone.openfile() #opens and sorts the file by highest to smallest scores and archivers
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Enter"):
		await savefile() #saves the score of the player
		if passed == true:
			get_tree().change_scene_to_file("res://Codes and Screens/LeaderScreen.tscn") 
		#Swtiches to the leader board screen
func savefile():
	if interacted == true: #prevents players from hiting enter without entering a name by interacting with the box
		if username == "":
			$Bottom/error.text = "Please Enter name"
			await get_tree().create_timer(1.0).timeout
			$Bottom/error.text = ""
		else:
			cutoff = StandAlone.scores[-1]
			if StandAlone.PlayerScore <= cutoff: #won't add player to score file if player score is under the lowest score
				$Bottom/error.text = "Not Saved
		Score lower then or at the 5th highest score"
				await get_tree().create_timer(1.0).timeout
				passed = true 
				pass 
			else:
				await savingfile()
				passed = true 
				
	else:
		$Bottom/error.text = "Please Enter name"
		await get_tree().create_timer(1.0).timeout
		$Bottom/error.text = ""
		
		
func _on_line_edit_text_submitted(new_text):
	username = new_text #grabs the enter name

func savingfile():
	var config = ConfigFile.new()
	var namenumber = 0
	if username in StandAlone.usernames: #if name is existing it will replace the score if applicable
		var playernum =StandAlone.usernames.find(username, 0) #find where the repeated name exists in config file
		if StandAlone.PlayerScore <= StandAlone.scores[playernum]: #doens't change the score if score is lower then returning players pb
			$Bottom/error.text = "Not Saved
		Lower then or at the personal best"
			await get_tree().create_timer(1.0).timeout
			pass
		else:
			for section in StandAlone.sections:
				#assgins returing player score
				if section == StandAlone.sections[playernum]:
					config.set_value(StandAlone.sections[playernum], "player_name", StandAlone.usernames[namenumber])
					config.set_value(StandAlone.sections[playernum], "score", StandAlone.PlayerScore)
					namenumber += 1
					#Assigns other 4 scores
				else:
					config.set_value(section, "player_name", StandAlone.usernames[namenumber])
					config.set_value(section, "score", StandAlone.scores[namenumber])
					namenumber += 1
			config.save("user://scores.cfg")
			
			
	else:
		StandAlone.scoresandnames[username] = StandAlone.PlayerScore #puts them into a dictionary
		StandAlone.scores.append (StandAlone.scoresandnames[username])  #puts the scores into an array
		StandAlone.Sortnew() # sorts everything all the scores with the new score


		#Assign new top 5 scores
		for section in StandAlone.sections:
			config.set_value(section, "player_name", StandAlone.usernames[namenumber])
			config.set_value(section, "score", StandAlone.scores[namenumber])
			namenumber += 1
		config.save("user://scores.cfg") #Saves
	
func _on_line_edit_focus_entered():
	interacted = true
