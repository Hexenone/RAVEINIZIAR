/datum/antagonist/traitor
	name = "Sleeper agent"
	combat_music = null
	roundend_category = "sleeper agents"
	antagpanel_category = "Sleeper Agent"
	greeting_sound = 'modular_septic/sound/villain/mkultra.ogg'
	attribute_sheet = /datum/attribute_holder/sheet/traitor
	var/datum/weakref/cranial_depressurization_implant

/datum/antagonist/traitor/apply_innate_effects(mob/living/mob_override)
	. = ..()
	if(ishuman(mob_override))
		cranial_depressurization_implant = new /obj/item/organ/cyberimp/neck/selfdestruct(mob_override)
		cranial_depressurization_implant = WEAKREF(cranial_depressurization_implant)

/datum/antagonist/traitor/on_gain()
	. = ..()
	owner.current.flash_darkness(100)
	owner.current.apply_status_effect(/datum/status_effect/thug_shaker)
	owner.current.special_item = /obj/item/modular_computer/laptop/preset/civilian

/datum/antagonist/traitor/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/obj/item/organ/remove_implant = cranial_depressurization_implant?.resolve()
	if(remove_implant)
		remove_implant.Remove(remove_implant.owner, TRUE)
		qdel(remove_implant)
	cranial_depressurization_implant = null

/datum/antagonist/traitor/on_removal()
	. = ..()
	cranial_depressurization_implant = null
	owner.current.remove_status_effect(/datum/status_effect/thug_shaker)

/datum/antagonist/custom/submerc
	name = "Subconscious Mercenary"
	antag_moodlet = null

	show_in_roundend = TRUE
	show_in_antagpanel = FALSE
