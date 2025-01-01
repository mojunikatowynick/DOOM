extends CharacterBody3D


@export var SPEED = 5.0
@export var ACCELERATION = 0.1
@export var DECELERATION = 0.25
@export var JUMP_VELOCITY = 4.5
@export var JUMP_MOVE_DAMP = 2
@export var SRINT_MULTI = 1.8
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

var _is_crouching: bool = false

func _ready():

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	_update_camera(delta)
	
	move_and_slide()

func _unhandled_input(event):

	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY
		#print(Vector2(_rotation_input,_tilt_input))

func _input(_event):
	if Input.is_action_just_pressed("Crouch"):
		toggle_crouch()


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
	if _is_crouching == true: 
		print("crouching")
	elif _is_crouching == false:
		print("uncrouching")
	_is_crouching = !_is_crouching
