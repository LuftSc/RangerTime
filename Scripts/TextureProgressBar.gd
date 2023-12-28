extends TextureProgressBar

@onready var player = $"../../Hero"

func _process(delta):
	value = player.currentHealth


