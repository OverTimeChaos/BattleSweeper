extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#quits the game
func _on_quit_button_pressed():
	get_tree().quit()
	
#starts the game 
func _on_start_button_pressed():
	#Hides all nodes in the group "starting elements"
	for node in get_tree().get_nodes_in_group("Starting elements"):
		node.hide()
	$StartButton.hide()
	
