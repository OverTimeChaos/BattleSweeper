extends Node2D

#Constants
const boom = "boom"
const default = "default"
#Debug varaibles
var CoveredDebug = true

#varible for individual tile
var Covered = true
var Flagged = false
var IsMine = false
var IsOccupied = false
var Exploded = false
var shipNumber = 0
var partNumber = 0
	
func SetMine(): #function for setting a bomb on an individual tile
		IsMine = true #the tile has a bomb 
		$Mine.show() #Shows "Mine" Sprite


func uncover(): #function for uncovering a tile
	if IsOccupied == false:
		if Flagged == false and Covered == true: #if the tile is not flagged and a cover exists, player can uncover tile
			$Covered.hide() #hides the "Covered" sprite
			
			if IsMine == true: #if the tile is a mine, the mine will explode creating a radius
				Covered = false
				Events.emit_signal("EventTrigger",boom,null)  #changes text to explosion message
				await get_tree().create_timer(1.0).timeout # shows the mine before it mine explosion frame
				StandAlone.MineNumber -= 1
				$Mine.hide()
				explode()
				for tile in GetSurroundings(): #calls the GetSurroundings function to found the Surroundings mines
					tile.explode()
				await get_tree().create_timer(1.0).timeout # shows the mine before it mine explosion frame
				Events.emit_signal("EventTrigger", default,null) #sets it back to default message
				$Numbers.set_frame(9)
			
			elif IsMine == false: #if the tile is not a mine, the game proceeds
				StandAlone.TilesUncovered += 1 #adds 1 to tiles opened for completion condition
				Covered = false #Removes the "Covered" sprite
				
				
				var SurroundMineCount = 0 #displays the number of bombs around the uncovered tile in a 1 tile radius
				for tile in GetSurroundings(): #calls the GetSurroundings function to found the Surroundings mines
					if tile.IsMine:
						SurroundMineCount += 1 #varibale used to assign uncovered tile texture
				if SurroundMineCount > 0: #if there is a mine touching
					$Numbers.set_frame(SurroundMineCount) # Set the right number texture for amount of mines touching
				else:
					for tile in GetSurroundings():
						if tile.Covered:
							#uncovers tiles that don't have tocuhing mines to save the player from serprate uncovering each non mine touching tile
							tile.uncover() 
							
			#Completion condition. If mines needed to be flagged have been flagged or tiles to be opened have been opened
			if StandAlone.MineFlagged == StandAlone.MineNumber or StandAlone.TilesUncovered == StandAlone.TilesRemain:
				get_tree().change_scene_to_file("res://Codes and Screens/CompleteScreen.tscn") #Swtiches to the complete level screen

						
func GetSurroundings(): #function for getting a tile's surroundings for neighbouring mines
	var surrounds = [] #sets variable to an empty array
	
	#radius is set to 1 tile, which is 65 pixels
	var offsets = [ 
		(Vector2.UP + Vector2.LEFT) * 65,
		(Vector2.UP) * 65,
		(Vector2.UP + Vector2.RIGHT) * 65,
		(Vector2.LEFT) * 65,
		(Vector2.RIGHT) * 65,
		(Vector2.DOWN + Vector2.LEFT) * 65,
		(Vector2.DOWN) * 65,
		(Vector2.DOWN + Vector2.RIGHT) * 65,
	]
	#add the tile's surroundings to the array for 65 pixels around the tile
	for offset in offsets: 	
		for tile in get_parent().tiles:
			if tile.position  == position + offset: 
				surrounds.append(tile)
	return surrounds 
	
func ToggleFlag(): #function for toggling on and off a flag on a tile
#Primary check for if tile is still covered
	if IsOccupied == false:
		if Covered:
			
			#if the tile is not flagged, flag the tile
			if Flagged == false:
				$Flag.show()
				Flagged = true 
				
					# if the unflagged tile does not contain a mine, remove 1 to MineFlagged for completion condition
				if IsMine == false:
					StandAlone.MineFlagged -= 1
			
				#if the flagged tile contains a mine, adds 1 to MineFlagged for complete condition
				if IsMine== true:
					StandAlone.MineFlagged += 1
					
				#Check if player has completed the level. Complete condition
				if StandAlone.MineFlagged == StandAlone.MineNumber or StandAlone.TilesUncovered == StandAlone.TilesRemain:
						get_tree().change_scene_to_file("res://Codes and Screens/CompleteScreen.tscn") #Swtiches to the complete level screen
			
			#If the tile is already flagged, unflag the tile
			elif Flagged == true:
				$Flag.hide()
				
				# if the unflagged tile does not contain a mine, add 1 to MineFlagged for completion condition
				if IsMine == false:
					StandAlone.MineFlagged += 1
					if StandAlone.MineFlagged == StandAlone.MineNumber or StandAlone.TilesUncovered == StandAlone.TilesRemain:
							get_tree().change_scene_to_file("res://Codes and Screens/CompleteScreen.tscn") #Swtiches to the complete level screen
				#if the unflagged tile contains a mine, remove 1 to MineFlagged for completion condition
				if IsMine == true:
					StandAlone.MineFlagged -= 1 
				Flagged = false 
			#secondary check if the cover is still on the tile
			#if the cover has already been uncovered, the code will do nothing thus the input will do nothing
			elif Covered == false:
				pass

