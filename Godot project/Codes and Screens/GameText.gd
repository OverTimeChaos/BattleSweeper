extends Label
func _ready():
	Events.EventTrigger.connect(EventTriggered)
	
func EventTriggered(event,info):
	match event:
		"default": #changes text to default message
			$".".text = "Left click to reveal tile
	Right click to flag tile" 
		"boom": #changes text to boom message
			$".".text = "Mine uncovered!
			Brace yourselves!"
		"placing":
			$".".text = "Left click to place " + info +"
			Right click to rotate"
		"invalid":
			$".".text = "Sorry, Invalid placement of ship
			Please try again"
		"parthit":
			$".".text = "Part of " + info +" has been hit!
			Be more careful!"
		"sunk":
			$".".text = "We lost a ship!" + "\n" + info + " has sunk!"
