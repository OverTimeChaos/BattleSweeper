extends Node2D
#varible for individual tile
var is_cover = true
var flagged = false
var is_Mine = false

func SetMine(): #function for setting a bomb on an individual tile
	is_Mine = true #the tile has a bomb 
	$Mine.show() #Shows "Mine" Sprite


func uncover(): #function for uncovering a tile
	if flagged == false and is_cover == true: #if the tile is not flagged and a cover exists, player can uncover tile
		$Covered.hide() #hides the "Covered" sprite
		
		if is_Mine == true: #if the tile is a mine, the mine will explode creating a radius
			pass
		
		#if the tile is not a bomb, game proceeds
		elif is_Mine == false:	
			StandAlone.timeron = true #starts the timer
			StandAlone.tiles_opened += 1 #adds 1 to tiles opened for win condition
			is_cover = false #cover has been removed, so is_cover is false
			
			#displays the number of bombs around the uncovered tile in a 1 tile radius
			var count_surrounds = 0
			for tile in get_surrounds():
				if tile.is_bomb:
					count_surrounds += 1
			if count_surrounds > 0:
				$Label.text = str(count_surrounds)
			else:
				for tile in get_surrounds():
					if tile.is_cover:
						tile.uncover()
		
		#Win condition. If bombs needed to be flagged have been flagged and tiles to be opened have been opened, player wins
		if StandAlone.bombs_flagged == Global.bombs_number and Global.tiles_opened == Global.tiles_to_open:
			StandAlone.first_move = false #resets first_move to default value to stop the timer
			StandAlone.win = true
			on_player_winlose() 
