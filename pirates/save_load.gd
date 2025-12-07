extends Control

var save_file_path = "user://save/"
var save_file_name = "SavedGame.tres"

var savedGame = SaveGame.new()

func _ready():
	verify_save_directory(save_file_path)
	
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
	
	
func loadData():
	savedGame = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	Global.load
	
func saveData():
	savedGame.change_name(Global.player_name)
	ResourceSaver.save(savedGame, save_file_path + save_file_name)
