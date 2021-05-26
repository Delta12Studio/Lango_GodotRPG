extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const Drop = preload("res://World/Item.tscn")

var dead = false
var rng = RandomNumberGenerator.new()
var my_number

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4
export var HEALTH = 3

enum enemy { BEE, BAT }
export(enemy) var enemy_type = enemy.BEE

enum{
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = CHASE 

onready var hurtbox = $HurtBox
onready var bar = $Health/Bar
onready var playerDetectionZone = $PlayerDetectionZone
onready var wanderController = $WanderController
onready var sprite = $AnimatedSprite
onready var animationPlayer = $AnimationPlayer

func _ready():
	state = pick_random_state([IDLE, WANDER])
	raffle()

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
				
	velocity = move_and_slide(velocity)

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func seek_player():
	if playerDetectionZone.can_see_player():
		$AudioStreamPlayer.play()
		$Health.visible = true
		state = CHASE
	else:
		$Health.visible = false

func _on_HurtBox_area_entered(area):
	if HEALTH != 1:
		$AudioStreamPlayer.play()
		bar.rect_size.x = bar.rect_size.x - (bar.rect_size.x / HEALTH)
		HEALTH = HEALTH -1
		knockback = area.knockback_vector * 120
		hurtbox.create_hit_effect()
		hurtbox.start_invincibility(0.4)
	else:
		dead = true
		queue_free()
		var enemyDeathEffect = EnemyDeathEffect.instance()
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_HurtBox_invincibility_started():
	animationPlayer.play("Start")

func _on_HurtBox_invincibility_ended():
	animationPlayer.play("Stop")

func raffle():
	rng.randomize()
	my_number = rng.randi_range(0,10)

func _on_HurtBox_area_exited(_area):
	if dead == true:
		if my_number <= 5:
			var drop = Drop.instance()
			if enemy_type == enemy.BEE:
				drop.type = 2
				get_parent().add_child(drop)
				drop.position = position
			elif enemy_type == enemy.BAT:
				drop.type = rng.randi() % 2
				get_parent().add_child(drop)
				drop.position = position
