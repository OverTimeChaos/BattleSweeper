extends Node
#debug varaibles
var command = ""
var ListenerOn = false

func _process(delta):
	if Input.is_action_just_pressed("Debug"): 
		if ListenerOn == false: #turns off and on debugger
			ListenerOn = true
			command = "" #clears "command" varibale for debugging
			$VBoxContainer.show()
		else:
			ListenerOn = false
			$VBoxContainer.hide()
	if ListenerOn == true:
		$VBoxContainer/Command.text = command
		if Input.is_action_just_pressed("ClearDebug"):
			command = ""
			$"VBoxContainer/Debug message".text = "Cleared"
			await get_tree().create_timer(1.0).timeout
			$"VBoxContainer/Debug message".text = ""
		if command == "COVER":  #Hides frames when "cover" is entered
			$Mechanics.Debug("cover")
			command = ""  # clears "command" variable so that the same command doesn't play again
		if command == "LEVEL":
			$Mechanics.Debug("level") #completes the levels
			command = ""
		if command == "GAME": # ends the game no matter what condition the ships are
			$Mechanics.Debug("game")
			command = ""
		if command == "MINE":
			$Mechanics.Debug ("mines") # sets the mines no matter what phase it is
			command = ""
			$"VBoxContainer/Debug message".text = "Mines set"
			await get_tree().create_timer(1.0).timeout
			$"VBoxContainer/Debug message".text = ""
		if command == "ADD": # adds scores
			StandAlone.PlayerScore += 100
			command = ""
			$"VBoxContainer/Debug message".text = "Added"
			await get_tree().create_timer(1.0).timeout
			$"VBoxContainer/Debug message".text = ""
			

# Get pressed keys
func _input(event):
	if ListenerOn == true: # stops the key listner if debug is toggled off
		if event is InputEventKey:
			if event.pressed:
				command = command + event.as_text_keycode() #adds to the exsitent string "command" 
				
