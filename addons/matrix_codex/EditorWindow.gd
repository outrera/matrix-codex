tool
extends WindowDialog

var entry

func set_entry(new_entry):
	entry = new_entry
	
	$VBoxContainer/Image.texture = entry.image
	$VBoxContainer/HBoxContainer/TitleEdit.text = entry.title
	$VBoxContainer/DescriptionEdit.text = entry.description
	$VBoxContainer/HBoxContainer/IDEdit.value = entry.id
	
	window_title = "Editing - " + entry.title

func _on_SaveButton_pressed():
	entry.id = $VBoxContainer/HBoxContainer/IDEdit.value
	entry.image = $VBoxContainer/Image.texture
	entry.title = $VBoxContainer/HBoxContainer/TitleEdit.text
	entry.description = $VBoxContainer/DescriptionEdit.text
	entry.save()
	hide()

func _on_ImageSelectDialog_file_selected(path):
	$VBoxContainer/Image.texture = load(path)

func _on_ChangeImageButton_pressed():
	get_node("../ImageSelectDialog").popup_centered()
