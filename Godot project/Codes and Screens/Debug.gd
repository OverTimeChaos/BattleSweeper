extends Node
#debug varaibles
var command = ""
var ListenerOn = false

func _process(delta):
	if Input.is_action_just_pressed("Debug"): 
		if ListenerOn == false: #turns off and on debugger
			ListenerOn = true
			command = "" #clears "command" varibale for debuging
			print ("Debug on")
		else:
			ListenerOn = false
			print ("Debug off")
	if ListenerOn == true:
		if command == "COVER":  #Hides frames when "cover" is entered
			$Mechanics.Debug("cover")
			command = ""  # clears "command" variable so that the same command doesn't play again
			

# Get pressed keys
func _input(event):
	if ListenerOn == true:
		if event is InputEventKey:
			if event.pressed:
				command = command + event.as_text_keycode() #adds the exstince string command ()
