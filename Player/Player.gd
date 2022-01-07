extends KinematicBody2D

onready var animationPlayer      = $AnimationPlayer
onready var animationTree        = $AnimationTree
onready var swordHitbox          = $HitBoxPivot/SwordHitBox
onready var animationState       = animationTree.get("parameters/playback")
onready var hurtbox              = $HurtBox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

onready var Player               = preload("res://Player/Unarmed.png")
onready var Ledi                 = preload("res://Player/Ledi.png")
onready var Lyu                  = preload("res://Player/Lyu.png")
onready var Legan                = preload("res://Player/Legan.png")
onready var Effect               = preload("res://Effects/EnemyDeathEffect.tscn")

var ACCELERATION                 = 500
var MAX_SPEED                    = 80
var FRICTION                     = 500
var ROLL_SPEED                   = 120

var velocity                     = Vector2.ZERO
var roll_vector                  = Vector2.DOWN
var can_move                     = true 
var can_attack                   = true 

var state                        = MOVE
enum { MOVE, ROLL, ATTACK, TRANSITION,}

signal update_mana

################################################################
func _ready():

	swordHitbox.knockback_vector = roll_vector
	animationTree.active         = true
	transformation()
	randomize()
#______________________________________ Connecting Signals ___
# warning-ignore:return_value_discarded
	Global.connect("no_health", self, "dying_state")
# warning-ignore:return_value_discarded
	self.connect("update_mana", Global, "_on_update_status")

################################################# State Machine ###
func _process(delta):

	if can_move == true:
		match state:
			MOVE:
					   move_state(delta)
			ROLL:
					   roll_state()
			ATTACK:
					   attack_state()
			TRANSITION:
					   transition_state()
	_invisible()

###################################################### Movement ###
func move_state(delta):

	var input_vector = Vector2.ZERO
	input_vector.x   = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y   = Input.get_action_strength("ui_down")  - Input.get_action_strength("ui_up")
	input_vector     = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		roll_vector  = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position",         input_vector)
		animationTree.set("parameters/Run/blend_position",          input_vector)
		animationTree.set("parameters/Roll/blend_position",         input_vector)
		animationTree.set("parameters/PlayerAttack/blend_position", input_vector)
		animationTree.set("parameters/LediAttack/blend_position",   input_vector)
		animationTree.set("parameters/LeganAttack/blend_position",  input_vector)
		animationTree.set("parameters/LyuAttack/blend_position",    input_vector)
		animationState.travel("Run")
		velocity     = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)

	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move()

	if can_attack == true:
		if Input.is_action_just_pressed("ui_roll"):
			state = ROLL
		if Input.is_action_just_pressed("ui_attack"):
			state = ATTACK
			_power()

func move():
	velocity = move_and_slide(velocity)

################################################# Roll & Attack ###
func roll_state():
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()

func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel(Global.player + "Attack")

func attack_animation_finished():
	state = MOVE

############################################### Transformations ###
func transformation():

	if Global.player == "Player":
		$Sprite.texture    = Player
		swordHitbox.damage = 1

	if Global.player == "Legan":
		$Sprite.texture    = Legan
		swordHitbox.damage = 2

	if Global.player == "Ledi":
		$Sprite.texture    = Ledi
		swordHitbox.damage = 4

	if Global.player == "Lyu":
		$Sprite.texture    = Lyu
		swordHitbox.damage = 6

func smoke_effect():
	$Smoke.play()
	$Smoke.frame = 0

############################# Walk by itself when change Levels ###
func transition():
	$Transition.start()
	roll_vector = Global.direction
	state = TRANSITION

func transition_state():
	velocity = Global.direction * MAX_SPEED
	animationTree.set("parameters/Run/blend_position",           Global.direction)
	animationTree.set("parameters/PlayerAttack/blend_position",  Global.direction)
	animationTree.set("parameters/Roll/blend_position",          Global.direction)
	animationTree.set("parameters/LediAttack/blend_position",    Global.direction)
	animationTree.set("parameters/LeganAttack/blend_position",   Global.direction)
	animationTree.set("parameters/LyuAttack/blend_position",     Global.direction)
	animationState.travel("Run")
	move()

func _on_Transition_timeout():
	animationTree.set("parameters/Idle/blend_position",          Global.direction)
	animationState.travel("Idle")
	state = MOVE

###################################################### Crafting ###
func cut_left():
	can_move = false
	animationState.travel("Idle")
	$AnimationPlayer.play("CutLeft")
	yield($AnimationPlayer,"animation_finished")
	animationState.travel("Idle")
	state = MOVE
	can_move = true

func cut_right():
	can_move = false
	animationState.travel("Idle")
	$AnimationPlayer.play("CutRight")
	yield($AnimationPlayer,"animation_finished")
	animationState.travel("Idle")
	state    = MOVE
	can_move = true

func break_left():
	can_move = false
	animationState.travel("Idle")
	$AnimationPlayer.play("BreakLeft")
	yield($AnimationPlayer,"animation_finished")
	animationState.travel("Idle")
	state    = MOVE
	can_move = true

func break_right():
	can_move = false
	animationState.travel("Idle")
	$AnimationPlayer.play("BreakRight")
	yield($AnimationPlayer,"animation_finished")
	animationState.travel("Idle")
	state    = MOVE
	can_move = true

######################################################## Damage ###
func _on_HurtBox_area_entered(area):
	$Hurt.play()
	Global.health -= area.damage
	hurtbox.start_invincibility(0.5)
	hurtbox.create_hit_effect()

func dying_state():
	#$HurtBox.set_deferred("monitoring", false)
	$HurtBox.queue_free()
	animationTree.active = false
	can_move = false
	animationPlayer.play("Dying")
	Global.stop_music()
	Global.death_play()
	yield($AnimationPlayer, "animation_finished")
	Global.health = Global.max_health
# warning-ignore:return_value_discarded
	Global.from = null
	Global.direction = Vector2.ZERO
	yield(get_tree().create_timer(2),"timeout")
	get_tree().change_scene("res://Levels/InsideHouse.tscn")
	Global.play_music()

func _on_HurtBox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_HurtBox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

################################################# Spending Mana ###
func _power():
	if Global.player == "Lyu":
		emit_signal("update_mana")
		if Global.mana > 0:
			Global.mana -= 10
			emit_signal("update_mana")
		else:
			Global.player = "Player"
			transformation()
			smoke_effect()

############################################### Using Repellent ###
func _invisible():
	if Global.repellent == true:
		self.modulate = Color(1,1,1,0.3)
	else:
		self.modulate = Color(1,1,1,1)
