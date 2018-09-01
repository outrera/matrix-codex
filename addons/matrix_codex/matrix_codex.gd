tool
extends Node

const unlock_file_datapath = "user://unlocked_entries.matrix"

static func get_unlock_data():
	var file = File.new()
	
	if file.file_exists(unlock_file_datapath):
		file.open(unlock_file_datapath, file.READ)
		var content = file.get_as_text()
		file.close()
		return parse_json(content)
	else:
		return []

static func set_unlock_data(data):
	var file = File.new()
	
	file.open(unlock_file_datapath, file.WRITE)
	file.store_string(to_json(data))
	file.close()
	
	print("Unlocks updated.")

static func list_all_entries():
	var result = []
	
	var dir = Directory.new()
	dir.open("res://addons/matrix_codex/entries")
	dir.list_dir_begin(true)
	
	var filename = dir.get_next()
	
	while filename != "":
		result.append(load("res://addons/matrix_codex/entries/" + filename))
		filename = dir.get_next()
	
	return result
