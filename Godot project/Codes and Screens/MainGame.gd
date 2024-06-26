extends Node2D
var Tile = preload("res://Codes and Screens/Tile.tscn") #preloads the tile scene onto this scene
var tiles 

func _ready(): #Calls when the scene is opened
	
	#Spreads the tiles evenly per 65px from left corner of MineSpace rect
	for r in StandAlone.Row: 
		for c in StandAlone.Col:
			var t = Tile.instantiate()
			t.position = Vector2(r, c)*65
			add_child(t)
	tiles = get_children()
	SetMines() #Sets the mines

func SetMines(): #function for setting bombs on random tiles
	var n = 0 # counting varaible
	while n < StandAlone.MineNumber: #Sets mines until the number of bombs are met
		var tile = tiles[randi() % len(tiles)]
		if tile.IsMine == false: #Control structure for making sure mines don't stack/overlap on the same tile
			tile.SetMine() #function called from the preloaded 'Tile' scene in line 3
			n += 1
