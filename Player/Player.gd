extends KinematicBody2D

var ACCELERATION = 500
var MAX_SPEED = 80
var FRICTION = 500
var ROLL_SPEED = 120

enum { MOVE, ROLL, ATTACK }

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN 
var can_move = true

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var swordHitbox = $HitBoxPivot/SwordHitBox
onready var animationState = animationTree.get("parameters/playback")
onready var hurtbox = $HurtBox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	randomize()
# warning-ignore:return_value_discarded
	Global.connect("no_health", self, "dying_state")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector

func _process(delta):
	if can_move == true:
		match state:
			MOVE:
				move_state(delta)
			ROLL:
				roll_state()
			ATTACK:
				attack_state()

func move_state(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)

	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if Input.is_action_just_pressed("ui_roll"):
		state = ROLL
	if Input.is_action_just_pressed("ui_attack"):
		state = ATTACK

func move():
	velocity = move_and_slide(velocity)

func roll_state():
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()

func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE

func _on_HurtBox_area_entered(area):
	$Hurt.play()
	Global.health -= area.damage
	hurtbox.start_invincibility(0.5)
	hurtbox.create_hit_effect()

func dying_state():
	$HurtBox.set_deferred("monitoring", false)
	animationTree.active = false
	can_move = false
	animationPlayer.play("Dying")
	yield($AnimationPlayer, "animation_finished")
	Global.health = 5
# warning-ignore:return_value_discarded
	Global.from = null
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_HurtBox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_HurtBox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
