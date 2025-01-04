class_name Player extends CharacterBody3D

#@export var TOGGLE_CROUCH: bool = true
@export var SPEED: float 
@export var ACCELERATION: float 
@export var DECELERATION: float 
@export var TOP_ANIM_SPEED: float
@export var JUMP_VELOCITY = 4.5
@export var JUMP_MOVE_DAMP = 2
@export var SRINT_MULTI = 1.8
@export_range(5, 10,0.1) var CROUCH_SPEED: float = 7.0
@export var MOUSE_SENSITIVITY: float = 0.5
@export var TILT_LOWER_LIMIT : = deg_to_rad(-90.0)
@export var TTIL_UPPER_LIMIT : = deg_to_rad(90.0)
@export var CAMERA_CONTROLER : Camera3D

var _mouse_input: bool = false
var _mouse_rotation: Vector3
var _rotation_input: float
var _tilt_input: float
var _player_rotation: Vector3
var _camera_rotation: Vector3

var _current_rotation: float

func _ready():

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	#CROUCH_SHAPECAST.add_exception($".")

func _physics_process(delta):
	update_input()
	move_and_slide()

	Global.Player_speed = velocity.length()
	Global.Player_on_floor = is_on_floor()
		# Add the gravity. PLAYER_CONTROLER: CharacterBody3D
	if not is_on_floor():
		velocity += get_gravity() * delta
	
		# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	_update_camera(delta)

func update_input():
		# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("StrafeLeft", "StrafeRight", "Forward", "Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, ACCELERATION)
		velocity.z = lerp(velocity.z, direction.z * SPEED, ACCELERATION)
	else:
		#breaking speed from current vel to standstill "0" in time speed: change speed to fraction (0.1) for slowly slowing down
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.z = move_toward(velocity.z, 0, DECELERATION)

	#if Input.is_action_just_pressed("Crouch"):
		#ANIMATION_PLAYER.play("Crouch", -1.0)
	#if Input.is_action_just_released("Crouch"):
		#ANIMATION_PLAYER.play("Crouch", -1.0, -1, true )

func _unhandled_input(event):

	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY
		#print(Vector2(_rotation_input,_tilt_input))


func _update_camera(delta):

	_current_rotation = _rotation_input
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
