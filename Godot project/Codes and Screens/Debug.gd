extends Node
#debug varaibles
var command = ""
var ListenerOn = false

func _process(delta):
	if Input.is_action_just_pressed("Debug"): 
		if ListenerOn == false: #turns off and on debugger
			ListenerOn = true
			command = "" #clears "command" varibale for debugging
			print ("Debug on")
		else:
			ListenerOn = false
			print ("Debug off")
	if ListenerOn == true:
		if Input.is_action_just_pressed("ClearDebug"):
			command = ""
			print ("Cleared")
		if command == "COVER":  #Hides frames when "cover" is entered
			$Mechanics.Debug("cover")
			command = ""  # clears "command" variable so that the same command doesn't play again
		if command == "LEVEL":
			$Mechanics.Debug("level")
			command = ""
		if command == "GAME":
			$Mechanics.Debug("game")
		if command == "ADD":
			StandAlone.PlayerScore += 100
			print ("Added")
			command = ""

# Get pressed keys
func _input(event):
	if ListenerOn == true: # stops the key listner if debug is toggled off
		if event is InputEventKey:
			if event.pressed:
				command = command + event.as_text_keycode() #adds to the exsitent string "command" 
