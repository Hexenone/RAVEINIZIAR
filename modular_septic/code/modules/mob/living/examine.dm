/// Things that happen when we examine an atom, duh
/mob/living/on_examine_atom(atom/examined, examine_more = FALSE)
	if(!client || (!DirectAccess(examined) && get_dist(src, examined) > EYE_CONTACT_RANGE) || (stat >= UNCONSCIOUS) || is_blind())
		return

	if(!HAS_TRAIT(src, TRAIT_FLUORIDE_STARE))
		if(!ismob(examined))
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> смотрит на [examined].")), \
							span_notice("Я смотрю на [examined]."), \
							vision_distance = EYE_CONTACT_RANGE)
		else
			var/mob/mob_examined = examined
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> смотрит на \
							<span style='color: [mob_examined.chat_color];'><b>[examined]</b></span>.")), \
							span_notice("Я смотрю на <b>[examined]</b>."), \
							vision_distance = EYE_CONTACT_RANGE)
	else
		if(!ismob(examined))
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> интересно смотрит на [examined].")), \
						span_notice("Я интересно смотрю на <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_RANGE)
		else
			var/mob/mob_examined = examined
//			mob_examined.playsound_local(get_turf(mob_examined), 'modular_pod/sound/eff/Stare.ogg', 80, FALSE)
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> интересно смотрит на \
						<span style='color: [mob_examined.chat_color];'><b>[examined]</b></span>.")), \
						span_notice("Я интересно смотрю на <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_RANGE)
	if(HAS_TRAIT(src, TRAIT_HORROR_STARE))
		if(!ismob(examined))
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> horror stares [examined].")), \
						span_notice("I horror stare <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_HORROR_RANGE)
		else
			var/mob/mob_examined = examined
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> horror stares \
						<span style='color: [mob_examined.chat_color];'><b>[examined]</b></span>.")), \
						span_notice("I horror stare <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_HORROR_RANGE)
