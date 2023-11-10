extends PlayerExtra

onready var hover_button = $"%HoverButton"

onready var fast_fall_button = $"%FastFallButton"
onready var orb_push = $"%OrbPush"
onready var explode_button = $"%ExplodeButton"



onready var lock_button = $"%LockButton"

func _ready():
	hover_button.connect("toggled", self, "_on_hover_button_toggled")
	fast_fall_button.connect("toggled", self, "_on_fast_fall_button_toggled")
	orb_push.connect("data_changed", self, "emit_signal", ["data_changed"])

	explode_button.connect("pressed", self, "emit_signal", ["data_changed"])
	lock_button.connect("pressed", self, "emit_signal", ["data_changed"])




func on_data_changed():
	if fighter.orb_projectile != null:
		orb_push.visible = true
		if lock_button.pressed:
			orb_push.visible = false
	

func _on_hover_button_toggled(on):
	if on:
		fast_fall_button.set_pressed_no_signal(false)
	emit_signal("data_changed")

func _on_fast_fall_button_toggled(on):
	if on:
		hover_button.set_pressed_no_signal(false)
	emit_signal("data_changed")

func _on_shoot_button_toggled(on):
	$"%LaunchDir".visible = on

func reset():
	orb_push.set_dir("Neutral")
	var is_hurt = fighter.current_state() != CharacterHurtState
	explode_button.set_pressed_no_signal(fighter.detonating_bombs and is_hurt)
	fast_fall_button.set_pressed_no_signal(fighter.fast_falling and is_hurt)
	hover_button.set_pressed_no_signal(fighter.hovering and is_hurt)
	lock_button.set_pressed_no_signal(false)
	if fighter.orb_projectile != null:
		var orb = fighter.obj_from_name(fighter.orb_projectile)
		lock_button.set_pressed_no_signal(orb.locked)

func show_options():
	orb_push.hide()
	orb_push.init()
	lock_button.hide()
	explode_button.hide()
	orb_push.visible = fighter.orb_projectile != null
	lock_button.visible = fighter.orb_projectile != null
	if lock_button.pressed:
		orb_push.visible = false

	hover_button.hide()
	fast_fall_button.hide()
	fast_fall_button.set_pressed_no_signal(fighter.fast_falling)
	hover_button.set_pressed_no_signal(fighter.hovering)
	if fast_fall_button.pressed and hover_button.pressed:
		fast_fall_button.set_pressed_no_signal(false)


	if fighter.can_hover() or fighter.hovering:
		hover_button.show()
	if "Knockdown" in fighter.current_state().name:
		hover_button.hide()
		hover_button.set_pressed_no_signal(false)
	
	if fighter.can_fast_fall():
		fast_fall_button.show()
	if fighter.spark_bombs:
		explode_button.show()
	



func get_extra():
	var extra = {
		"hover":hover_button.pressed, 
		"fast_fall":fast_fall_button.pressed, 
		"detonate":explode_button.pressed, 
		"orb_push":orb_push.get_data(), 
		"lock_orb":lock_button.pressed, 


	}
	return extra
