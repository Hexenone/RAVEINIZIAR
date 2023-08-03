/obj/item/reagent_containers/Initialize(mapload, vol)
	. = ..()
	AddElement(/datum/element/liquids_interaction, on_interaction_callback = /obj/item/reagent_containers/.proc/attack_on_liquids_turf)

/obj/item/reagent_containers/try_splash(mob/user, atom/target)
	if (!spillable)
		return FALSE

	if (!reagents?.total_volume)
		return FALSE

	var/punctuation = ismob(target) ? "!" : "."

	var/reagent_text
	user.visible_message(
		span_danger("[user] splashes the contents of [src] onto [target][punctuation]"), \
		span_danger("You splash the contents of [src] onto [target][punctuation]"), \
		ignored_mobs = target, \
	)

	if (ismob(target))
		var/mob/target_mob = target
		target_mob.show_message(
			span_userdanger("[user] splash the contents of [src] onto you!"), \
			MSG_VISUAL, \
			span_userdanger("You feel drenched!"), \
		)

	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		reagent_text += "[reagent] ([num2text(reagent.volume)]),"

	if(isturf(target))
		var/turf/turf_target = target
		turf_target.add_liquid_from_reagents(reagents)
		if(length(reagents.reagent_list) && thrownby)
			log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]", "in [AREACOORD(target)]")
			log_game("[key_name(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [AREACOORD(target)].")
			message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] at [ADMIN_VERBOSEJMP(target)].")
	else
		reagents.expose(target, TOUCH)

	log_combat(user, target, "splashed", reagent_text)
	reagents.clear_reagents()

	return TRUE

/obj/item/reagent_containers/proc/attack_on_liquids_turf(obj/item/reagent_containers/my_container, turf/my_turf, mob/living/user, atom/movable/liquid/liquids)
	if(IS_HARM_INTENT(user, null))
		return FALSE
	if(!my_container.spillable)
		return FALSE
	if(!user.Adjacent(my_turf))
		return FALSE
	//Use an extinguisher first
	if(liquids.fire_state)
		to_chat(user, span_warning("I can't scoop it! It's on fire!"))
		return TRUE
/*
	if(liquids.liquid_state <= LIQUID_STATE_PUDDLE)
		to_chat(user, span_warning("The puddle is too shallow to scoop anything up!"))
		return TRUE
*/
	var/free_space = my_container.reagents.maximum_volume - my_container.reagents.total_volume
	if(free_space <= 0)
		to_chat(user, span_warning("I can't fit any more reagents inside [my_container]!"))
		return TRUE
	var/desired_transfer = my_container.amount_per_transfer_from_this
	if(desired_transfer > free_space)
		desired_transfer = free_space
	var/datum/reagents/temporary_holder = liquids.take_reagents_flat(desired_transfer)
	temporary_holder.trans_to(my_container.reagents, temporary_holder.total_volume)
	to_chat(user, span_notice("I scoop up a some liquids with [my_container]."))
	qdel(temporary_holder)
	user.changeNext_move(my_container.attack_delay)
	return TRUE
