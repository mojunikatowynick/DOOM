extends CharacterBody3D

@export var TOGGLE_CROUCH: bool = true
@export var SPEED = 5.0
@export var ACCELERATION = 0.1
@export var DECELERATION = 0.25
@export var JUMP_VELOCITY = 4.5
@export var JUMP_MOVE_DAMP = 2
@export var SRINT_MULTI = 1.8
@export_range(5, 10,0.1) var CROUCH_SPEED: float = 7.0
@export var MOUSE_SENSITIVITY: float = 0.5
@export var TILT_LOWER_LIMIT : = deg_to_rad(-90.0)
@export var TTIL_UPPER_LIMIT : = deg_to_rad(90.0)
@export var CAMERA_CONTROLER : Camera3D
@export var ANIMATION_PLAYER : AnimationPlayer
@export var CROUCH_SHAPECAST : Node3D

var _mouse_input: bool = false
var _mouse_rotation: Vector3
var _rotation_input: float
var _tilt_input: float
var _player_rotation: Vector3
var _camera_rotation: Vector3

var _is_crouching: bool = false

func _ready():

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	CROUCH_SHAPECAST.add_exception($".")

func _physics_process(delta):
	
	Global.Player_speed = velocity.length()
		# Add the gravity. PLAYER_CONTROLER: CharacterBody3D
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
		# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor() and _is_crouching == false:
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("StrafeLeft", "StrafeRight", "Forward", "Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Input.is_action_pressed("Sprint"):
			velocity.x = lerp(velocity.x, direction.x * SPEED * SRINT_MULTI, ACCELERATION)
			velocity.z = lerp(velocity.z, direction.z * SPEED * SRINT_MULTI, ACCELERATION)
		else:
			velocity.x = lerp(velocity.x, direction.x * SPEED, ACCELERATION)
			velocity.z = lerp(velocity.z, direction.z * SPEED, ACCELERATION)
	else:
		#breaking speed from current vel to standstill "0" in time speed: change speed to fraction (0.1) for slowly slowing down
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.z = move_toward(velocity.z, 0, DECELERATION)

	
	_update_camera(delta)
	
	move_and_slide()

func _unhandled_input(event):

	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY
		#print(Vector2(_rotation_input,_tilt_input))

func _input(event):
	if event.is_action_pressed("Crouch") and TOGGLE_CROUCH == true:
		toggle_crouch()
		
	##### crouching when holiding button ####
	if event.is_action_pressed("Crouch") and TOGGLE_CROUCH == false:
		if CROUCH_SHAPECAST.is_colliding() == false:
			crouching(true)
	if event.is_action_released("Crouch") and TOGGLE_CROUCH == false:
		if CROUCH_SHAPECAST.is_colliding() == false:
			crouching(false)
		elif CROUCH_SHAPECAST.is_colliding() == true:
			uncrouching_check()

func _update_camera(delta):

	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TTIL_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0, _mouse_rotation.y, 0.0)
	_camera_rotation = Vector3(_mouse_rotation.x, 0.0, 0.0)
	
	CAMERA_CONTROLER.transform.basis = Basis.from_euler(_camera_rotation)
	global_transform.basis = Basis.from_euler(_player_rotation)
	CAMERA_CONTROLER.rotation.z = 0.0
	
	_rotation_input = 0.0
	_tilt_input = 0.0

func toggle_crouch():
	#print(_is_crouching, CROUCH_SHAPECAST.get_collider(0))
	if _is_crouching == true and CROUCH_SHAPECAST.is_colliding() == false: 
		crouching(false)
	elif _is_crouching == false:
		crouching(true)

func crouching(state: bool):
	print(state)
	match state:
		true:
			ANIMATION_PLAYER.play("Crouch", 0, CROUCH_SPEED)
		false:
			ANIMATION_PLAYER.play("Crouch", 0, -CROUCH_SPEED, true)

func uncrouching_check():
	if CROUCH_SHAPECAST.is_colliding() == false:
		crouching(false)
	if CROUCH_SHAPECAST.is_colliding() == true: 
		await get_tree().create_timer(0.1).timeout
		uncrouching_check()
		
func _on_animation_player_animation_started(anim_name):
	if  anim_name == "Crouch":
		_is_crouching = !_is_crouching
