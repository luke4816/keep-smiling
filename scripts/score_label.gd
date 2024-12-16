extends Label


func change_text(value: int):
	text = str(value)


func _on_value_changed(value: int) -> void:
	change_text(value)
