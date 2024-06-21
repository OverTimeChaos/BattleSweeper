extends Node
var Tile = preload("res://Codes and Screens/Tile.tscn") #preloads the tile scene onto this scene
var tiles 



func _ready(): #Calls when the scene is opened
	
	#Spreads the tiles evenly per 65px from orign
	for r in StandAlone.row: 
		for c in StandAlone.col:
			var t = Tile.instantiate()
			print (Vector2(r,c)*65) 
			t.position = Vector2(r, c)*65
			add_child(t)
	tiles = get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
