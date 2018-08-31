extends Resource

export (int) var id = -1
export (String, MULTILINE) var title = "New Entry"
export (Texture) var image
export (String, MULTILINE) var description = "Describe the entry here!"

const unlock_file_datapath = "user://unlocked_entries.matrix"

func set_unlocked(unlocked):
	var unlock_data = get_unlock_data()
	
	if unlocked:
		# Set the entry as unlocked.
		print("Unlocked Entry: " + title)
		
		if unlock_data.has(float(id)):
			print("Entry was already unlocked.")
		else:
			unlock_data.append(id)
	else:
		# Set the entry as locked.
		print("Locked Entry: " + title)
		
		while unlock_data.has(float(id)):
			unlock_data.erase(float(id))

	set_unlock_data(unlock_data)

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
