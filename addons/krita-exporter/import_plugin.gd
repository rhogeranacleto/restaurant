@tool
extends EditorImportPlugin

func _get_importer_name():
	return "kra.importer"

func _get_visible_name():
	return "Krita importer"

func _get_recognized_extensions():
	return ["kra"]

func _get_save_extension():
	return "res"

func _get_resource_type():
	return "ImageTexture"

func _get_preset_count() -> int:
	return 1

func _get_preset_name(preset_index: int) -> String:
	return "Default"

func _get_import_options(path: String, preset_index: int) -> Array[Dictionary]:
	return []

func _get_option_visibility(path: String, option_name: StringName, options: Dictionary) -> bool:
	return true

func _import(source_file: String, save_path: String, options: Dictionary, platform_variants: Array[String], gen_files: Array[String]) -> Error:
	var zip := ZIPReader.new()
	
	var err := zip.open(source_file)
	
	if err != OK:
		push_error("Nao deu pra abrir %s: %s" % [source_file, error_string(err)])
		return err
	
	var png_data := zip.read_file("mergedimage.png")
	zip.close()
	
	if png_data.is_empty():
		push_error("Merged image not found: " + source_file)
		return ERR_FILE_NOT_FOUND
	
	var image := Image.new()
	err = image.load_png_from_buffer(png_data)
	
	if err != OK:
		return err
	
	var texture := ImageTexture.create_from_image(image)
	return ResourceSaver.save(texture, save_path + ".res")
