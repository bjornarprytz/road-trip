class_name TileAction

var description: String
var targetState: String
var color: Color


static func discover() -> TileAction:
	var action = TileAction.new()
	action.description = "Discovered"
	action.targetState = "discovered"
	action.color = Color.GREEN
	return action