func explode(): #shows the explosion sprite
	Exploded = true #sets tile to exploded so that if ship part is on exploded it will damage the ship part
	$Explosion.show()
	await get_tree().create_timer(1.0).timeout # shows explosion for the player to register that the mine has exploded
	$Explosion.hide()
	Exploded = false #not neccesary as if there was a ship near the radius of the tile there would be already destroyed
	# however is great for scalablity 
	
	
func _on_control_gui_input(event):
	if (event) is InputEventMouseButton: #detects mouse input
		#Calls uncover function on left click
		if event.is_action_pressed("LeftClick"):
			if StandAlone.ShipPlacement == true:
				pass
			else: 
				uncover()
		
		#Calls flag function on right click
		if event.is_action_pressed("RightClick"):
			if StandAlone.ShipPlacement == true:
				pass
			else:
				ToggleFlag()
				
				
func indicated(bool):
	if bool == true:
		$Covered.set_frame(1) #As the mouses hovers over a tile it changes to indicate that the tile is being selected
	if bool == false:
		$Covered.set_frame(0) #As the mouses unohoveres over a tile it changes to indicate that the tile is not being selected

func tilespriter(ship,rotating):
	var turn = randi_range(0,1)
	match ship:
		0:
			if rotating == true:
				if turn == 1:
					$Carrier.rotation_degrees = 270
				else:
					$Carrier.rotation_degrees = 90
			else:
				if turn == 1:
					$Carrier.rotation_degrees = 180
			$Carrier.show()
		1:
			if rotating == true:
				if turn == 1:
					$BattleShip.rotation_degrees  = 270
				else:
					$BattleShip.rotation_degrees  = 90
				$BattleShip.position = Vector2(103.145,203.66)
			else:
				if turn == 1:
					$BattleShip.rotation_degrees  = 180
			$BattleShip.show()
		2:
			if rotating == true:
				if turn == 1:
					$Cursier.rotation_degrees = 270
				else:
					$Cursier.rotation_degrees = 90
			else:
				if turn == 1:
					$Cursier.rotation_degrees = 180
			$Cursier.show()
		3:
			if rotating == true:
				if turn == 1:
					$Submarine.rotation_degrees = 270
				else:
					$Submarine.rotation_degrees = 90
			else:
				if turn == 1:
					$Submarine.rotation_degrees = 180
			$Submarine.show()
		4:
			if rotating == true:
				if turn == 1:
					$Destoryer.rotation_degrees  = 270
				else:
					$Destoryer.rotation_degrees  = 90
				$Destoryer.position = Vector2(103,208)
			else:
				if turn == 1:
					$Destoryer.rotation_degrees  = 180
			$Destoryer.show()

func _on_control_mouse_entered():
	if StandAlone.ShipPlacement == true and StandAlone.interact == true:
		Events.emit_signal("NodePosition",self,position)
	elif StandAlone.ShipPlacement == false and IsOccupied == false :
		$Covered.set_frame(1) #As the mouses hovers over a tile it changes to indicate that the tile is being selected
func _on_control_mouse_exited():
	if StandAlone.ShipPlacement == true and StandAlone.interact == true:
		Events.emit_signal("NodePosition",self,position)
	elif StandAlone.ShipPlacement == false and IsOccupied == false:
		$Covered.set_frame(0)#As the mouses leaves the tile it changes to indicate that the tile is not being selected
		
		
func DebugCovered(): #uncovers or covers tiles for debug purposes
	if CoveredDebug == false:
		if Covered == true:
			$Covered.show()
		CoveredDebug = true
	else:
		$Covered.hide()
		CoveredDebug = false
