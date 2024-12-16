class_name Storage

const FILE_PATH = "save.json"

static var values: Dictionary = {}

static func save_value(name: String, value: int) -> void:
	values[name] = value
	save()

static func read_value(name: String) -> int:
	if name in values.keys():
		return values[name]

	return -1

static func load() -> void:
	if not FileAccess.file_exists("user://" + FILE_PATH):
		return

	var save_file = FileAccess.open("user://" + FILE_PATH, FileAccess.READ)
	var json_string = save_file.get_line()
	values = JSON.parse_string(json_string)

static func save() -> void:
	var save_file = FileAccess.open("user://" + FILE_PATH, FileAccess.WRITE)

	var json_string = JSON.stringify(values)

	save_file.store_line(json_string)
