extends Node

#score arrays and dictionaries
var scoresandnames = {}
var scores = []
var usernames = []
var carrier = []
var battleship = []
var cruiser = []
var submarine = []
var destroyer = []
var ships = ["Carrier","BattleShip","Cruiser","Submarine","Destroyer"]
var arrayShips = []
var sections 
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
var ShipPlacement = false

#Variable used to save scores 
var PlayerScore = 1


#tile variables
var interact = true
var firstleveldone = false

#Set values at the start
func BeginGame(): 
	carrier = [1,1,1,1,1]
	battleship = [1,1,1,1]
	cruiser = [1,1,1]
	submarine = [1,1,1]
	destroyer = [1,1]
	arrayShips = [carrier,battleship,cruiser,submarine,destroyer]
	Row = 8
	Col = 8
	MineNumber = randi_range(4,6)
	ShipParts = 17
	MineFlagged = 0
	TilesRemain = 64-(MineNumber+ShipParts)
	TilesUncovered = 0
	Complete = false
	GameOver = false
	PlayerScore = 0

#resets values after a level complete (excludes reseting GameOver and PlayerScore variables)
func LevelReset(): 
	Row = 8
	Col = 8
	MineNumber = randi_range(4,6)
	MineFlagged = 0
	TilesRemain = 64-(MineNumber+ShipParts)
	TilesUncovered = 0
	Complete = false
	

func openfile():
	var config = ConfigFile.new() #new instantance of ConfigFile
	
	# Load data from a file.
	var file = config.load("user://scores.cfg")
	sections = config.get_sections()
	# If the file didn't load, ignore it.
	if file != OK:
		return

	# Iterate over all sections.
	for player in sections:
		# Fetch the data for each section.
		var player_name = config.get_value(player, "player_name") #grabs player name from config
		var player_score = config.get_value(player, "score") #grabs player score from config
		scoresandnames[player_name] = player_score #puts them into a dictionary
		scores.append (scoresandnames[player_name]) #puts the scores into an array
	SortNumber() #sorts the scores from biggest to smallest
	SortName() #sorts names by biggest scores archive to smallest
	
	
func shipoffersetter(ship,rotating): # a function that gives the offset array of the ships
	#depending on switch ship and if the rotate is true or false it will give a different 
	var offsets = []
	match ship:
		0: #carrier
			if rotating == false:
				offsets = [
					(Vector2.LEFT) * 65,(Vector2.LEFT) * 130,(Vector2.RIGHT) * 65,(Vector2.RIGHT) * 130
				] 
			elif rotating == true:
				offsets = [
					(Vector2.UP) * 65,(Vector2.UP) * 130,(Vector2.DOWN) * 65,(Vector2.DOWN) * 130
				] 
		1: #battleship
			if rotating == false:
				offsets = [
					(Vector2.LEFT) * 65,(Vector2.LEFT) * 130,(Vector2.RIGHT) * 65
				] 
			elif rotating == true:
				offsets = [
					(Vector2.UP) * 65,(Vector2.UP) * 130,(Vector2.DOWN) * 65
				] 
		2,3: #sub or curiser
			if rotating == false:
				offsets = [
					(Vector2.LEFT) * 65,(Vector2.RIGHT) * 65
				] 
			elif rotating == true:
				offsets = [
					(Vector2.UP) * 65,(Vector2.DOWN) * 65
				] 
		4: #destoryer
			if rotating == false:
				offsets = [
					(Vector2.LEFT) * 65
				] 
			elif rotating == true:
				offsets = [
					(Vector2.UP) * 65
				] 
	return offsets

	
	
func SortNumber():
	scores.sort_custom(func(a,b): return a>b) #sorts scores by asscending order
func SortName():
	var sorted_list = scoresandnames.keys()
	sorted_list.sort_custom(func(a,b): return scoresandnames[a] > scoresandnames[b]) #sorts names by score
	usernames = sorted_list
	
func Sortnew(): #sorts with new score and makes a new dictionary 
	SortNumber()
	SortName()
	
func OverChecker(): #check if all the ships are destoryed
	if carrier.count(1) == 0 and battleship.count(1) == 0 and cruiser.count(1) == 0 and submarine.count(1) == 0 and destroyer.count(1) == 0:
		get_tree().change_scene_to_file("res://Codes and Screens/OverScreen.tscn") 
