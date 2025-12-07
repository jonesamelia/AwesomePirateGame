extends CanvasModulate

const MINUTES_PER_DAY = 1400
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTES = (2 * PI) / MINUTES_PER_DAY


@export var gradient:GradientTexture1D
@export var INGAME_SPEED = 1.0

var time = Global.time
var past_minute:float = -1.0

func _process(delta: float) -> void:
	time += delta * INGAME_TO_REAL_MINUTES * INGAME_SPEED
	var value = (sin(time -  PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)

	_recalculate_time()
	
func _recalculate_time() -> void:
	var total_minutes = int(time / INGAME_TO_REAL_MINUTES)
	var day = int(total_minutes / MINUTES_PER_DAY)
	var current_minutes = int(total_minutes % MINUTES_PER_DAY)
	
	var hour = int(current_minutes / MINUTES_PER_HOUR)
	var minute = int(current_minutes % MINUTES_PER_HOUR)
	
