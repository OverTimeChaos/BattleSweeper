extends Node2D
# preloads all the tile frames for performance
const ONE = preload ("res://Decals/MineSweeper/cells/WinmineXP/cell1.svg")
const TWO = preload ("res://Decals/MineSweeper/cells/WinmineXP/cell2.svg")
const THREE = preload ("res://Decals/MineSweeper/cells/WinmineXP/cell3.svg")
const FOUR = preload ("res://Decals/MineSweeper/cells/WinmineXP/cell4.svg")
const FIVE = preload ("res://Decals/MineSweeper/cells/WinmineXP/cell5.svg")
const SIX = preload ("res://Decals/MineSweeper/cells/WinmineXP/cell6.svg")
const SEVEN = preload ("res://Decals/MineSweeper/cells/WinmineXP/cell7.svg")
const EIGHT = preload ("res://Decals/MineSweeper/cells/WinmineXP/cell8.svg")
const EXP = preload ("res://Decals/Explosion.svg")
#varible for individual tile
var Covered = true
var Flagged = false
var IsMine = false

func _ready():
	$Numbers.texture = EXP
func SetMine(): #function for setting a bomb on an individual tile
	IsMine = true #the tile has a bomb 
	$Mine.show() #Shows "Mine" Sprite


func uncover(): #function for uncovering a tile
	if Flagged == false and Covered == true: #if the tile is not flagged and a cover exists, player can uncover tile
		$Covered.hide() #hides the "Covered" sprite
		
		if IsMine == true: #if the tile is a mine, the mine will explode creating a radius
			pass
		
		
		#elif IsMine == false: #if the tile is not a bomb, game proceeds
			#StandAlone.TilesUncovered += 1 #adds 1 to tiles opened for completion condition
			#Covered = false #Removes the "Covered" sprite
			#
			#var SurroundMineCount = 0 #displays the number of bombs around the uncovered tile in a 1 tile radius
			#for tile in get_surrounds():
				#if tile.is_bomb:
					#SurroundMineCount += 1
			#if SurroundMineCount > 0:
				#$Label.text = str(SurroundMineCount)
			#else:
				#for tile in get_surrounds():
					#if tile.is_cover:
						#tile.uncover()
		#
		##Win condition. If bombs needed to be flagged have been flagged and tiles to be opened have been opened, player wins
		#if StandAlone.bombs_flagged == Global.bombs_number and Global.tiles_opened == Global.tiles_to_open:
			#StandAlone.first_move = false #resets first_move to default value to stop the timer
			#StandAlone.win = true
			#on_player_winlose() 
