extends CanvasLayer
var cutoff = 0
var  passed = false
var username 
var interacted = false
var namenumber = 0
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
	if interacted == true:
		if username == "":
			$Bottom/error.text = "Please Enter name"
			await get_tree().create_timer(1.0).timeout
			$Bottom/error.text = ""
		else:
			cutoff = StandAlone.scores[-1]
			if StandAlone.PlayerScore < cutoff: #won't add player to score file if player score is under the lowest score
				$Bottom/error.text = "Not Saved
		Score lower then 5th highest score"
				await get_tree().create_timer(1.0).timeout
				passed = true 
				pass 
			else:
				passed = true 
				savingfile()
	else:
		$Bottom/error.text = "Please Enter name"
		await get_tree().create_timer(1.0).timeout
		$Bottom/error.text = ""
		
		
func _on_line_edit_text_submitted(new_text):
	username = new_text #grabs the enter name

func savingfile():
	var config = ConfigFile.new()
	var namenumber = 0
	if username in StandAlone.usernames:
		var playernum =StandAlone.usernames.find(username, 0) #find where the repeated name exists in config file
		config.set_value(StandAlone.sections[playernum], "score", StandAlone.PlayerScore)
		for section in StandAlone.sections:
			if section == StandAlone.sections[playernum]:
				pass
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
		config.save("user://scores.cfg")





	


func _on_line_edit_focus_entered():
	interacted = true
