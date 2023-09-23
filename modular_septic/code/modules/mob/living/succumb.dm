/mob/living/verb/succumb(whispered as null)
	set name = "sabdasdbasdn"
	set category = "IC"
	set desc = "so shitty."

	return FALSE
/*
	if(!CAN_SUCCUMB(src))
		to_chat(src, span_info("I am unable to succumb to death! This life continues."))
		return
	log_message("Has [whispered ? "whispered his final words" : "succumbed to death"] with [round(health, 0.1)] points of health!", LOG_ATTACK)
	ADJUSTBRAINLOSS(src, src.maxHealth)
	if(!whispered)
		to_chat(src, span_dead("I have given up life and succumbed to death."))
	death()
	updatehealth()
*/

/*
/mob/living/carbon/human/verb/belynx(whispered as null)
	set name = "Become a Lynx"
	set category = "IC"
	set desc = "You want?"
	set hidden = TRUE

	if(belief == "Hadot")
		if(HAS_TRAIT(src, TRAIT_LYNXER))
			var/lynx_ask = tgui_alert(usr, "Become a lynx?", "Do you wish to sleep in bushes and eat noobs?", list("Yes", "No"))
			if(lynx_ask == "No" || QDELETED(src))
				return FALSE
			if(can_heartattack())
				set_heartattack(TRUE)
			var/obj/effect/landmark/spawnedmob/lynx/lyn = locate() in world
			var/mob/living/simple_animal/hostile/podozl/caracal/newlynx = new(lyn.loc)
			newlynx.key = key
*/

/mob/living/carbon/human/verb/vomited(whispered as null)
	set name = "Vomit"
	set category = "Extra"
	set desc = "You want?"

	if(stat == CONSCIOUS)
		vomit(lost_nutrition = 10, blood = FALSE, stun = TRUE, distance = rand(1,2), message = TRUE, vomit_type = VOMIT_TOXIC, harm = TRUE, force = FALSE, purge_ratio = 0.1, button = TRUE)

/mob/living/carbon/human/verb/terrain(whispered as null)
	set name = "Check Terrain"
	set category = "Extra"
	set desc = "You want?"

	if(stat == CONSCIOUS)
//		var/duration = (((GET_MOB_ATTRIBUTE_VALUE(src, STAT_INTELLIGENCE)) - 16 SECONDS) + 1)
		if(!do_after(src, 3 SECONDS, target=src))
			to_chat(src, span_danger(xbox_rage_msg()))
			src.playsound_local(get_turf(src), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
			return
		var/diceroll = diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_PERCEPTION), context = DICE_CONTEXT_MENTAL)
		if(diceroll == DICE_SUCCESS)
			for(var/obj/M in range(7, src))
				if(M.istrap)
					var/turf/crazyturf = get_turf(M)
					crazyturf.color = "#f80000"
					animate(crazyturf, color = initial(crazyturf.color), 50)
					to_chat(src, span_steal("Noticed trap."))
		if(diceroll == DICE_CRIT_SUCCESS)
			for(var/obj/M in range(10, src))
				if(M.istrap)
					var/turf/crazyturf = get_turf(M)
					crazyturf.color = "#f80000"
					animate(crazyturf, color = initial(crazyturf.color), 70)
					to_chat(src, span_steal("Noticed trap."))
		if(diceroll <= DICE_FAILURE)
			to_chat(src, span_steal("I am failed to notice anything."))

/mob/living/carbon/human/proc/becomeboar(whispered as null)
	set hidden = TRUE
	set name = "Become Boar"
	set category = "Extra"
	set desc = "You want?"

	if(stat == CONSCIOUS)
		if(!isboarhuman(src))
			set_species(/datum/species/boarhuman)
			grant_language(/datum/language/russian, TRUE, TRUE, LANGUAGE_CULTIST)