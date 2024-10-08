/obj/item/gun/ballistic/revolver
	name = "\improper .357 revolver"
	desc = "A suspicious revolver. Uses .357 ammo." //usually used by syndicates
	icon_state = "revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder
	fire_sound = 'sound/weapons/gun/revolver/shot_alt.ogg'
	load_sound = 'sound/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/weapons/gun/revolver/empty.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 90
	dry_fire_sound = 'sound/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	var/spin_delay = 10
	var/recent_spin = 0
	var/last_fire = 0
	var/can_spin = TRUE

/obj/item/gun/ballistic/revolver/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	. = ..()
	last_fire = world.time

/obj/item/gun/ballistic/revolver/AltClick(mob/user)
	. = ..()
	if(can_spin)
		spin()

/obj/item/gun/ballistic/revolver/verb/spin()
	set name = "Spin Chamber"
	set category = null
	set desc = "Click to spin your revolver's chamber."

	var/mob/M = usr

	if(M.stat || !in_range(M,src))
		return

	if (recent_spin > world.time)
		return
	recent_spin = world.time + spin_delay

	if(do_spin())
		playsound(usr, "revolver_spin", 30, FALSE)
		usr.visible_message(span_notice("[usr] крутит [src] барабан."), span_notice("Я кручу [src] барабан."))
	else
		verbs -= /obj/item/gun/ballistic/revolver/verb/spin

/obj/item/gun/ballistic/revolver/proc/do_spin()
	var/obj/item/ammo_box/magazine/internal/cylinder/C = magazine
	. = istype(C)
	if(.)
		C.spin()
		chamber_round(spin_cylinder = FALSE)

/obj/item/gun/ballistic/revolver/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/* SEPTIC EDIT REMOVAL
/obj/item/gun/ballistic/revolver/examine(mob/user)
	. = ..()
	var/live_ammo = get_ammo(FALSE, FALSE)
	. += "[live_ammo ? live_ammo : "None"] of those are live rounds."
	if (current_skin)
		. += "It can be spun with <b>alt+click</b>"
*/

/obj/item/gun/ballistic/revolver/ignition_effect(atom/A, mob/user)
	if(last_fire && last_fire + 15 SECONDS > world.time)
		. = span_notice("[user] touches the end of [src] to \the [A], using the residual heat to ignite it in a puff of smoke. What a badass.")

/obj/item/gun/ballistic/revolver/detective
	name = "\improper Colt Detective Special"
	desc = "A classic, if not outdated, law enforcement firearm. Uses .38 Special rounds. \nSome spread rumors that if you loosen the barrel with a wrench, you can \"improve\" it."
	fire_sound = 'sound/weapons/gun/revolver/shot.ogg'
	icon_state = "detective"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38
	initial_caliber = CALIBER_38
	alternative_caliber = CALIBER_357
	initial_fire_sound = 'sound/weapons/gun/revolver/shot.ogg'
	alternative_fire_sound = 'sound/weapons/gun/revolver/shot_alt.ogg'
	can_modify_ammo = TRUE
	alternative_ammo_misfires = TRUE
	can_misfire = FALSE
	misfire_probability = 0
	misfire_percentage_increment = 25 //about 1 in 4 rounds, which increases rapidly every shot
	obj_flags = UNIQUE_RENAME
	unique_reskin = list("Default" = "detective",
						"Fitz Special" = "detective_fitz",
						"Police Positive Special" = "detective_police",
						"Blued Steel" = "detective_blued",
						"Stainless Steel" = "detective_stainless",
						"Gold Trim" = "detective_gold",
						"Leopard Spots" = "detective_leopard",
						"The Peacemaker" = "detective_peacemaker",
						"Black Panther" = "detective_panther"
						)

/obj/item/gun/ballistic/revolver/mateba
	name = "\improper Unica 6 auto-revolver"
	desc = "A retro high-powered autorevolver typically used by officers of the New Russia military. Uses .357 ammo."
	icon_state = "mateba"

/obj/item/gun/ballistic/revolver/golden
	name = "\improper Golden revolver"
	desc = "This ain't no game, ain't never been no show, And I'll gladly gun down the oldest lady you know. Uses .357 ammo."
	icon_state = "goldrevolver"
	fire_sound = 'sound/weapons/resonator_blast.ogg'
	recoil = 8
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/nagant
	name = "\improper Nagant revolver"
	desc = "An old model of revolver that originated in Russia. Able to be suppressed. Uses 7.62x38mmR ammo."
	icon_state = "nagant"
	can_suppress = TRUE

	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev762


// A gun to play Russian Roulette!
// You can spin the chamber to randomize the position of the bullet.

/obj/item/gun/ballistic/revolver/russian
	name = "\improper Russian revolver"
	desc = "A Russian-made revolver for drinking games. Uses .357 ammo, and has a mechanism requiring you to spin the chamber before each trigger pull."
	icon_state = "russianrevolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rus357
	var/spun = FALSE

