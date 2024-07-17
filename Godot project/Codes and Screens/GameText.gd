extends Label
func _ready():
	Events.EventTrigger.connect(EventTriggered)
	
func EventTriggered(event,info):
	if event == "default": #changes text to default message
		$".".text = "Left click to reveal tile
Right click to flag tile" 
	if event == "boom": #changes text to boom message
		$".".text = "Mine uncovered!
		Brace yourselves!"
	if event == "placing":
		$".".text = "Left click to place " + info +"
		Right click to rotate"
