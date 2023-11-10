extends CharacterState





func _frame_1():

		var vel = host.get_vel()
		host.stored_momentum_x = vel.x
		host.stored_momentum_y = vel.y
		var speed = fixed.vec_len(vel.x, vel.y)
		var stored_speed = speed


		host.reset_momentum()
		host.momentum_stores += 1
		if host.momentum_stores > 3:
			host.momentum_stores = 3
		match host.momentum_stores:
			1:
				host.stored_speed_1 = stored_speed
			2:
				host.stored_speed_2 = stored_speed
			3:
				host.stored_speed_3 = stored_speed







func _tick():

		host.apply_fric()
		host.apply_grav()
		host.apply_forces()



func is_usable():


	return .is_usable() and (host.momentum_stores < 3 or host.infinite_resources)