/obj/item/gun/ballistic/revolver/russian/do_spin()
	. = ..()
	if(.)
		spun = TRUE

/obj/item/gun/ballistic/revolver/russian/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(get_ammo() > 0)
		spin()
	update_appearance()
	A.update_appearance()
	return

/obj/item/gun/ballistic/revolver/russian/attack_self(mob/user)
	if(!spun)
		spin()
		spun = TRUE
		return
	return ..()

/obj/item/gun/ballistic/revolver/russian/afterattack(atom/target, mob/living/user, flag, params)
	. = ..(null, user, flag, params)

	if(flag)
		if(!(target in user.contents) && ismob(target))
			/* SEPTIC EDIT REMOVAL
			if(user.combat_mode) // Flogging action
			*/
			//SEPTIC EDIT BEGIN
			var/list/modifiers = params2list(params)
			if(IS_HARM_INTENT(user, modifiers)) // Flogging action
			//SEPTIC EDIT END
				return

	if(isliving(user))
		if(!can_trigger_gun(user))
			return
	if(target != user)
		if(ismob(target))
			to_chat(user, span_warning("A mechanism prevents you from shooting anyone but yourself!"))
		return

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!spun)
			to_chat(user, span_warning("You need to spin \the [src]'s chamber first!"))
			return

		spun = FALSE

		if(chambered)
			var/obj/item/ammo_casing/AC = chambered
			if(AC.fire_casing(user, user))
				playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
				var/zone = check_zone(user.zone_selected)
				var/obj/item/bodypart/affecting = H.get_bodypart(zone)
				/* SEPTIC EDIT REMOVAL
				if(zone == BODY_ZONE_HEAD || zone == BODY_ZONE_PRECISE_EYES || zone == BODY_ZONE_PRECISE_MOUTH)
				*/
				//SEPTIC EDIT BEGIN
				var/static/list/suicidal_zones = list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_MOUTH)
				if(zone in suicidal_zones)
				//SEPTIC EDIT END
					shoot_self(user, affecting)
				else
					user.visible_message(span_danger("[user.name] cowardly fires [src] at [user.p_their()] [affecting.name]!"), span_userdanger("You cowardly fire [src] at your [affecting.name]!"), span_hear("You hear a gunshot!"))
				chambered = null
				return
		/* SEPTIC EDIT REMOVAL
		user.visible_message(span_danger("*click*"))
		*/
		//SEPTIC EDIT BEGIN
		user.visible_message(dry_fire_message)
		//SEPTIC EDIT END
		playsound(src, dry_fire_sound, 30, TRUE)

/obj/item/gun/ballistic/revolver/russian/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	add_fingerprint(user)
	playsound(src, dry_fire_sound, 30, TRUE)
	user.visible_message(span_danger("[user.name] tries to fire \the [src] at the same time, but only succeeds at looking like an idiot."), span_danger("\The [src]'s anti-combat mechanism prevents you from firing it at the same time!"))

/obj/item/gun/ballistic/revolver/russian/proc/shoot_self(mob/living/carbon/human/user, affecting = BODY_ZONE_HEAD)
	user.apply_damage(300, BRUTE, affecting)
	user.visible_message(span_danger("[user.name] fires [src] at [user.p_their()] head!"), span_userdanger("You fire [src] at your head!"), span_hear("You hear a gunshot!"))

/obj/item/gun/ballistic/revolver/russian/soul
	name = "cursed Russian revolver"
	desc = "To play with this revolver requires wagering your very soul."

/obj/item/gun/ballistic/revolver/russian/soul/shoot_self(mob/living/user)
	. = ..()
	var/obj/item/soulstone/anybody/revolver/stone = new /obj/item/soulstone/anybody/revolver(get_turf(src))
	if(!stone.capture_soul(user, forced = TRUE)) //Something went wrong
		qdel(stone)
		return
	user.visible_message(span_danger("[user.name]'s soul is captured by \the [src]!"), span_userdanger("You've lost the gamble! Your soul is forfeit!"))

/obj/item/gun/ballistic/revolver/reverse //Fires directly at its user... unless the user is a clown, of course.
	clumsy_check = FALSE

/obj/item/gun/ballistic/revolver/reverse/can_trigger_gun(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_CLUMSY) || is_clown_job(user.mind?.assigned_role))
		return ..()
	if(process_fire(user, user, FALSE, null, BODY_ZONE_HEAD))
		user.visible_message(span_warning("[user] somehow manages to shoot [user.p_them()]self in the face!"), span_userdanger("You somehow shoot yourself in the face! How the hell?!"))
		user.emote("scream")
		user.drop_all_held_items()
		user.Paralyze(80)
