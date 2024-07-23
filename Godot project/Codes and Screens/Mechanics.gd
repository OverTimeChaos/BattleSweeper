extends Node2D
var Tile = preload("res://Codes and Screens/Tile.tscn") #preloads the tile scene onto this scene
#array to set tile map
var tiles= []
#Variables for node info
var noded =""
var postioning =[0,0] #Dummary value to avoid errors
var nodes = [] #array of nodes
# ship info
var Partsalive = 0
var occupied  = 0
var hovered = false
var rotating = false
var shipnumber = 0 # which ship is currently being selected (Carrier,Battleship,Cruiser,Submarine,Destroyer) in order
var tilenumber = 0
var mouseinside = false 
const placing = "placing"
const default = "default"
const invalid = "invalid"


#Calls when the scene is opened
func _ready(): 
	Input.warp_mouse(Vector2(361,434))
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
	if StandAlone.ShipPlacement == true and StandAlone.interact == true:
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
	
func shipPlacer(): # allow ships to be places
	for node in nodes:
		node.indicated(false) #defualt sets spirtes to not indicated 
	var offsets = []
	var occupiedchecking = [] # checks for if the occupied value is on a tile
	nodes = [] #array of nodes
	if shipnumber < 5 and StandAlone.arrayShips[shipnumber].count(1) > 0 :
		Events.emit_signal("EventTrigger",placing,StandAlone.ships[shipnumber]) 
		offsets =  StandAlone.shipoffersetter(shipnumber,rotating) #grabs offsets
		for offset in offsets: #highlights the nodes
			for tile in tiles:
				if tile.position  == postioning + offset: 
					nodes.append(tile)
		nodes.insert((len(nodes)+1)/2,noded)
		for node in nodes:
			node.indicated(true)
		if Input.is_action_just_pressed("LeftClick"): #places the ship
			
			for node in nodes:
				occupiedchecking.append(node.IsOccupied)
			
			occupied = occupiedchecking.count(true)
			if occupied == 0 and  len(occupiedchecking)== len(StandAlone.arrayShips[shipnumber]): #prevents invalid placements
				tilenumber = 0
				noded.tilespriter(shipnumber,rotating)
				
				if noded.turn == 1:
					nodes.reverse ()
				for node in nodes:
					node.turn = noded.turn
					node.IsOccupied = true
					node.shipNumber = shipnumber
					node.partNumber = tilenumber
					tilenumber += 1
				move_child(noded,-1)
				shipnumber += 1
			else:
				Events.emit_signal("EventTrigger",invalid,null) 
				StandAlone.interact =  false
				await get_tree().create_timer(1.0).timeout # allows the player to process the message
				StandAlone.interact =  true
				Events.emit_signal("EventTrigger",default,null)
			
		elif Input.is_action_just_pressed("RightClick"): #rotates the ship
			if rotating == false:
				rotating = true
			else:
				rotating = false
			
	elif shipnumber == 5: # sets the mines
		Events.emit_signal("EventTrigger",default,null)
		SetMines() #sets mines after all ships are placed
		StandAlone.ShipPlacement = false
	else: 
		shipnumber += 1


# function to hide Covered sprite on tiles
func Debug(type):
	if type == "cover":
		for tile in tiles: #Allows the function to be run on all tiles instances 
			tile.DebugCovered()
	if type == "level":
		get_tree().change_scene_to_file("res://Codes and Screens/CompleteScreen.tscn") #Swtiches to the complete level screen
	if type == "game":
		get_tree().change_scene_to_file("res://Codes and Screens/OverScreen.tscn") 
	if type == "mines":
		SetMines()
