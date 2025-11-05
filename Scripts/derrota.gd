extends Control

@onready var txt_final_score: Label = $value_score

func _process(_delta: float) -> void:
	txt_final_score.text = str(Globals.score)

# Jogar novamente
func _on_btn_again_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/jogo.tscn")

# Voltar para o menu
func _on_btn_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
