@tool
extends EditorPlugin

var _tree: Tree

func _enter_tree() -> void:
	_tree = Tree.new()
	_tree.name = "Scripts"
	_tree.hide_root = true
	_tree.item_activated.connect(_on_item_activated)
	add_control_to_dock(DOCK_SLOT_LEFT_UR, _tree)

	  # Reconstrói a árvore sempre que o script ativo muda
	  # (abrir/fechar/trocar de script dispara esse sinal)
	var se := get_editor_interface().get_script_editor()
	se.editor_script_changed.connect(_on_scripts_changed)
	_rebuild()

func _exit_tree() -> void:
	remove_control_from_docks(_tree)
	_tree.queue_free()

func _on_scripts_changed(_script) -> void:
	_rebuild()

func _on_item_activated() -> void:
	var item := _tree.get_selected()
	if item == null:
		return
	var path = item.get_metadata(0)
	if path == null:
		return  # é uma pasta, não um script
	get_editor_interface().edit_resource(load(path))

func _rebuild() -> void:
	_tree.clear()
	var root := _tree.create_item()
	var dirs := {}  # caminho da pasta -> TreeItem

	var scripts := get_editor_interface().get_script_editor().get_open_scripts()
	for s in scripts:
		var path: String = s.resource_path
		if path.is_empty():
			continue
		var parent := _ensure_dir(path.get_base_dir(), root, dirs)
		var leaf := _tree.create_item(parent)
		leaf.set_text(0, path.get_file())
		leaf.set_metadata(0, path)

# Cria (recursivamente) os nós de pasta e devolve o TreeItem da pasta pedida
func _ensure_dir(dir: String, root: TreeItem, dirs: Dictionary) -> TreeItem:
	if dir.is_empty() or dir == "res://":
			return root
	if dirs.has(dir):
			return dirs[dir]
	var parent := _ensure_dir(dir.get_base_dir(), root, dirs)
	var item := _tree.create_item(parent)
	item.set_text(0, dir.get_file())
	dirs[dir] = item
	return item
