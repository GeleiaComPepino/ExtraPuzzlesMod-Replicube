extends Node
signal attachment_opened(action: String, data: Variant)
func initialize():
	
	Console.control.visible = true
	Console.enabled = true
	Console.enable()
	print("ExtraPuzzlesMod initialized!")
	var dir_path = "./newPuzzles"
	var dir = DirAccess.open(dir_path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	print("Starting puzzle adding process!")
	while file_name != "":
		print("Trying to add the puzzle: " + file_name)
		if not dir.current_is_dir():
			var level_list: VoxelGameLevelSetList = load("res://DemoPuzzles/demo_level_list.tres")
			for level_set in level_list.sets:
				if level_set.set_id == "tutorial":
					if file_name not in level_set.levels:
						level_set.levels.append(file_name)

			# Now we save the modified list, making it persistent
			ResourceSaver.save(level_list, "res://DemoPuzzles/demo_level_list.tres")
			var file = FileAccess.open(dir_path+ "/" + file_name, FileAccess.READ)  
			if file == null:
				print("Erro ao abrir arquivo:", dir_path+ "/" + file_name)
				return

			var conteudo = file.get_as_text()  # Lê o conteúdo do arquivo original
			file = FileAccess.open("res://DemoPuzzles/" + file_name, FileAccess.WRITE)  # Cria um novo arquivo no destino
			if file == null:
				print("Erro ao criar arquivo:", "res://DemoPuzzles/" + file_name)
				return
			file.store_string(conteudo)  # Salva o conteúdo no novo arquivo
			print("Arquivo copiado para:", "res://DemoPuzzles/" + file_name)
		else:
			print("The puzzle is a folder, your puzzle needs to be a Text File (.txt)")
