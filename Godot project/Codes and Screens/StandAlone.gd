extends Node


#None of these variables outside of the function are necessaryly needed to be predefined to make the game work 
#However it helps with scablitliy of the game in the future
#Allows assigning the amount of tiles on the play screen 
var Row = 0 
var Col = 0

#Level variables
var MineNumber = 0
#Ship Variable 
var ShipParts = 0
#Level Completation condition variables
var MineFlagged = 0 
var TilesUncovered = 0
var TilesRemain = 0

#Variables to determine the status of the game/level
var Complete = false
var GameOver = false

#Variable used to save scores 
var PlayerScore = 0


func BeginGame():
	Row = 8
	Col = 8
	MineNumber = randi_range(4,6)
	ShipParts = 17
	MineFlagged = 0
	TilesRemain = 64-(MineNumber+ShipParts)
	TilesUncovered = 0-(ShipParts)
	Complete = false
	GameOver = false
	PlayerScore = 0
	

