extends CharacterBody2D


const SPEED = 110.0
const JUMP_VELOCITY = -290.0

@onready var anim = $AnimatedSprite2D

var mynter = 0
var totalt = 0


func _ready() -> void:
	totalt = get_tree().get_nodes_in_group("mynt").size()
	$HUD/Label.text = "Mynter: 0 / " + str(totalt)


func ta_mynt():
	mynter += 1
	$MyntLyd.play()
	$HUD/Label.text = "Mynter: " + str(mynter) + " / " + str(totalt)


func _on_musikk_finished() -> void:
	$Musikk.play()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# snu spilleren
	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true

	# animasjoner
	if not is_on_floor():
		anim.play("hopp")
	elif direction:
		anim.play("gå")
	else:
		anim.play("idle")

	# faller ut av banen
	if position.y > 250:
		get_tree().reload_current_scene()
