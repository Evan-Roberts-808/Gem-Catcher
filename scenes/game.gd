extends Node2D

@export var gem_scene: PackedScene
@onready var score_label: Label = $Label
@onready var timer: Timer = $Timer

var _score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_gem() -> void:
	var new_gem : Gem = gem_scene.instantiate()
	var xpos: float = randf_range(70, 1050)
	new_gem.on_gem_off_screen.connect(game_over)
	new_gem.position = Vector2(xpos, -50)
	add_child(new_gem)

func stop_all() -> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)

func game_over() -> void:
	stop_all()

func _on_timer_timeout() -> void:
	print("_on_timer_timeout")
	spawn_gem()


func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	score_label.text = "%05d" % _score
	area.queue_free()
