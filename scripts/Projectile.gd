extends Area2D

class_name Projectile

@export var speed = 400
signal balloon_hit

var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO


func _ready() -> void:
	connect("balloon_hit", GameData.on_balloon_hit)


func start(_transform) -> void:
	global_transform = _transform
	velocity = transform.x * speed


func _physics_process(_delta: float) -> void:
	velocity += acceleration
	velocity = velocity.limit_length(speed)

	rotation = velocity.angle()
	position += velocity


func _on_Arrow_area_entered(area: Area2D) -> void:
	if area.is_in_group("Target"):
		area.destroy()
		emit_signal("balloon_hit")

	queue_free()
