extends PlayerInfo

onready var bf_bar = $"%BFBar"

func set_fighter(fighter):
	.set_fighter(fighter)
	if player_id == 2:
		$"%BFBar".fill_mode = TextureProgress.FILL_RIGHT_TO_LEFT
		$HBoxContainer.alignment = BoxContainer.ALIGN_END

func _process(delta):
	if is_instance_valid(fighter):
		bf_bar.value = fighter.current_Value / float(fighter.max_Value)
		bf_bar.modulate.a = 0.25 if fighter.current_Value <= fighter.max_Value else 1.0
	
	
