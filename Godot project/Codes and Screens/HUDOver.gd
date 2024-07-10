extends CanvasLayer
var cutoff = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bottom/HBoxContainer/Number.text = str(StandAlone.PlayerScore)
	var dic = openfile()
	print (dic)
	var arr =[dic[1],dic[2],dic[3],dic[4],dic[5]]
	print (arr)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Enter"):
		savefile() #saves the score of the player
		
func savefile():
	#sortfile() #sorts the files
	if StandAlone.PlayerScore < cutoff: #won't add player to score file if player score is under the lowest score
		pass 
	else:
		savingfile()
		
func _on_line_edit_text_submitted(new_text):
	name = new_text #grabs the enter name

func openfile():
	var scoresandnames = {}
	var config = ConfigFile.new() #new instantance of ConfigFile

	# Load data from a file.
	var file = config.load("user://scores.cfg")

	# If the file didn't load, ignore it.
	if file != OK:
		return

	# Iterate over all sections.
	for player in config.get_sections():
		# Fetch the data for each section.
		var player_name = config.get_value(player, "player_name")
		var player_score = config.get_value(player, "score")
		scoresandnames[player_name] = player_score
	
	return scoresandnames

#func sortfile():
	#var dic = openfile()
	#var arr =[dic.dic_one,dic.dic_two,dic.dic_three,dic.dic_four,dic.dic_five]
	#
	#_name_matched()
	#
##if no name is same when sorting
#func _no_name_matched_sorting():
	#arr[0].name=title
	#arr[0].score=score
	#var new_name
	#var new_score
	#var k = arr.size()-1
	#for i in range(arr.size()):
		#if i<arr.size():
			#if k >0:
				#if arr[0].score>arr[k].score:
					#new_name=arr[0].name
					#new_score=arr[0].score
					#arr[0].score=arr[k].score
					#arr[0].name= arr[k].name
					#arr[k].score=new_score
					#arr[k].name = new_name
				#print(arr[0])
			#k=k-1
##if name matched it will only sort if the previous score will be less than the new score of the same name
#func _name_matched():
	#name_matched=false
	#arr[0].name=title
	#arr[0].score=score
	#var new_name
	#var new_score
	#var k = arr.size()-1
	#var j=k-1
	#for i in range(arr.size()):
		#if i<arr.size():
			#if k >0:
				#if arr[0].name==arr[k].name and arr[0].score>arr[k].score:
					#arr[k].name=arr[0].name
					#arr[k].score=arr[0].score
					#name_matched=true
				#elif  arr[0].name==arr[k].name and arr[0].score<=arr[k].score:
					#name_matched=true
				#print(arr[0])
			#k=k-1
	#print(name_matched)
	#if !name_matched:
		#_no_name_matched_sorting()
	#else:
		#_name_matched_sorting()
#func _name_matched_sorting():
	#arr[0].name="title"
	#arr[0].score=0
	#var new_name
	#var new_score
	#for j in range(arr.size()):
		#if j<arr.size()-1:
			#if arr[j].score>=arr[j+1].score:
				#new_name=arr[j].name
				#new_score=arr[j].score
				#arr[j].score=arr[j+1].score
				#arr[j].name= arr[j+1].name
				#arr[j+1].score=new_score
				#arr[j+1].name = new_name

func savingfile():
	var config = ConfigFile.new()

	
	config.set_value("Player1", "player_name", "Steve")
	config.set_value("Player1", "score", 10)
	config.set_value("Player2", "player_name", "V3geta")
	config.set_value("Player2", "score", 9001)
	config.set_value("Player3", "player_name", "ea")
	config.set_value("Player3", "score", 323)
	config.set_value("Player4", "player_name", "ds")
	config.set_value("Player4", "score", 324213)
	config.set_value("Player4", "player_name", "pp")
	config.set_value("Player4", "score", 69)
	

	
	config.save("user://scores.cfg")
