//Refer to life.dm for caller

/mob/living/carbon/human/handle_shock()
	. = ..()
	if(status_flags & GODMODE || analgesic || (species?.species_flags & NO_PAIN))
		setShock_Stage(0)
		return //Godmode or some other pain reducers. //Analgesic avoids all traumatic shock temporarily

	adjustShock_Stage(traumatic_shock)

	//This just adds up effects together at each step, with a few small exceptions. Preferable to copy and paste rather than have a billion if statements.
	switch(shock_stage)
		if(10 to 29)
			if(prob(20))
				to_chat(src, span_danger("[pick("You're in a bit of pain", "You ache a little", "You feel some physical discomfort")]."))
		if(30 to 39)
			if(prob(20))
				to_chat(src, span_danger("[pick("It hurts so much", "You really need some painkillers", "Dear god, the pain")]!"))
			set_timed_status_effect(10 SECONDS, /datum/status_effect/speech/stutter, only_if_higher = TRUE)
		if(40 to 59)
			if(prob(20))
				to_chat(src, span_danger("[pick("The pain is excruciating", "Please, just end the pain", "Your whole body is going numb")]!"))
			blur_eyes(1)
			set_timed_status_effect(10 SECONDS, /datum/status_effect/speech/stutter, only_if_higher = TRUE)
			Stagger(1 SECONDS)
			add_slowdown(1)
		if(60 to 79)
			if(!lying_angle && prob(20))
				emote("me", 1, "is having trouble standing.")
			blur_eyes(2)
			set_timed_status_effect(10 SECONDS, /datum/status_effect/speech/stutter, only_if_higher = TRUE)
			Stagger(3 SECONDS)
			add_slowdown(3)
			if(prob(20))
				to_chat(src, span_danger("[pick("The pain is excruciating", "Please, just end the pain", "Your whole body is going numb")]!"))
		if(80 to 119)
			blur_eyes(2)
			set_timed_status_effect(10 SECONDS, /datum/status_effect/speech/stutter, only_if_higher = TRUE)
			Stagger(6 SECONDS)
			add_slowdown(6)
			if(prob(20))
				to_chat(src, span_danger("[pick("The pain is excruciating", "Please, just end the pain", "Your whole body is going numb")]!"))
		if(120 to 149)
			blur_eyes(2)
			set_timed_status_effect(10 SECONDS, /datum/status_effect/speech/stutter, only_if_higher = TRUE)
			Stagger(9 SECONDS)
			add_slowdown(9)
			if(prob(20))
				to_chat(src, span_danger("[pick("The pain is excruciating", "Please, just end the pain", "Your whole body is going numb", "You feel like you could die any moment now")]!"))
		if(150 to INFINITY)
			blur_eyes(2)
			set_timed_status_effect(10 SECONDS, /datum/status_effect/speech/stutter, only_if_higher = TRUE)
			Stagger(12 SECONDS)
			add_slowdown(12)
			if(prob(20))
				to_chat(src, span_danger("[pick("The pain is excruciating", "Please, just end the pain", "Your whole body is going numb", "You feel like you could die any moment now")]!"))
			if(!COOLDOWN_FINISHED(src, last_shock_effect)) //Check to see if we're on cooldown
				return
			if(!lying_angle)
				emote("me", 1, "can no longer stand, collapsing!")
			Paralyze(1 SECONDS)
			COOLDOWN_START(src, last_shock_effect, LIVING_SHOCK_EFFECT_COOLDOWN) //set the cooldown.
