extends Node2D
var Tile = preload("res://Codes and Screens/Tile.tscn") #preloads the tile scene onto this scene
#array to set tile map
var tiles= []
#Variables for node info
var noded =""
var postioning = []
# ship info
var rotate = false
var pn = 0
var mouseinside = false 
const placing = "placing"
const default = "default"


#Calls when the scene is opened
func _ready(): 
	Events.NodePosition.connect(Nodepostioned) #connects a signal that reports the nodes position
	#Spreads the tiles evenly per 65px from left corner of MineSpace rect
	for r in StandAlone.Row: 
		for c in StandAlone.Col:
			var t = Tile.instantiate()
			t.position = Vector2(r, c)*65
			add_child(t)
	tiles = get_children()
	StandAlone.ShipPlacement = true
	
func _process(delta):
	if StandAlone.ShipPlacement == true:
		shipPlacer()
		
		
#function for setting bombs on random tiles
func SetMines(): 
	var n = 0 # counting varaible
	while n < StandAlone.MineNumber: #Sets mines until the number of bombs are met
		var tile = tiles[randi() % len(tiles)]
		if tile.IsOccupied == true: #stops mines from placed under ships
			pass
		elif tile.IsMine == false: #Control structure for making sure mines don't stack/overlap on the same tile
			tile.SetMine() #function called from the preloaded 'Tile' scene in line 3
			n += 1
			
			
			
func Nodepostioned(node,postion): #allows the nodes infromation to be passed 
	noded = node
	postioning = postion
	
	
	
# function to hide Covered sprite on tiles
func Debug(type):
	if type == "cover":
		for tile in tiles: #Allows the function to be run on all tiles instances 
			tile.DebugCovered()
	if type == "level":
		get_tree().change_scene_to_file("res://Codes and Screens/CompleteScreen.tscn") #Swtiches to the complete level screen
	if type == "game":
		get_tree().change_scene_to_file("res://Codes and Screens/OverScreen.tscn") 
		
		
		
func shipPlacer(): # allow ships to be placed
	var offsets = []
	var nodes = [] #array of nodes
	if mouseinside == true:
		if pn < 5:
			Events.emit_signal("EventTrigger",placing,StandAlone.ships[pn]) 
			offsets =  StandAlone.shipoffersetter(pn,rotate)
			nodes.append(noded)
			for offset in offsets: 
				for tile in tiles:
					if tile.position  == postioning + offset: 
						nodes.append(tile)
			for node in nodes:
				node.indicated()
			if Input.is_action_just_pressed("LeftClick"):
				pn += 1
				SetMines()
			elif Input.is_action_just_pressed("RightClick"):
				if rotate == false:
					rotate = true
				else:
					rotate = false
		else:
			Events.emit_signal("EventTrigger",default,null)
			StandAlone.ShipPlacement = false
	


func _on_control_mouse_entered():
	mouseinside = true

func _on_control_mouse_exited():
	mouseinside = false
