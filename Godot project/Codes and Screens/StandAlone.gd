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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func BeginGame():
	Row = 8
	Col = 8
	MineNumber = randi_range(2,8)
	ShipParts = 17
	MineFlagged = 0
	TilesRemain = 64-(MineNumber+ShipParts)
	TilesUncovered = 0
	Complete = false
	GameOver = false
	PlayerScore = 0
	

