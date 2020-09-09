extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var Velocidad = Vector2()#velocidad en x,y
export (float) var GRAVEDAD = 100
export (float) var VELOCIDAD_MOVIMIENTO = 25
export (float) var VELOCIDAD_SALTO = 25
var puede_saltar = false


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
		if(!get_node("animacion_j1").is_playing()):
			get_node("animacion_j1").play("j_corriendo")
			get_node("cuerpo_j1/spr_j1").flip_h = true
		Velocidad.x = VELOCIDAD_MOVIMIENTO
	else:
		Velocidad.x = 0
		if(puede_saltar): 
			get_node("animacion_j1").play("j_idle") #si puede saltar esta en el suelo entoncle es el personaje en reposo
		
	if(Input.is_action_pressed("tecla_z") && puede_saltar):
		Velocidad.y = -VELOCIDAD_SALTO
		get_node("animacion_j1").play("j1_salto")
		puede_saltar = false
		
	
	var movimiento = Velocidad * delta # velocidad por tiempo
	get_node("cuerpo_j1").move_and_slide(movimiento)#nodem que quiero mover
	
	#if existe un objeto con el que colisiono
	
	if(get_node("cuerpo_j1").get_slide_collision(get_node("cuerpo_j1").get_slide_count()-1) != null):
		var obj_colisionado = get_node("cuerpo_j1").get_slide_collision(get_node("cuerpo_j1").get_slide_count()-1).collider
		#obtengo el numero total de colisionadores y el utimo colisionador con '.colider' obtenemos el ojeto de colision
		if(obj_colisionado.is_in_group("suelo")):
			if(puede_saltar == false):
				puede_saltar = true
				get_node("animacion_j1").stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
