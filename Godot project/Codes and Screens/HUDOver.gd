extends CanvasLayer
var cutoff = 0
var  passed = false
var username 
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
		
func savefile():
	if username == "":
		$Bottom/error.text = "Please Enter name"
		await get_tree().create_timer(1.0).timeout
		$Bottom/error.text = ""
	else:
		cutoff = StandAlone.scores[4]
		if StandAlone.PlayerScore < cutoff: #won't add player to score file if player score is under the lowest score
			$Bottom/error.text = "Not Saved
	Score lower then 5th highest score"
			await get_tree().create_timer(1.0).timeout
			passed = true 
			pass 
		else:
			passed = true 
			savingfile()
		#Swtiches to the leader board screen
func _on_line_edit_text_submitted(new_text):
	username = new_text #grabs the enter name

func savingfile():
	var config = ConfigFile.new()
	if username in StandAlone.usernames:
		var playernum =StandAlone.usernames.bsearch(username, true) #find where the repeated name exists in config file
		config.set_value(StandAlone.sections[playernum], "score", StandAlone.scores[playernum])
		
	StandAlone.scoresandnames[username] = StandAlone.PlayerScore #puts them into a dictionary
	StandAlone.scores.append (StandAlone.scoresandnames[username])  #puts the scores into an array
	StandAlone.Sortnew() # sorts everything all the scores with the new score
	

	#Assign new top 5 scores
	config.set_value("Player1", "player_name", StandAlone.usernames[0])
	config.set_value("Player1", "score", StandAlone.scores[0])
	config.set_value("Player2", "player_name", StandAlone.usernames[1])
	config.set_value("Player2", "score", StandAlone.scores[1])
	config.set_value("Player3", "player_name", StandAlone.usernames[2])
	config.set_value("Player3", "score", StandAlone.scores[2])
	config.set_value("Player4", "player_name", StandAlone.usernames[3])
	config.set_value("Player4", "score", StandAlone.scores[3])
	config.set_value("Player5", "player_name", StandAlone.usernames[4])
	config.set_value("Player5", "score", StandAlone.scores[4])
	config.save("user://scores.cfg")



