tool
extends EditorPlugin

var codex_menu

const TOOL_MENU_LABEL = "Matrix Codex"

func _ready():
	add_custom_type("CodexEntry", "Resource", load("res://addons/matrix_codex/entry.gd"), preload("res://addons/matrix_codex/ArcaniteLogo.png"))
	
	codex_menu = preload("res://addons/matrix_codex/CodexMenu.tscn").instance()
	get_editor_interface().get_base_control().add_child(codex_menu)
	codex_menu.visible = false
	add_tool_menu_item(TOOL_MENU_LABEL, self, "_open_codex")

func _exit_tree():
	remove_custom_type("CodexEntry")
	remove_tool_menu_item(TOOL_MENU_LABEL)
	codex_menu.queue_free()

func _open_codex(ud):
	codex_menu.popup_centered()
	codex_menu.update_entry_list()
