extends Node
signal attachment_opened(action: String, data: Variant)

func initialize():
	Console.control.visible = true
	Console.enabled = true
	Console.enable()
	print("ExtraPuzzlesMod initialized!")

	var dir_path = "res://mods/ExtraPuzzlesMod/newPuzzles"
	var dir = DirAccess.open(dir_path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	print("Starting puzzle adding process!")
	while file_name != "":
		print("Trying to add the puzzle: " + file_name)
		
		if not dir.current_is_dir():
			var level_list = ResourceLoader.load("res://DemoPuzzles/demo_level_list.tres")

			if level_list == null:
				print("Error: ResourceLoader failed to load the level list.")
				return

			if not level_list is VoxelGameLevelSetList:
				print("Error: Loaded resource is not of type VoxelGameLevelSetList.")
				return

			print(level_list)
			for level_set in level_list.sets:
				if level_set.set_id == "tutorial":
					if file_name not in level_set.levels:
						level_set.levels.append(file_name)
			ResourceSaver.save(level_list, "res://DemoPuzzles/demo_level_list.tres")

			var file = FileAccess.open(dir_path + "/" + file_name, FileAccess.READ)  
			if file == null:
				print("Error creating file:", dir_path + "/" + file_name)
			else:
				var conteudo = file.get_as_text()
				file = FileAccess.open("res://DemoPuzzles/" + file_name, FileAccess.WRITE)
				
				if file == null:
					print("Error creating file:", "res://DemoPuzzles/" + file_name)
				else:
					file.store_string(conteudo)
					print("Error creating file:", "res://DemoPuzzles/" + file_name)
		else:
			print("The puzzle is a folder, your puzzle needs to be a Text File (.txt)")

		file_name = dir.get_next()

	dir.list_dir_end()
