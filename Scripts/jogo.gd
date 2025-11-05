extends Node2D

const BALL_SCENE := preload("res://prefarbs/bola.tscn")

@export var spawn_every: float = 0.5
@export var spawn_above: float = 16.0

@onready var txt_score: Label = $HUD/Control/HudScore/txt_score
@onready var txt_life: Label = $HUD/Control/HudLife/txt_life

var _rng := RandomNumberGenerator.new()
var _t: Timer
var can_use_baleia := true

func _ready() -> void:
	Globals.life = 3
	Globals.score = 0
	_rng.randomize()
	_t = Timer.new()
	_t.one_shot = false
	_t.wait_time = spawn_every
	add_child(_t)
	_t.timeout.connect(_spawn_one)
	_t.start()

func _process(_delta: float) -> void:
	txt_score.text = str(Globals.score)
	txt_life.text = "x" + str(Globals.life)
	
	if Globals.life <= 0:
		get_tree().change_scene_to_file("res://Scenes/derrota.tscn")

func _spawn_one() -> void:
	var vp_size := get_viewport_rect().size
	var x := _rng.randf_range(0.0, vp_size.x)
	var ball := BALL_SCENE.instantiate()
	ball.position = Vector2(x, -spawn_above)
	add_child(ball)

func _on_btn_baleia_pressed() -> void:
	if not can_use_baleia:
		return
	can_use_baleia = false
	
	await get_tree().create_timer(0.5).timeout
	for child in get_children():
		if child is CharacterBody2D and child.scene_file_path == "res://prefarbs/bola.tscn":
			child.queue_free()
	
	await get_tree().create_timer(5.0).timeout
	can_use_baleia = true
