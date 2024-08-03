extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Credits".text= "Special Thanks
myle21
Toxic Monster
kukiric
mindfaq
ms_e
The Godot Cafe Discord Community
Sprites
Lowder2
putianyi889
borednordicgod"

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Codes and Screens/TitleScreen.tscn")
