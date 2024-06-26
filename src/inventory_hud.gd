extends Control

@onready var player = get_node("/root/World/Player")
@onready var slot1 = $Slot1
@onready var slot1_count = $Slot1/Count

@onready var slot2 = $Slot2
@onready var slot2_count = $Slot2/Count

var infinity = "∞"

func update_ui():
	if !player:
		return
	var inventory = player.get_node("Inventory")
	if inventory.basic_has < 0:
		slot1_count.text = infinity
	else:
		slot1_count.text = str(inventory.basic_has)
	if inventory.special_has < 0:
		slot2_count.text = infinity
	else:
		slot2_count.text = str(inventory.special_has)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_ui()
