extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var xrInterface:XRInterface = XRServer.find_interface("OpenXR")
	if xrInterface and xrInterface.initialize():
		var vp:Viewport = get_viewport()
		vp.use_xr = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
