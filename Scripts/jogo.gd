extends Node2D

const BALL_SCENE := preload("res://prefarbs/bola.tscn")

@export var spawn_every: float = 0.5
@export var spawn_above: float = 16.0

@onready var txt_score: Label = $HUD/Control/HudScore/txt_score

var _rng := RandomNumberGenerator.new()
var _t: Timer

func _ready() -> void:
	_rng.randomize()
	_t = Timer.new()
	_t.one_shot = false
	_t.wait_time = spawn_every
	add_child(_t)
	_t.timeout.connect(_spawn_one)
	_t.start()

func _process(_delta: float) -> void:
	txt_score.text = str(Globals.score)

func _spawn_one() -> void:
	var vp_size := get_viewport_rect().size
	var x := _rng.randf_range(0.0, vp_size.x)
	var ball := BALL_SCENE.instantiate()
	ball.position = Vector2(x, -spawn_above)
	add_child(ball)
