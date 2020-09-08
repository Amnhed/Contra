extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var Velocidad = Vector2()#velocidad en x,y
export (float) var GRAVEDAD = 100
export (float) var VELOCIDAD_MOVIMIENTO = 25
export (float) var VELOCIDAD_SALTO = 25


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#calcular la velocidad en 'y'
	Velocidad.y += GRAVEDAD * delta #Gravedad * tiempo Caida
	
	if(Input.is_action_pressed("teacla_a")):
		Velocidad.x = -VELOCIDAD_MOVIMIENTO
		if(!get_node("animacion_j1").is_playing()):
			get_node("animacion_j1").play("j_corriendo")
			get_node("cuerpo_j1/spr_j1").flip_h = false
	elif(Input.is_action_pressed("tecla_d")):
		Velocidad.x = VELOCIDAD_MOVIMIENTO
		if(!get_node("animacion_j1").is_playing()):
			get_node("animacion_j1").play("j_corriendo")
			get_node("cuerpo_j1/spr_j1").flip_h = true
	else:
		Velocidad.x = 0
		get_node("animacion_j1").play("j_idle")
		
	if(Input.is_action_pressed("tecla_z")):
		Velocidad.y -= VELOCIDAD_SALTO
		get_node("animacion_j1").play("j1_salto")
		
	
	var movimiento = Velocidad * delta # velocidad por tiempo
	get_node("cuerpo_j1").move_and_slide(movimiento)#nodem que quiero mover


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
