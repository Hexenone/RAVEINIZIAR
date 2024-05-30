/mob/living/verb/succumb(whispered as null)
	set name = "sabdasdbasdn"
	set category = null
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
	set name = "Блевать"
	set category = "Экстра"
	set desc = "You want?"

	if(stat == CONSCIOUS)
		vomit(lost_nutrition = 100, blood = FALSE, stun = TRUE, distance = rand(1,2), message = TRUE, vomit_type = VOMIT_TOXIC, harm = TRUE, force = FALSE, purge_ratio = 0.1, button = TRUE)

/mob/living/carbon/human/verb/terrain(whispered as null)
	set name = "Проверка территории"
	set category = "Экстра"
	set desc = "You want?"

	if(stat == CONSCIOUS)
		if(!client)
			return
		if(!do_after(src, 3 SECONDS, target=src))
			to_chat(src, span_danger(xbox_rage_msg()))
			src.playsound_local(get_turf(src), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
			return
		var/diceroll = diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_PERCEPTION), context = DICE_CONTEXT_MENTAL)
		if(diceroll == DICE_SUCCESS)
			for(var/obj/visible_obj in view(7, src))
				var/list/found_obj = list()
				if(visible_obj.plane == GAME_PLANE_FOV_HIDDEN)
					continue
				if(!visible_obj.istrap)
					continue
				var/turf/obj_turf = get_turf(visible_obj)
				if(!istype(obj_turf))
					continue
				found_obj += visible_obj
				var/image/ghost = image('modular_septic/icons/hud/screen_gen.dmi', obj_turf, "whatwasthat", FLOAT_LAYER)
				ghost.plane = POLLUTION_PLANE
				src.client.images += ghost
				if(length(found_obj) <= 0)
					to_chat(src, span_steal("Я не замечаю ничего подозрительного."))
				else
					to_chat(src, span_steal("Я замечаю что-то."))

		if(diceroll == DICE_CRIT_SUCCESS)
			for(var/obj/visible_obj in view(src))
				if((visible_obj.plane != GAME_PLANE_FOV_HIDDEN) && (visible_obj.istrap))
					var/turf/obj_turf = get_turf(visible_obj)
					if(!istype(obj_turf))
						continue
					var/image/ghost = image('modular_septic/icons/hud/screen_gen.dmi', obj_turf, "whatwasthat", FLOAT_LAYER)
					ghost.plane = POLLUTION_PLANE
					src.client.images += ghost
					to_chat(src, span_steal("Я замечаю ловушку."))

		if(diceroll <= DICE_FAILURE)
			to_chat(src, span_steal("Не получается проверить территорию."))
/*
/mob/living/carbon/human/verb/job_work(whispered as null)
	set name = "Роль"
	set category = "Экстра"
	set desc = "You want?"

	if(!src.mind?.assigned_role)
		return
	if(!src.mind?.assigned_role.job_work)
		return
	var/output_message = "<span class='infoplain'><div class='infobox'>[src.mind?.assigned_role.job_work]</div></span>"
	to_chat(src, output_message)
*/
/mob/living/carbon/human/verb/upp(whispered as null)
	set name = "Вверх"
	set category = "Экстра"
	set desc = "You want?"

	go_somewhere(down = FALSE)

/mob/living/carbon/human/verb/downn(whispered as null)
	set name = "Вниз"
	set category = "Экстра"
	set desc = "You want?"

	go_somewhere(down = TRUE)

/mob/living/carbon/human/proc/becomeboar(whispered as null)
	set hidden = TRUE
	set name = "Become Boar"
	set category = null
	set desc = "You want?"

	if(stat == CONSCIOUS)
		if(!isboarhuman(src))
			set_species(/datum/species/boarhuman)
			grant_language(/datum/language/russian, TRUE, TRUE, LANGUAGE_CULTIST)
