tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("CodexEntry", "Resource", preload("res://addons/matrix_codex/entry.gd"), preload("res://addons/matrix_codex/ArcaniteLogo.png"))

func _exit_tree():
	remove_custom_type("CodexEntry")
