/atom/movable/screen/hydration
	name = "hydration"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "hydration3"
	base_icon_state = "hydration"
	screen_loc = ui_hydration
	var/hydration_index = 3

/atom/movable/screen/hydration/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][hydration_index]"

/atom/movable/screen/hydration/Click(location, control, params)
	. = ..()
	if(!isliving(usr))
		to_chat(usr, div_infobox(span_notice("Мне не нужна вода.")))
		return
	var/mob/living/living_user = usr
	switch(living_user.hydration)
		if(HYDRATION_LEVEL_FULL to INFINITY)
			to_chat(usr, div_infobox(span_notice("Я уж точно напился!")))
		if(HYDRATION_LEVEL_WELL_HYDRATED to HYDRATION_LEVEL_FULL)
			to_chat(usr, div_infobox(span_notice("Я напился.")))
		if(HYDRATION_LEVEL_HYDRATED to HYDRATION_LEVEL_WELL_HYDRATED)
			to_chat(usr, div_infobox(span_notice("Я не хочу пить.")))
		if(HYDRATION_LEVEL_THIRSTY to HYDRATION_LEVEL_HYDRATED)
			to_chat(usr, div_infobox(span_warning("Я бы попил.")))
		if(HYDRATION_LEVEL_DEHYDRATED to HYDRATION_LEVEL_THIRSTY)
			to_chat(usr, div_infobox(span_danger("Мне ОЧЕНЬ нужна вода...")))
		if(0 to HYDRATION_LEVEL_DEHYDRATED)
			to_chat(usr, div_infobox(span_userdanger("Я обезвожен!")))

/atom/movable/screen/hydration/proc/update_hydration(new_hydra = 3)
	if(hydration_index == new_hydra)
		return
	hydration_index = new_hydra
	update_appearance()
