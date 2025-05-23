/mob/living/simple_animal/mouse
	name = "mouse"
	desc = "It's a nasty, ugly, evil, disease-ridden rodent."
	icon_state = "mouse_gray"
	icon_living = "mouse_gray"
	icon_dead = "mouse_gray_dead"
	speak = list("Squeak!","SQUEAK!","Squeak?")
	speak_emote = list("squeaks")
	emote_hear = list("squeaks.")
	emote_see = list("runs in a circle.", "shakes.")
	speak_chance = 1
	turns_per_move = 5
	maxHealth = 5
	health = 5
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "splats"
	density = FALSE
	allow_pass_flags = PASS_MOB
	pass_flags = PASS_LOW_STRUCTURE|PASS_GRILLE|PASS_MOB
	mob_size = MOB_SIZE_SMALL
	var/body_color //brown, gray and white, leave blank for random
	var/chew_probability = 1


/mob/living/simple_animal/mouse/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, 'sound/effects/mousesqueek.ogg', 100, 30)
	if(!body_color)
		body_color = pick( list("brown","gray","white") )
	icon_state = "mouse_[body_color]"
	icon_living = "mouse_[body_color]"
	icon_dead = "mouse_[body_color]_dead"
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)
	AddElement(/datum/element/connect_loc, connections)
	ADD_TRAIT(src, TRAIT_CAN_VENTCRAWL, INNATE_TRAIT)


/mob/living/simple_animal/mouse/proc/on_cross(datum/source, atom/movable/AM, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(ishuman(AM) && stat == CONSCIOUS)
		var/mob/living/carbon/human/H = AM
		to_chat(H, span_notice("[icon2html(src, H)] Squeak!"))


/mob/living/simple_animal/mouse/handle_automated_action()
	if(prob(chew_probability))
		var/turf/open/floor/F = get_turf(src)
		if(istype(F))
			var/obj/structure/cable/C = locate() in F
			if(C && prob(15))
				if(C.avail())
					visible_message(span_warning("[src] chews through the [C]. It's toast!"))
					playsound(src, 'sound/effects/sparks2.ogg', 100, 1)
					C.deconstruct()
					death()
				else
					C.deconstruct()
					visible_message(span_warning("[src] chews through the [C]."))


/mob/living/simple_animal/mouse/white
	body_color = "white"
	icon_state = "mouse_white"


/mob/living/simple_animal/mouse/gray
	body_color = "gray"
	icon_state = "mouse_gray"


/mob/living/simple_animal/mouse/brown
	body_color = "brown"
	icon_state = "mouse_brown"


/mob/living/simple_animal/mouse/brown/Tom
	name = "Tom"
	desc = "Jerry the cat is not amused."
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "splats"
