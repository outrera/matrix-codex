tool
extends WindowDialog

var entries

func _ready():
	update_entry_list()

func update_entry_list():
	$HBoxContainer/SelectionContainer/EntryList.clear()
	
	entries = get_codex_entries()
	
	for entry in entries:
		$HBoxContainer/SelectionContainer/EntryList.add_item(entry.title, entry.image)

func _on_EntryList_item_activated(index):
	$HBoxContainer/EntryInspector/Title.text = entries[index].title
	$HBoxContainer/EntryInspector/Image.texture = entries[index].image
	$HBoxContainer/EntryInspector/Description.bbcode_text = entries[index].description

func get_codex_entries():
	var result = []
	
	var dir = Directory.new()
	dir.open("res://addons/matrix_codex/entries")
	dir.list_dir_begin(true)
	
	var filename = dir.get_next()
	
	while filename != "":
		result.append(load("res://addons/matrix_codex/entries/" + filename))
		filename = dir.get_next()
	
	return result


func _on_NewEntryButton_pressed():
	var new_entry = Resource.new()
	new_entry.set_script(load("res://addons/matrix_codex/entry.gd"))
	ResourceSaver.save("res://addons/matrix_codex/entries/new_entry.tres", new_entry)
	update_entry_list()
