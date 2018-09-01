tool
extends Resource

export (int) var id = -1
export (String) var title = "New Entry"
export (Texture) var image
export (String, MULTILINE) var description = "Describe the entry here!"

func set_unlocked(unlocked):
	var unlock_data = MatrixCodex.get_unlock_data()
	
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

	MatrixCodex.set_unlock_data(unlock_data)

func delete():
	var dir = Directory.new()
	if dir.file_exists(resource_path):
		dir.remove(resource_path)

func save():
	if resource_path:
		var dir = Directory.new()
		if dir.file_exists(resource_path):
			dir.remove(resource_path)
	else:
		resource_path = "res://addons/matrix_codex/entries/aaa"
	
	var save_path = resource_path.get_base_dir() + "/" + str(id) + " - " + title + ".tres"
	print(save_path)
	resource_path = save_path
	ResourceSaver.save(resource_path, self)
