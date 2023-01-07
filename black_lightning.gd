extends ColorRect

func _ready():
	pass

func _process(_delta):
	var target: Node2D = get_parent().get_node("target")
	
	if target.has_node("target"):
		target = target.get_node("target")

	var tgp = target.global_position
	var sgp = get_parent().global_position
	
	var dir = tgp - sgp

	self.set_rotation(atan2(dir.y, dir.x))
	self.set_size(Vector2(dir.length(), self.get_size().y))
