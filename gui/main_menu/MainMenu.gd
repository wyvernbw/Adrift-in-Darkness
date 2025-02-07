extends Control

export var option_keys: Array
export var option_scenes: Array

onready var options_container = $VBoxContainer2/MarginContainer/VBoxContainer

var normal_style: Resource = preload("res://gui/main_menu/button_normal.tres")
var focus_style: Resource = preload("res://gui/main_menu/button_focus.tres")
var pressed_style: Resource = preload("res://gui/main_menu/button_pressed.tres")
var roboto_mono: Resource = preload("res://gui/menu_font.tres")


func _ready() -> void:
	for key in option_keys:
		var button: Button = Button.new()
		# button properties
		button.text = str(key)
		button.set("custom_styles/normal", normal_style)
		button.set("custom_styles/hover", focus_style)
		button.set("custom_styles/focus", focus_style)
		button.set("custom_styles/pressed", pressed_style)
		button.set("custom_fonts/font", roboto_mono)
		button.mouse_filter = 2  # ignore mouse

		button.connect(
			"pressed", self, "_on_button_pressed", [option_scenes[option_keys.find(key, 0)]]
		)
		options_container.add_child(button)
		if option_keys.find(key, 0) == 0:
			button.grab_focus()


func _on_button_pressed(scene_path: String) -> void:
	GlobalHandler.previous_scene = get_tree().get_current_scene().get_filename()
	get_tree().change_scene(scene_path)
