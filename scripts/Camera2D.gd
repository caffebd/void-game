extends Camera2D

export(NodePath) var TargetNodePath = null
var target_node
export (float) var lerpspeed = 0.65


# Called when the node enters the scene tree for the first time.
func _ready():
	target_node = get_node(TargetNodePath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = lerp(self.position, target_node.position, lerpspeed)
