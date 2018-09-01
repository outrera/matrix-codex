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

func save():
	if !resource_path:
		resource_path = "res://addons/matrix_codex/entries/"
	
	var save_path = resource_path.get_base_dir() + "/" + str(id) + " - " + title + ".tres"
	var dir = Directory.new()
	print(resource_path)
	dir.remove(resource_path)
	resource_path = save_path
	ResourceSaver.save(resource_path, self)
