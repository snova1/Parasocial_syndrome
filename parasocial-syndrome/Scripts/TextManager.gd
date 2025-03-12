extends Node

var dialogues :={
	"Lamp":{
		"default":[{"type": "internal", "text": "La tenue luz de la lámpara a penas ilumina el sótano"}]
	},
	"Cloth":{
		"default":[{"type": "internal", "text": "Hay cajas, y otros objetos bajo la tela. Pero nada que sea útil"}]
	},
	"Box":{
		"default":[{"type": "internal", "text": "La caja contiene libros, en su mayoría de misterio"}]
	},
	"Chair":{
		"default":[{"type": "question", "text": "¿Quieres empujar la silla?", "options": ["Sí", "No"]}]
	},
	"Table":{
		"atada":[
			{"type": "internal", "text": "Hay un vaso y otros menajes de mesa"},
			{"type": "spoken", "character": "Alessia", "text": "Podría utilizar ese vaso para romper mis ataduras"},
			{"type": "question", "text": "¿Deseas romper el vaso?", "options": ["Sí", "No"]}
		],
		"libre":[
			{"type": "internal", "text": "Hay trozos de vidrio, junto a otros menajes de mesa"},
			{"type": "spoken", "character": "Alessia", "text": "Por mucho que quisiera algo con lo que defenderme. Correr con un vidrio roto por la casa no me parece muy seguro"}
		],
		"no_rompio":[
			{"type": "spoken", "character": "Alessia", "text": "El vidrio roto es peligroso"},
			{"type": "spoken", "character": "Alessia", "text": "Aunque no se que más podría usar para librarme de esta cuerda"}
		],
		"rompio":[
			{"type": "spoken", "character": "Alessia", "text": "Por fin libre"},
			{"type": "spoken", "character": "Alessia", "text": "Ahora a encontrar la forma de salir de este sótano"}
		]
	},
	"Door":{
		"default":[
			{"type": "internal", "text": "Está cerrada"},
			{"type": "spoken", "character": "Alessia", "text": "Quizás haya algo aquí abajo con lo que abrir la cerradura"}
		],
		"has_key":[
			{"type": "internal", "text": "Está cerrada"},
			{"type": "question", "text": "¿Quieres intentar usar la llave?", "options": ["Sí"]}
		]
	},
	"Bookcase":{
		"default":[
			{"type": "internal", "text": "Hay una caja metálica sobre la estantería"},
			{"type": "spoken", "character": "Alessia", "text": "Necesito algo con lo que subir"}
		],
		"no_box":[
			{"type": "internal", "text": "Está llena de libros, algunos de tu autoría"},
			{"type": "spoken", "character": "Alessia", "text": "Algunos de estos son mis inspiraciones"},
			{"type": "spoken", "character": "Alessia", "text": "¿Cómo averiguó mis libros favoritos?"}
		]
	},
	"Curtain":{
		"default":[
			{"type": "internal", "text": "Una enorme cortina roja"},
			{"type": "question", "text": "¿Quieres abrirla?", "options": ["Sí","No"]}
		],
		"chose_open":[
			{"type": "spoken", "character": "Alessia", "text": "P-PERO ¿QUÉ?"},
			{"type": "spoken", "character": "Alessia", "text": "¿Esa...soy yo?"},
			{"type": "spoken", "character": "Alessia", "text": "Maldición, este tipo en serio está desquiciado si me ve de esta forma"},
			{"type": "spoken", "character": "Alessia", "text": "Tengo que salir de aquí cuanto antes"}
		]
	},
	"Mural":{
		"default":[{"type": "internal", "text": "Tras una inspección más cercana, notas unos números tenuemente grabados en el mural"}]
	},
	"Metal_Box":{
		"default":[{"type": "internal", "text": "Tiene un candado numérico"}],
		"wrong":[{"type": "internal", "text": "Esa no era la clave"}],
		"right":[
			{"type": "internal", "text": "Dentro de la caja había una llave"},
			{"type": "internal", "text": "Obtuviste una llave"}
		],
		"open":[{"type": "internal", "text": "Está vacia"}]
	}
}

func get_dialogue(interaction_id: String, state: String = "default") -> Array:
	if interaction_id in dialogues:
		return dialogues[interaction_id].get(state, dialogues[interaction_id].get("default", []))
	return [{"type": "internal", "text": "..."}]
