extends Fighter

var current_Value = 0
var max_Value = 100
var isCharging = false

func tick():
	current_Value = current_Value + 0.2
	isCharging = true 
	.tick()
