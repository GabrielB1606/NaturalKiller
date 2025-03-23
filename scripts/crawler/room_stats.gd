class_name RoomStats extends Resource

@export var time_mult:float
@export var enemies_qty:int
@export var spwn_freq:float
@export var enemies_ad:float
@export var enemies_mv:float
@export var enemies_hp:float

static func create_modifier(
	_time_mult: float = 1.0, 
	_enemies_qty: int = 0, 
	_spwn_freq: float = 0.0, 
	_enemies_ad: float = 0.0, 
	_enemies_mv: float = 0.0,
	_enemies_hp: float = 0.0
):
	return create(_time_mult, _enemies_qty, _spwn_freq, _enemies_ad, _enemies_mv, _enemies_hp)

static func create(
	_time_mult: float = 1.0, 
	_enemies_qty: int = 4, 
	_spwn_freq: float = 3.0, 
	_enemies_ad: float = 15.0, 
	_enemies_mv: float = 4.0,
	_enemies_hp: float = 35.0
):
	var instance:RoomStats = RoomStats.new()
	instance.time_mult = _time_mult
	instance.enemies_qty = _enemies_qty
	instance.spwn_freq = _spwn_freq
	instance.enemies_ad = _enemies_ad
	instance.enemies_mv = _enemies_mv
	instance.enemies_hp = _enemies_hp
	return instance
