extends Area2D

signal done_camera
signal start_camera

var activated = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		if activated:
			return
		activated = true
		get_parent().get_node("BossDoor").close()
		DiscordPresence.set_detail("Is Boss Fight")
		camera_steer(true)

func camera_steer(go_back: bool):
	emit_signal("start_camera")
	var boss: Node2D = get_parent().get_node("Boss")
	
	var player_cam: Camera2D = get_parent().get_node("Player").get_node("PlayerCamera")
	player_cam.global_position = boss.global_position
	var old_smooth = player_cam.position_smoothing_speed
	player_cam.set_position_smoothing_speed(2)
	if go_back:
		await get_tree().create_timer(2).timeout
		player_cam.position = Vector2(0, 0)
		player_cam.set_position_smoothing_speed(old_smooth)
		emit_signal("done_camera")


func _on_boss_boss_died():
	camera_steer(false)
