tool
extends Control

var entries
var currently_selected_entry

func _ready():
	update_entry_list()

func update_entry_list():
	$MainWindow/HBoxContainer/SelectionContainer/EntryList.clear()
	
	entries = MatrixCodex.list_all_entries()
	
	for entry in entries:
		$MainWindow/HBoxContainer/SelectionContainer/EntryList.add_item(entry.title, entry.image)

func display_entry(entry):
	$MainWindow/HBoxContainer/EntryInspector/Title.text = entry.title
	$MainWindow/HBoxContainer/EntryInspector/Image.texture = entry.image
	$MainWindow/HBoxContainer/EntryInspector/Description.bbcode_text = entry.description
	currently_selected_entry = entry

func _on_NewEntryButton_pressed():
	var new_entry = Resource.new()
	new_entry.set_script(preload("res://addons/matrix_codex/entry.gd"))
	new_entry.save()
	currently_selected_entry = new_entry
	_on_EditButton_pressed()

func _on_EditButton_pressed():
	if currently_selected_entry:
		$EditorWindow.set_entry(currently_selected_entry)
		$MainWindow.visible = false
		$EditorWindow.popup_centered()

func _on_EditorWindow_popup_hide():
	$MainWindow.popup_centered()
	update_entry_list()
	display_entry($EditorWindow.entry)

func _on_DeleteEntryButton_pressed():
	currently_selected_entry.delete()
	update_entry_list()

func _on_EntryList_item_selected(index):
	display_entry(entries[index])
