local mod = Furtherance

local Wiki = {
	EscKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Teleports the player out of the room."},
			{str = "If the player has fewer than 6 hearts, heals them with a combination of red and soul hearts."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The item will vanish once used."},
			{str = "If used during The Beast fight, it will have the same effects, but the player will be teleported to a random position on screen."},
			{str = "If used during The Dogma fight, it will have the same effects and teleport the player to Isaac's bedroom."},
		}
	},
	TildeKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, one of five random debug effects will be applied for the current room."},
			{str = "Possible debug effects are:"},
			{str = "- Infinite HP"},
			{str = "- High Damage"},
			{str = "- Infinite Item Charges"},
			{str = "- High Luck"},
			{str = "- Quick Kill"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Infinite HP won't let your health deplete."},
			{str = "High Damage is a flat +40 damage."},
			{str = "Infinite Item Charges won't let your charge deplete."},
			{str = "High Luck is a flat +50 luck."},
			{str = "Quick Kill will kill all enemies in the room."},
			{str = "The item will spawn with an empty chargebar."},
		},
	},
	AltKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, the floor you are currently on will switch between alt and normal floors."},
			{str = "Basement will become Downpour/Dross, Mausoleum will become Depths/Necopolis/Dank Depths, etc."}
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The item can only be used once per 2 floors."},
			{str = "This item will cause new floors to be generated."},
		},
	},
	SpacebarKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, teleports you to the I AM ERROR room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Once used, you will be stuck in the I AM ERROR room if you have no other means of leaving."},
			{str = "The item will have a 8% chance of deleting itself on use."},
		}
	},
	BackspaceKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, opens the door you last came from."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Does nothing if the previous door is already open."},
		},
	},
	QKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When used, copies whatever is in your pocket slot."},
			{str = "Functions identically to Placebo, Blank Card, and Clear Rune combined."}
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Using this item with ? Card will consume the card and send you to the I AM ERROR room."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "This item will allow you to use pocket actives without their charge going down!"},
		},
	},
	EKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, a Giga Bomb will be spawned at Isaac's position."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Giga Bombs explode and destroy tiles in a diamond shape."},
			{str = "Giga bombs deal 300 damage to enemies."},
			{str = "The explosion itself will harm you, as well as the debris that is flung in random directions."},
		},
	},
	CKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, teleports you to a Library room with 5 different books."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The item will spawn with an empty chargebar."},
			{str = "The item will vanish once used."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "This item is a reference to the mod you are currently reading this description in. :)"},
		},
	},
	CapsKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Makes Isaac large for the current room, increases damage by 7, increases range by 3, and allows Isaac to walk over obstacles to destroy them."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This effect doesn't stack if used multiple times in the same room."},
		},
	},
	EnterKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, the item attempts to open the Boss Rush door on a random wall."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The item will spawn with an empty chargebar."},
			{str = "The item will vanish once used."},
			{str = "The Boss Rush door will attempt to open regardless of in-game time."},
			{str = "The Boss Rush door will fail to open if there is already a door on each wall, but the item will not be consumed."},
			{str = "The Boss Rush door will close if you leave the room you opened it in."},
		},
	},
	ShiftKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, Isaac gains a temporary +15 damage up."},
			{str = "- The damage upgrade scales down to 0 over the course of one minute. The damage consistantly goes down -0.125 per half second."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Due to the high amount of damage you temporarily gain, this item is extremely effective in Greed Mode, as all fights are done within the same room and you are easily able to make the most out of it."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Rock Bottom: The damage up becomes permanent."},
		},
	},
	Ophiuchus = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Gives the player a +0.4 Tears up, +0.3 Damage up, and a soul heart."},
			{str = "Gives the player spectral tears that move in waves, similar to wiggle worm. "},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "All synergies from wiggle worm apply to this item."},
			{str = "This item will not do anything when paired with wiggle worm."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Rework concept by Losfrail!"},
		},
	},
	Chiron = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Gives the player +0.2 Speed up."},
			{str = "Entering a new floor will give a random mapping effect."},
			{str = "Entering a boss room will activate a random book effect."},
			{str = "The books that can be triggered from that list are: The Book of Belial, Book of Revelations, Book of Shadows, Telepathy For Dummies, or Monster Manual."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item will contribute to both Spun and Bookworm."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Rework concept by Losfrail!"},
		},
	},
	Ceres = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Gives the player +0.5 Damage up."},
			{str = "Tears that hit an enemy have a chance to cause the player to produce a special green creep."},
			{str = "Chance increases by 5% for each luck up you have. 5% at 0 luck, 30% at 5 luck, etc."},
			{str = "Enemies that walk over the special green creep will be slowed and a tentacle will attack them."},
			{str = "Enemies will be additionally slowed while being attacked by the tentacle."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Ceres tears will be fired 50% of the time at 9 luck or higher."},
			{str = "The creep will last for 3 seconds."},
			{str = "The tentacle will stay until you leave the room."},
			{str = "The tentacle may also appear if the player takes damage while producing the special creep."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Rework concept by Losfrail!"},
		},
	},
	Pallas = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac's tears will bounce off of the floor for awhile after floating for a short time."},
			{str = "The tears bouncing cause splash damage for every bounce."},
			{str = "Increases tear size by 20%."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Flat Stone: doubles your tear size and gives the player a +16% Damage up."},
			{str = "C Section: Fires fetuses that will bounce off of the floor for awhile after floating for a short time."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Rework concept by Losfrail!"},
		},
	},
	Juno = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Tears that hit an enemy have a chance to chain down the nearest enemy for 5 seconds, which prevents the chained enemy from acting."},
			{str = "Chance increases by 2% for each luck up you have. 2% at 0 luck, 12% at 5 luck, etc."},
			{str = "Once an enemy is chained, the effect will not proc again for 10 seconds."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "At 12 luck or higher, the chance for an enemy to be chained down will always be 25%."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Rework concept by Losfrail!"},
		},
	},
	Vesta = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Gives the player +50% Damage up and spectral tears."},
			{str = "Isaac's tears will become extremely small and slightly transparent."},
			{str = "Isaac's tears have a chance to split into 4 tears."},
			{str = "Chance increases by 10% for each luck up you have. 10% at 0 luck, 60% at 5 luck, etc."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tear size cannot be increased after picking up this item and will be permanently small."},
			{str = "- Pulse Worm can still increase tear size, albeit by very little."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Rework concept by Losfrail!"},
		},
	},
	HolyHeart = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While held, this trinket adds a small chance to gain a holy mantle shield when picking up hearts."},
			{str = "33% for Eternal Hearts, 5% Soul and Blended Hearts, 2% Half Soul Hearts"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If held as characters such as The Lost, picking up hearts that they are able to will still have a chance to grant a mantle."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by HoneyVee!"},
		},
	},
	TechIX = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac's tears are replaced with small ring-shaped lasers."},
			{str = "Unlike Tech X, your shots do not need to be charged."},
			{str = "- The rings have a 0.66x damage multiplier."},
			{str = "- Gives the player a -0.85 Tears down."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The ''R U A Wizard?'' pill effect does work with Tech IX."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "20/20: Fires two Tech IX rings instead of one."},
			{str = "The Inner Eye: Fires three Tech IX rings instead of one."},
			{str = "Eye Sore: Has a chance to fire 1-3 additional Tech IX rings in random directions."},
			{str = "Jacob's Ladder: Tech IX rings gain a light blue tint and generate sparks."},
			{str = "Tammy's Head: Isaac will fire Tech IX rings in all directions."},
			{str = "Monstro's Lung: All tears fired from Monstro's Lung will be replaced with Tech IX rings."},
			{str = "Vesta: Tech IX rings will become extremely small."},
		},
	},
	LeakingTank = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When the player is at one heart or less, they will leave a trail of green creep."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This effect is always active for characters such as The Lost."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by SybilScribble!"},
		},
	},
	UnstableCore = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Every time you use an active item, you create an electric shock around you."},
			{str = "Enemies near the shock will be burned for 3 seconds."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The shock will not harm the player."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by SybilScribble!"},
		},
	},
	Technologyminus1 = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac's tears will occasionally burst into 3 Technology lasers aiming in random directions."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac's tears have a 3.14% chance to burst into lasers every frame."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Mom's Knife: 3 lasers will periodically fire from the knife."},
		},
	},
	BookOfSwiftness = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "For the current room, enemies are slowed, Isaac's speed is increased by 0.50, and his shot speed is decreased by 1.00."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The book's effect does not stack if it is used multiple times in the same room."},
		},
	},
	BookOfAmbit = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants +5 range, +1.5 shot speed, and piercing tears for the current room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Uses can be stacked."},
		},
	},
	PlugNPlay = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When used, a ''glitched'' item will spawn. These items have random combinations of 2-3 effects based on other items."},
			{str = "- Similarly to TMTRAINER, the currently playing music will fade out when used. The silence will remain until another music track plays."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item will not ''glitch'' other items."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Freg!"},
		},
	},
	Cringe = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "All ememies in the room will be briefly frozen when you take damage."},
			{str = "Hurt sound is replaced with Bruh sound effect."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Freg!"},
		},
	},
	ZZZZoptionsZZZZ = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When entering a new treasure room, a ''gitched'' item will spawn in a random area of the room alongside the normal item."},
			{str = "- Similarly to TMTRAINER, the currently playing music will fade out when walking into the treasure room. The silence will remain until another music track plays."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "You can only choose one item."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Joply!"},
		},
	},
	Brunch = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants two full red heart containers."},
			{str = "+0.16 Shot Speed."},
			{str = "Heals 1 additional heart of health."},
		},
	},
	CrabLegs = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants one full red heart container."},
			{str = "+0.2 Speed when moving left or right."},
			{str = "Heals 1 additional heart of health."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Tesseract!"},
		},
	},
	OwlsEye = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Chance to fire a tear that is both piercing and homing."},
			{str = "Chance increases by 8% for each luck up you have. 8% at 0 luck, 48% at 5 luck, etc."},
			{str = "The tear will do 2x damage."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Owl tears will be fired 100% of the time at 12 luck or higher."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Freg!"},
		},
	},
	SlickWorm = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac's tears will bounce off of the walls towards enemies."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Freg!"},
		},
	},
	HeartRenovator = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While held, Heart Renovator will grant a Heart Counter."},
			{str = "- It can be filled by picking up red hearts. When you double tap the drop button, two will be subtracted from the counter and a broken heart will be added."},
			{str = "Using Heart Renovator will remove a broken heart and grant a small Damage up."},
			{str = "Enemies have a 6.25% chance to drop a scared heart when the player kills them."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If the player has no broken hearts to remove, it will not grant a damage up"},
		},
	},
	PharaohCat = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Gives the player a -1.76 Tears down."},
			{str = "When the player shoots, a pyramid formation of tears will be fired."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Mom's Knife will override Pharoh Cat."},
			{str = "Revelation's laser will not be affected, but you will still fire Pyramid shots."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "20/20: Fires two separate Pyramid shots instead of one."},
			{str = "The Inner Eye: Fires three separate Pyramid shots instead of one, and so on."},
			{str = "Eye Sore: Has a chance to fire 1-3 additional Pyramid shots in random directions."},
			{str = "Jacob's Ladder: Pyramid shots generate sparks."},
			{str = "Vesta: Pyramid shots will become extremely small."},
			{str = "Brimstone: Fire five brimstone beams."},
			{str = "Technology, Technology 2, and Tech X: Fire five technology beams."},
			{str = "Tech IX: Fires six Tech IX rings in a pyramid formation."},
			{str = "Dr. Fetus: The bomb will be fired along side the pyramid shots."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Freg!"},
			{str = "Reworked by anchikai!"},
		},
	},
	F4Key = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When used, teleports Isaac to a special room that has not been explored yet."},
			{str = "- The room that you are teleported into depends on what consumables you have the least amount of."},
			{str = "- When used in a room with enemies in it, Isaac is still teleported into a special room, but the room with enemies will be reset."},
			{str = "- The order of types of rooms you will be teleported into is randomized, picked from this list:"},
			{str = "-- Coins:"},
			{str = "--- Arcade."},
			{str = "-- Bombs:"},
			{str = "--- Super Secret Room."},
			{str = "--- Bedroom."},
			{str = "--- Secret Room."},
			{str = "-- Keys:"},
			{str = "--- Shop."},
			{str = "--- Treasure Room."},
			{str = "--- Dice Room."},
			{str = "--- Library."},
			{str = "--- Vault."},
			{str = "- You cannot teleport to Normal Rooms, the Boss room, Sacrifice room, Curse room, Mini-Boss room, Challenge room / Boss Challenge room, Devil room / Angel room, I AM ERROR room, Crawl Spaces, the Boss Rush room, the ??? entrance, Mega Satan, or alternate floor entrances."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If the room it tries to teleport to doesn't exist, the item will fail to teleport."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Schoolbag + Alt Key: The floor Isaac is currently on will be ''closed''. All enemies, obstacles, walls, doors, etc. and both the Alt Key and F4 Key will be removed. This will allow the player to walk through walls as well."},
			{str = "- When the player gets to the boss room, it will be instantly killed and everything will return to normal, bringing back all the obstacles, walls, doors, etc."},
			{str = "-- Any entities that got removed will NOT be brought back. This includes enemies, items, consumables, decoration, etc."},
			{str = "- The currently playing music will fade out when used. The silence will remain until another music track plays."},
		},
	},
	TabKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, the map will be fully revealed and Isaac will be taken to the Ultra Secret Room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If the player has been to the Ultra Secret Room already, they will be teleported back to it and no new item will be generated."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Schoolbag + Alt Key: Sends you to the title screen."},
		},
	},
	ShatteredHeart = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, a broken heart will be removed."},
			{str = "Causes Isaac to slowly generate up to 11 broken hearts while held in rooms with enemies."},
			{str = "Getting near enemies will cause you to rapidly lose broken hearts."},
			{str = "Shots have a chance to charm enemies and make the player produce black slowing creep based off how many broken hearts you have."},
			{str = "- Default chance is 25% with 0 broken hearts and goes up by 5% for each broken heart, with a maximum of 80% (11 broken hearts)."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If the player has no broken hearts to remove, it will do nothing."},
			{str = "This item will not appear in any item pools and can only be accessed by playing as Tainted Leah, using Spindown Dice, or finding it in Death Certificate."},
		},
	},
	Grass = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While held, a one hour countdown will start. When that counter reaches 0, the trinket will be consumed and Gnawed Leaf will spawn."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If you ever drop the trinket, the timer will reset."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Aeronaut!"},
		},
	},
	KeysToTheKingdom = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When used, it has a variety of effects given the current circumstances:"},
			{str = "- If used in a active room, all enemies will be ''spared'' and removed from the room, granting temporary stats for the floor."},
			{str = "- If used on a boss, a 30 second spare timer will begin, similarly to Baby Plum. A beam of light will shine on the boss, slowly shrinking and getting brighter as the timer decreases. Once the timer reaches 0, the boss will be spared and Isaac will gain a permanent stat increase."},
			{str = "- When used in a devil room, all deals will become free."},
			{str = "- When used in a angel room, a random key piece is spawned."},
			{str = "-- If the player already has a key piece, the other respective key piece will spawn."},
			{str = "-- If the player already has both key pieces, a random angel item will spawn instead."},
			{str = "When Isaac kills an enemy while holding this item, they have a chance to give a soul based on their Max HP which is what charges this item."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Keys to the Kingdom can't be used in rooms without enemies."},
			{str = "Keys to the Kingdom can't be charged when clearing rooms or picking up batteries."},
		},
	},
	MuddledCross = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, the entire screen will be flipped vertically and tinted red and the enemies will be harder to defeat, but you gain double the items and pickups."},
			{str = "- If Isaac uses it on Basement, the floor will look like Caves and so on."},
			{str = "- While flipped, Isaac will lose half a heart every 7 seconds."},
			{str = "The item pool for all items while flipped is the Ultra Secret Room item pool."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "When entering a new floor while flipped, you will no longer be flipped."}
		},
	},
	AlabasterScrap = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Increases Isaac's damage by 0.5 for each angelic item he possesses."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Having more than one of the same item will still increase its damage."},
			{str = "Items that count towards the Seraphim transformation are what increases Isaac's damage."},
		},
	},
	LeahsLock = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "25% chance to fire either charm or fear tears."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The chance to proc is capped at 50% with 10 luck."},
		},
	},
	BindsOfDevotion = {
		{ -- Effects
			{str = "Effects", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns Jacob as an extra character alongside Isaac, who is controlled exactly like Esau."},
			{str = "- Jacob will have his base stats."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Jacob's health is displayed at all times above his head."},
			{str = "- If Curse of the Unknown is in effect, his health bar will be hidden the same way as Isaac's."},
			{str = "Jacob is able to pick up items independently from Isaac. He has his own inventory that is not shared with the actual player."},
			{str = "- This inventory is not displayed on the HUD."},
			{str = "- When Jacob dies, the items he obtained are lost forever."},
			{str = "Jacob is not able to pick up any active items, trinkets or consumables."},
			{str = "Jacob's speed is independent from Isaac's. Obtaining speed items will grant speed only to the character that picked up the item."},
			{str = "Similarly to Esau, when the player places a bomb, Jacob will place another at no cost."},
			{str = "Jacob is not able to walk through doors or crawlspaces."},
			{str = "- Although he is able to enter the beam of light that takes Isaac to the next floor after the Mom fight, the one spawned by Genesis, as well as entering the big chest after defeating bosses in later stages."},
			{str = "Jacob is able to obtain items that grant extra lives and use them normally. If one of these items transforms the player into another character upon death, this will work too and the player will instead get a different controllable character that inherits the new character's stats, e.g. Lazarus Risen from Lazarus' Rags or Dark Judas from Judas' Shadow."},
			{str = "The player cannot get any Jacob unlocks by using Binds of Devotion."},
			{str = "With item choice pedestals, the player can pick up both of them if he times them perfectly, similarly to Jacob and Esau."},
			{str = "Even though Jacob is considered a second character, the run ends if the original character dies."},
			{str = "Technically, Binds of Devotion is marked as a familiar item in the mod's files, although familiar-modifying items, such as BFFS! don't have any effect on Jacob."},
			{str = "Unlike Jacob and Esau, invincibility frames are not shared between the characters, so the player can easily get ''double-tapped'' if not careful."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Extension Cord: Beams of electricity will flow between Jacob and the player's original character."},
			{str = "Binds of Devotion: Only one Jacob can be out at a time. When one dies, a new one will spawn."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Genesis: Will not grant item choices for any of Jacob's collected items."},
		},
	},
	ParasiticPoofer = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Taking damage has a 20% chance to double Isaac's current number of red hearts."},
			{str = "- A broken heart will also be added to Isaac."},
			{str = "- Doesn't add new red heart containers, just fills empty ones."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If Isaac takes fatal damage and the effect procs, it can save him from death."},
			{str = "- A broken heart will still be added."},
			{str = "This item can kill you by setting you to 12 broken hearts."},
		},
	},
	Butterfly = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Taking damage will cause Isaac to fire tears in random directions for two seconds."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "These tears are affected by Isaac's stats and tear modifiers."},
			{str = "- The tears' damage is 50% of Isaac's damage."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Spoon Bender: Fired tears will home in on enemies."},
			{str = "My Reflection: Fired tears will swarm around Isaac."},
			{str = "Ipecac: Fired tears will become explosive."},
			{str = "Rubber Cement: Fired tears will become bouncy."},
			{str = "Anti-Gravity: Fired tears will bunch up in one location until you stop shooting."},
			{str = "Tiny Planet: Fired tears will orbit around Isaac."},
			{str = "Evil Eye: Fired tears will occasionally be Evil Eye tears."},
			{str = "Varicose Veins: Will fire tears from both Varicose Veins and Butterfly."},
		},
	},
	SpiritualWound = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "A cursor will appear below enemies which is controlled by firing."},
			{str = "Replaces tears with multiple thin lasers."},
			{str = "The lasers will be aimed at the cursor which home on the nearest enemy until the enemy is dead."},
			{str = "- The cursor will automatically move to the next nearest enemy."},
			{str = "Deals 0.33x Isaac's damage per tick."},
			{str = "Enemies killed have a 5% chance to heal 1/2 red heart."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Taking Spiritual Wound as Tainted Miriam does nothing."},
		},
	},
	CaduceusStaff = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants two soul hearts."},
			{str = "Upon taking damage, there is a 1% chance to negate the damage taken and grant a Mantle."},
			{str = "- The chance is doubled every hit and resets back to 1% once the effect procs."},
		},
	},
	Polydipsia = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac's tears are fired in an arc. Upon hitting the floor, an obstacle, or an enemy they burst into a puddle of water."},
			{str = "Tears down - (Delay X 2) + 10"},
			{str = "- The puddle of water deals 33% of Isaac's damage."},
			{str = "- The puddle of water lasts for 3 seconds."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Higher shot speed lowers the arc if the shot, whereas lower speed heightens it, resulting in a very minor change in effective range."},
			{str = "The tear height stat is entirely ignored for the shot."},
			{str = "The tear has a 1.4x size multiplier."},
		},
	},
	Kareth = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "All future items found in the run are replaced with 1-3 trinkets."},
			{str = "The amount of trinkets depends on what the item's quality was:"},
			{str = "- 0-1: 1 Trinket."},
			{str = "- 2-3: 2 Trinkets."},
			{str = "- 4: 3 Trinkets."},
			{str = "All trinkets that Isaac picks up will be directly added to his inventory."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Items spawned in on a pedestal will also be converted into trinkets."},
			{str = "Already existing item pedestals will only convert if Isaac walks into the room their in."}
		},
	},
	PillarOfFire = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac will burst into five flames when hit, dealing damage to enemies."},
			{str = "- Chance to burst into flames increases by 5% for each luck up."},
			{str = "Flames will deal contact damage and periodically shoot red tears at enemies."},
			{str = "- The flames' tears will always deal 3.5 damage."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "At 19 luck, the chance to burst into flames will be 100%."},
		},
	},
	PillarOfClouds = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When walking through the doorway to an uncleared room, Isaac will occasionally skip that room and immediately walk into the room right after it."},
			{str = "- The chance to skip a room is 10%."},
			{str = "- Works even if there's no subsequent room, allowing Isaac to walk into a Red Room."},
			{str = "-- Cannot be used to go out of bounds."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The chance to skip rooms can not be increased or decreased."},
		},
	},
	FirstbornSon = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Attacks the enemy with the highest enemy in the room with a powerful shot."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Will only fire one shot per room."},
		},
	},
	MiriamsWell = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a well that orbits Isaac and blocks enemy shots."},
			{str = "When the well blocks a shot or collides with an enemy, the well will tip over and spill water creep, which deals 0.5x of Isaac's damage."},
			{str = "- The well won't be active for 8 seconds after tipping over."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Miriam's Well does not deal contact damage."},
			{str = "The well has a considerably larger hitbox than other orbital familiars."},
		},
	},
	Quarantine = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon entering a new room, applies fear to all enemies for 6 seconds."},
			{str = "- Enemies near Isaac during that period are poisoned."},
		},
	},
	BookOfGuidance = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, opens all doors for the current floor, similarly to Mercurius."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "While Door Stop has a similar effect, Book of Guidance has the added benefit of opening the doors that Isaac did not enter through."},
			{str = "Does not open the Boss Rush door."},
			{str = "Does not open doors to Red Key or Cracked Key rooms if that door was created while there are enemies inside."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "4.5 Volt/ Jumper Cables: Provides infinite charges by clearing some enemies then leaving the room, and repeating."},
			{str = "Charm of the Vampire/ Gimpy: Allows the possibility to farm health."},
			{str = "Head of the Keeper: With enough patience, coins can be farmed."},
		},
	},
	JarOfManna = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Killing an enemy spawns a Manna Orb, which will quickly vanish."},
			{str = "Manna Orbs can be collected by walking over them, which will charge this item."},
			{str = "Upon use, the pickup Isaac needs the most (ie a heart or key) will be granted to him."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Whatever Isaac has the least of is what will counted as being ''needed the most.''"},
		},
	},
	Tambourine = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, creates a whirlpool at the player's position that has a rift-like effect on enemies, pulling them in and damaging them."},
		},
	},
	TheDreidel = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, 1-4 random stats will be reduced and 1 random item will be spawned from the current room's item pool."},
			{str = "The quality of the item will be how many stats were reduced."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The amount of stats lowered cannot be controlled."},
		},
	},
	Apocalypse = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Removes all passive items Isaac possesses."},
			{str = "- Increases 2 random stats for each item removed."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Duplicate items will also be removed."},
		},
	},
	AbyssalPenny = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns Holy Water creep every time a coin is picked up."},
		},
	},
	SalineSpray = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac's tears have a 5% chance to be ice tears, which slows enemies and freeze monsters they kill."},
		},
	},
	AlmagestScrap = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While held, replaces Item Rooms with Planetariums."},
			{str = "Planetarium items now cost 1-3 broken hearts."},
			{str = "The amount of broken hearts depends on what the item's quality was:"},
			{str = "- 0-1: 1 Broken Heart."},
			{str = "- 2-3: 2 Broken Hearts."},
			{str = "- 4: 3 Broken Hearts."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The price for items cannot be increased or decreased by the player."},
		},
	},
	WormwoodLeaf = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Adds a 2% chance to block any damage hitting Isaac directly. When effectively blocking damage, Isaac will briefly become stone, similarly to Gnawed Leaf."},
			{str = "While stone, Isaac can no longer move. This will last for 1 second."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac can still shoot while stone."},
			{str = "Once freed from stone, Isaac still has damage protection for half a second to prevent unfair damage."},
		},
	},
	OldCamera = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, Isaac's current room will be ''saved''."},
			{str = "Using Old Camera again will bring Isaac back to the saved room, and will have to be cleared again."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If used on a cleared room, enemies will still respawn if it had any."},
			{str = "If the room had no enemies, Isaac will still be brought back to that room but it will not have to be cleared."},
		},
	},
	AlternateReality = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, Isaac will be transported to a random floor."},
			{str = "- The map will be fully revealed for that floor."},
			{str = "Isaac will be put inside of a random room on the floor."},
			{str = "- It is technically possible that the starting room is randomly picked."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The random floor you are brought to will never be from the alt path."},
			{str = "The random floor can be anywhere from Basement I to Dark Room/The Chest."},
			{str = "- This includes the Blue Womb."},
		},
	},
	WineBottle = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Every 15 shots, Isaac will fire a large, high speed cork."},
			{str = "- The cork has a 2x damage and 1.5x size multiplier."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The speed of the Cork is Tear Velocity x (Shot Speed x 1.25)"},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Monstro's Lung: Each tear fired from Monstro's Lung counts towards a tear fired, allowing for Cork tears to be fired very frequently."},
			{str = "20/20: Cuts the amount of tears required to fire a Cork in half."},
			{str = "Cork: The amount of tears it takes to fire a Cork is reduced by how many duplicates Isaac has."},
			{str = "- It is capped at 14 Corks, allowing for a Cork to be fired every other tear."},
		},
	},
	HeartEmbeddedCoin = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "If Isaac would normally not be able to pick up any red hearts, they will instead grant coins."},
			{str = "- One half red heart equals one coin, a full heart equals two, and so on."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Coins will only be granted if you have full red health/can't pick up red hearts and you have less than the maximum amount of coins allowed."},
		},
	},
	Mandrake = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns two items instead of one in each Treasure Room. Only one item can be chosen, the other disappears."},
			{str = "The second item will always be a familiar."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If the Treasure Room has already been entered and the item was not taken, then picking up Mandrake later on the same floor will not retroactively add a second item to the room."},
			{str = "In Downpour, Dross, Mines, Ashpit, Mausoleum, and Gehenna, Treasure Rooms will have two known and one unknown items, instead of the usual one known and one unknown."},
		},
	},
	LittleSister = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},

		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			
		},
	},
	Flux = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+9.75 Range up and Spectral tears."},
			{str = "Isaac now fires a tear from the back of his head and his tears now only move when he is moving."},
			{str = "The speed of the tears use this equation: Speed X (2 + Shot speed X 1.25)"},
			{str = "The tear fired from the back of Isaac's head will have the exact opposite movement of the normally fired tear."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "While moving, Isaac's tears will always be faster than Isaac."},
		},
	},
	CosmicOmnibus = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, randomly teleports Isaac to a non-normal room."},
			{str = "There is always a 30% chance to teleport to a Planetarium regardless of the Planetarium chance or if there is one on the floor."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac will only be teleported to rooms that have not been explored."},
			{str = "- Once all non-normal rooms have been explored, you will always be teleported to a new Planetarium room."},
			{str = "You cannot be teleported to the Ultra Secret room."},
		},
	},
	LittleRaincoat = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Every 6 hits, Isaac will get a Power Pill like effect."},
			{str = "Food items have a 6% chance to be rerolled into a new item."},
			{str = "Decreases Isaac's size, making him less likely to be hit."},
		},
	},
	BloodCyst = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Entering an uncleared room will spawn a Blood Cyst in a random position in the room."},
			{str = "Shooting or walking into the Cyst will make it burst into 8 tears."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The tears fired from the Cyst deal 3.5 damage."},
		},
	},
	Polaris = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants a star familiar that closely follows Isaac."},
			{str = "It will change color each time Isaac enters a new room with a total of 5 possible colors of varying rarity:"},
			{str = "- Red: 31.4% chance. +2 Shot Speed, 0.5x tear size."},
			{str = "- Orange: 20.8% chance. +1.5 Shot Speed, +0.5 Damage."},
			{str = "- Yellow: 28.3% chance. +1 Shot Speed, +1 Damage, increases chance of room clear award being a heart, gain an extra heart container."},
			{str = "- White: 16.4% chance. +0.5 Shot Speed, +1.5 Damage, 20% chance to fire Holy Shots."},
			{str = "- Blue: 3.1% chance. +2.0 Damage, 2x tear size, tears inflict burning."},
		},
	},
	D9 = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, replaces every trinket in the current room with other random trinkets."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Car Battery: Re-rolls twice instantly without any benefits."},
		},
	},
	PolarityShift = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Polarity Shift charges up with kills that would normally heal Tainted Miriam if she was not at full health."},
			{str = "- Takes 6 charges to fully charge, the equivalent of 6 healing procs (or 3 full red hearts)"},
			{str = "- It does not charge with clearing rooms or taking batteries."},
			{str = "On use, Tainted Miriam's ''Spiritual Wound'' attack is converted into Lightning bolts for the current room. Additionally, her Fire Rate is increased by 1 and her movement speed is increased by 0.4."},
			{str = "Lightning bolts deal 2x Tainted Miriam's damage on the first frame and continue to do 0.15x damage per frame over time while tethered."},
			{str = "- Lightning bolts do not heal."},
			{str = "Using Polarity Shift again while its effect is active will deactivate the effect, returning her to Spiritual Wound and resetting her Fire Rate and movement speed boosts."},
		},
	},
	LeahsHairTie = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	LeahsTornHeart = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	PetersHeadband = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	PetersBloodyFracture = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	MiriamsHeadband = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	MiriamsPutridVeil = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	BookOfBooks = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, every book item will be activated at once."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Works with modded books."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by retro100!"},
		},
	},
	Keratoconus = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "+0.2 Range."},
			{str = "-0.5 Shot Speed."},
			{str = "Chance to fire a light beam tear with a godhead-like aura that can shrink or grow non-boss enemies."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Once the enemies' size is changed, it can't be changed again."},
		},
	},
	Servitude = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "While charged, a marker appears below the closest item pedestal."},
			{str = "Upon use, a counter appears below Isaac, starting at 7 and counting down to 0."},
			{str = "The count goes down by 1 for every room cleared without taking damage."},
			{str = "- If Isaac clears 7 rooms without taking damage, a copy of the marked item will spawn for Isaac to pickup."},
			{str = "- If he fails, the timer will end and Isaac gains 1 broken heart."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Servitude cannot be charged while the timer is active."},
		},
	},
	Cardiomyopathy = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When an picking up a red heart, Isaac will be invulnerable for 0.5 seconds."},
			{str = "Isaac has a Luck% chance to gain a health up when picking up a red heart."},
			{str = "- 1 Luck translates to 1%, 20 Luck translates to 20% and so on."},
			{str = "- The health up will not be filled with red hearts."},
			{str = "All bone hearts you have or pick up will be converted into a empty heart container."},
		},
	},
	Altruism = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Donating to any type of beggar has a 25% chance do one of the following:"},
			{str = "- Heal half a red heart."},
			{str = "- Recieve the resource you donated back."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If you recieve your resource back, you'll gain one of the following:"},
			{str = "- Beggar: A penny."},
			{str = "- Demon Beggar: A half soul heart."},
			{str = "- Battery Beggar: A penny."},
			{str = "- Key Beggar: A key."},
			{str = "- Bomb Beggar: A bomb."},
			{str = "- Rotten Beggar: A coin."},
		},
	},
	Sunscreen = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Isaac has a 25% chance to block/ignore fire damage."},
		},
	},
	SecretDiary = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, you will gain your current character's Birthright effect for the room."},
		},
	},
	NilNum = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Taking damage has a 2% chance to destroy the trinket and spawn a duplicate of one of your items."},
		},
	},
	D16 = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, reroll Isaac's current health."},
			{str = "- Red heart containers, bone hearts, soul hearts, black hearts, and eternal hearts all get rerolled into a random assortment of the same value."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "When used with Keeper, drains up to 2 coin heart containers and spawns that many number of random pick ups."},
			{str = "- Keeper's health containers won't be removed."},
		},
	},
	Iron = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an Iron familiar that orbits around Isaac."},
			{str = "Firing a tear through it will cause the tear to double in size, double its damage, and have the effects of Fire Mind."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	BI84 = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Has a 25% chance to grant the effects of a random Technology item each room."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Mom's Box: Increases the chance of the effect occuring."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	RottenApple = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon pickup, grants a random worm trinket."},
			{str = "+2 Damage."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	GlitchedPenny = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon picking up a coin, there is a 25% chance to activate a random active item."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	BeginnersLuck = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants an additonal +10 Luck every floor."},
			{str = "Lose 1 luck for every unexplored room you enter."},
			{str = "- It will only remove luck from the bonus."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	DadsWallet = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon pickup, grants 2 random consumables of the following type:"},
			{str = "- Credit Card"},
			{str = "- A Card Against Humanity"},
			{str = "- Get Out Of Jail Free Card"},
			{str = "- Holy Card"},
			{str = "- Wild Card"},
			{str = "- Emergency Contact"},
			{str = "- Dice Shard"},
			{str = "- Cracked Key"},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	ChiRho = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "All of Isaac's lasers now home on enemies."},
			{str = "- Technology 2 is not affected."},
			{str = "They will stay put where they were fired, similarly to Anti-Gravity."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Chi Rho will not do anything by itself."},
		},
	},
	LeahsHeart = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "1.2x damage multiplier until you use an active item."},
			{str = "- A soul heart and Holy Mantle shield will be granted when using an active."},
			{str = "The damage multiplier will return when going to a new floor."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Damage multipliers won't stack."},
			{str = "A soul heart and Holy Mantle shield are only granted when using an active item for the first time per floor."},
		},
	},
	Pallium = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon clearing a room, 1-3 Minisaacs are spawned."},
			{str = "All Minisaacs spawned from Pallium will be removed when going to the next floor."},
		},
	},
	EscapePlan = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "10% chance to teleport to the starting room when hit."},
		},
	},
	Epitaph = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Dying with this trinket will cause a tombstone to spawn on the floor you died on in the next run."},
			{str = "Bombing it 3 times will spawn 3-5 coins, 2-3 keys, and a copy of your first and last passive item from the previous run."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The tombstone only shows up in the run immediately after the one you died in."},
		},
	},
	LeviathansTendril = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "25% chance for enemy shots to deflect away from Isaac."},
			{str = "10% chance to fear nearby enemies."},
			{str = "+5% chance to do both if you have the Leviathan transformation."},
		},
	},
	KeyToThePit = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Allows you to walk into challenge rooms regardless of your current health."},
		},
	},
	HammerheadWorm = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Each tear's damage, range, and shot speed is slightly randomized."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	ColdHearted = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Freezes enemies upon contact with Isaac."},
			{str = "- Bosses and Mini-Bosses cannot be frozen."},
			{str = "Frozen enemies can be kicked, sliding across the floor and then shattering, releasing 10 icicle tears outward. They will also shatter immediately if hit by an explosion."},
			{str = "- These icicles can either slow enemies for 4 seconds or turn them into ice statues as well if they deal the lethal hit."},
			{str = "Killing an enemy by freezing them will prevent any on-death effects to occur (such as explosions or some champions), even after shattering."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	RottenLove = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns 2-3 Rotten Hearts."},
			{str = "Spawns 2-3 Bone Hearts."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	Rue = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Fires a brimstone laser towards the nearest enemy upon taking a hit."},
			{str = "- Fires in a random direction instead if there are no enemies."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	Exsanguination = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "All hearts have a 50% smaller chance to spawn."},
			{str = "Any heart when picked up gives a permanent +0.1 damage up."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by Oddvio!"},
		},
	},
	PrayerJournal = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, either a 45% chance to grant a soul heart, 45% chance to grant a black heart, or a 10% chance to grant a broken heart."},
		},
	},
	BookOfLeviticus = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns 6 clusters pf random rocks and other obstacles."},
			{str = "Spawned clusters will often contain tinted rocks."},
			{str = "The pathways between exits can't be blocked."},
		},
	},
	MoltenGold = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon taking damage, there is a 25% chance to activate the effect of a random rune."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The only runes that can be activated are:"},
			{str = "- Hagalaz"},
			{str = "- Jera"},
			{str = "- Ehwaz"},
			{str = "- Dagaz"},
			{str = "- Ansuz"},
			{str = "- Perthro"},
			{str = "- Berkano"},
			{str = "- Algiz"},
		},
	},
	Trepanation = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Every 15 shots, Isaac will fire a Haemolacria tear."},
			{str = "- The Haemolacria tear has a 2x damage multiplier."},
		},
	},
	Astragali = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, replaces every chest in the current room with other random chests."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Car Battery: Re-rolls twice instantly without any benefits."},
		},
	},
	Liberation = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Killing enemies has a 5% chance to grant flight and open all doors for the room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Leaving the room if its uncleared won't keep the door open."},
		},
	},
	SeveredEar = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "X1.2 damage multiplier."},
			{str = "X0.8 tears multiplier."},
			{str = "+1.2 range."},
			{str = "-0.6 shot speed."},
		},
	},
	GoldenPort = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "If Isaac's Active Item charge is not full, he can use it to buy a charge and add 6 pips to it for 5 cents."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The additional pips will overcharge Isaac's Active item if his current charge + the additional 6 is greater than full."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Car Battery: If Isaac has 10 cents or more, it will add 12 pips."},
		},
	},
	ItchingPowder = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon taking damage, Isaac will take a second ''fake'' hit after 1 second."},
			{str = "- The fake hit works similarly to Dull Razor, which will not hurt you."},
		},
	},
	Parasol = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "All of Isaac's familiars will block enemy shots."},
		},
	},

	-- Pocket Items
	SoulOfLeah = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants a broken heart for every uncleared room on the floor."},
			{str = "Each broken heart will give a +0.75 damage up."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If there are 12 or more uncleared rooms, it will kill you."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Getting this soul stone as Leah or Tainted Leah effectively acts as a free large damage upgrade if used correctly."},
		},
	},
	SoulOfPeter = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, 5 random rooms will be generated next to other random rooms."},
			{str = "- The rooms generated will be revealed on the map."},
			{str = "- The rooms generated can be any room type."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If for any reason 5 rooms can't be generated, the next highest amount will attempt to generate."},
			{str = "- Nothing will happen if no rooms can be generated at all."},
			{str = "The newly generated rooms can generate off of any room type except for Secret, Super Secret, and Ultra Secret rooms."},
		},
	},
	SoulOfMiriam = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, it will rain in uncleared rooms, building up a water puddle over time that grows in size until it covers the whole room."},
			{str = "- This puddle deals 0.33x Isaac's damage every 0.5 seconds."},
			{str = "This effect persists through rooms and floors and lasts a total of 40 seconds."},
		},
	},
	TwoOfShields = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Doubles your active charge."},
			{str = "If you have no active charge, gives you 2 instead."},
		},
	},
	AceOfShields = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Turns all pickups, chests and non-boss enemies in the room into micro batteries."},
		},
	},
	TrapCard = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Chains down the nearest enemy, completely preventing them from acting for 5 seconds. (This is the same effect as Anima Sola.)"},
		},
	},
	KeyCard = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Creates a trapdoor leading to the Member Card Shop."},
		},
	},
	EssenceOfLove = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, all enemies will be permanently charmed."},
		},
	},
	EssenceOfHate = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, broken hearts will be added to Isaac until he reaches 11 of them."},
			{str = "For each broken heart added, a random pickup will be spawned."},
		},
	},
	EssenceOfLife = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, summons minisaacs on top of each enemy in the room."},
		},
	},
	EssenceOfDeath = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, kills all non-boss enemies in the room."},
			{str = "For each enemy killed, a swarm fly orbital will be added."},
		},
	},
	EssenceOfProsperity = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, a rain drop will fall on every enemy."},
			{str = "When the rain drop hits the enemy, it will deal 0.66x of Isaac's damage and slow them for 5 seconds."},
		},
	},
	EssenceOfDrought = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, all non-boss enemies will begin to bleed out."},
			{str = "When they die, they will become frozen solid."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "When in a room that has rain, it will cause it to stop."},
		},
	},
	HeartacheUp = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Adds one broken heart upon use."},
			{str = "Effect (Horse)", fsize = 2, clr = 3, halign = 0},
			{str = "Adds two broken hearts."},
		},
	},
	HeartacheDown = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Removes one broken heart upon use."},
			{str = "Effect (Horse)", fsize = 2, clr = 3, halign = 0},
			{str = "Removes two broken hearts."},
		},
	},
	GoldenCard = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, a random card effect will be used."},
			{str = "- There is a 50% chance for the card to destroy itself."},
		},
	},
	HopeCard = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "For the duration of the current room, killing enemies has a chance to spawn pickups."},
		},
	},
	ReverseHopeCard = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Teleports Isaac into an extra challenge room."},
			{str = "The room has an exit door, which leads Isaac back to where he used XXIII - Hope?."},
		},
	},
	FaithCard = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns a Confessional."},
		},
	},
	ReverseFaithCard = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Spawns two Moon Hearts."},
		},
	},
	CharityCard = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "On use, apply Jar of Manna effect 3 times, giving Isaac the pickups he needs the most."},
			{str = "If no pick ups are needed, permanently increases the stats he needs the most by 0.5."},
		},
	},
	ReverseCharityCard = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "On use, mimics the effect of Diplopia."},
			{str = "- All items spawned cost money."},
		},
	},
	SoulOfEsther = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	EssenceOfBravery = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	EssenceOfCowardice = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Takes you to a Gehenna item room with a free devil deal item."},
		},
		{ -- Credits
			{str = "Credits", fsize = 2, clr = 3, halign = 0},
			{str = "Concept by nightshade!"},
		},
	},

	-- Characters
	Leah = {
		{ -- Start Data
			{str = "Start Data", fsize = 2, clr = 3, halign = 0},
			{str = "Items:"},
			{str = "- Heart Renovator"},
			{str = "Stats:"},
			{str = "- HP: 2 Red Hearts, 1 Broken Heart"},
			{str = "- Speed: 1.00"},
			{str = "- Tear rate: 2.50"},
			{str = "- Damage: 3.14"},
			{str = "- Range: 2.61"},
			{str = "- Shot speed: 1.00"},
			{str = "- Luck: 0.00"},
		},
		{ -- Traits
			{str = "Traits", fsize = 2, clr = 3, halign = 0},
			{str = "Leah's pocket active item ''Heart Renovator'' grants a Heart Counter."},
			{str = "- It can be filled by picking up red hearts. When you hold the drop button, two will be subtracted from the counter and a broken heart will be added."},
			{str = "- Using Heart Renovator will remove a broken heart and grant a small Damage up."},
			{str = "For each broken heart Leah has, she will gain an extra +1 range."},
			{str = "Enemies have a 6.25% chance to drop a scared heart when Leah kills them."},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = "For every 20th enemy she kills, one broken heart will be removed and gain a small Damage up."},
			{str = "- Damage gained through kills is half as effective as Damage through Heart Renovator."},
			{str = "The heart counter will be capped at 999 instead of 99."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Leah starts with a slightly lower damage and tears stat than most characters. However, strategic use of the Heart Counter and using Heart Renovator will help combat the lower damage and tears you start with."},
			{str = "You have to find a good balance between keeping broken hearts for range and removing them for damage."},
			{str = "Leah's range is capped at 16."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Leah is a reference to the important figure in the Judeo-Christian tradition, the unloved wife of the Biblical patriarch Jacob. The Lord blessed Leah with 6 sons and 1 daughter. Her six sons became the representatives of six of the twelve tribes of Israel, represented by the 6 coins Leah starts the game with."},
			{str = "Leah starts with 3.14 damage because anchikai likes pi."},
			{str = "Leah's base range with no broken hearts is low because of her gimmick with broken hearts and is specifically 1.61 and as a reference to the golden ratio."},
			{str = "- Have you noticed that I like mathematics?"},
		},
	},
	TaintedLeah = {
		{ -- Start Data
			{str = "Start Data", fsize = 2, clr = 3, halign = 0},
			{str = "Items:"},
			{str = "- Shattered Heart"},
			{str = "Stats:"},
			{str = "- HP: 1 Black Heart, 11 Broken Hearts"},
			{str = "- Speed: 0.95"},
			{str = "- Tear rate: 6.00"},
			{str = "- Damage: 1.50"},
			{str = "- Range: 6.50"},
			{str = "- Shot speed: 1.00"},
			{str = "- Luck: -3.00"},
		},
		{ -- Traits
			{str = "Traits", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Leah cannot gain red heart containers. If an item would grant her a red heart container (including an empty one), it adds a black heart instead."},
			{str = "Her shots have a chance to charm enemies and make her produce black slowing creep based off how many broken hearts she has."},
			{str = "- Default chance is 25% with 0 broken hearts and goes up by 5% for each broken heart, with a maximum of 80% [11 broken hearts]."},
			{str = "When she is near an enemy, her tear rate will lower drastically and her broken hearts will steadily decrease to none. Once she is no longer near an enemy, her tear rate will go back up to where it was and her broken hearts will slowly increase back to 11."},
			{str = "- You will only regenerate broken hearts if there are enemies present in the room."},
			{str = "Tainted Leah's movement speed is dependent on how many broken hearts she has. Each broken heart is worth -0.05 speed."},
			{str = "Tainted Leah cannot permanently remove broken hearts, with the exception of Birthright."},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Leah will no longer constantly refill back to 11 broken hearts. She will instead refill to only 6 broken hearts, allowing for a max HP of 6 hearts."},
			{str = "Each broken heart is now worth +0.05 speed."},
			{str = "Gain an additional 20% chance to charm enemies, with a maximum of 100% [11 broken hearts]."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Leah starts with a much higher tear stat than most characters, making her more effective at the start. However, she has much lower damage than average, which means she has to land more shots."},
			{str = "Her HP is incredibly difficult to manage. The best ways to sustain higher than one heart is to frequently use her pocket active item and to get close to enemies."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The achievement for unlocking Tainted Leah is ''The Unloved''. This is a reference to Leah being the unloved wife of the Biblical patriarch Jacob."},
		},
	},
	Peter = {
		{ -- Start Data
			{str = "Start Data", fsize = 2, clr = 3, halign = 0},
			{str = "Items:"},
			{str = "- Keys to the Kingdom"},
			{str = "Stats:"},
			{str = "- HP: 2 Red Hearts, 1 Soul Heart"},
			{str = "- Speed: 0.75"},
			{str = "- Tear rate: 1.52"},
			{str = "- Damage: 3.00"},
			{str = "- Range: 7.00"},
			{str = "- Shot speed: 1.00"},
			{str = "- Luck: 0.00"},
		},
		{ -- Traits
			{str = "Traits", fsize = 2, clr = 3, halign = 0},
			{str = "Peter starts with a pocket active item called ''Keys to the Kingdom.'' When used, it has a variety of effects given based onthe current circumstances:"},
			{str = "- If used in a active room, all enemies will be ''spared'' and removed from the room, granting temporary stats for the floor."},
			{str = "- If used on a boss, a 30 second spare timer will begin. A beam of light will shine on the boss, slowly shrinking and getting brighter as the timer decreases. Once the timer reaches 0, the boss will be spared and Isaac will gain two permanent stat increases."},
			{str = "- When used in a devil room, all deals will become free."},
			{str = "- When used in a angel room, a key piece is spawned."},
			{str = "-- If Peter already has a key piece, the other respective key piece will spawn."},
			{str = "-- If Peter already has both key pieces, a random angel item will spawn instead."},
			{str = "When Peter kills an enemy, they have a chance to give a soul based on their Max HP."},
			{str = "Charged with soul hearts."},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = "Peter's spare timer is now 15 seconds instead of 30."},
			{str = "Peter now gains three permanent stat increases from sparing bosses."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Keys to the Kingdom can't be used in rooms without enemies."},
			{str = "Keys to the Kingdom can't be charged when clearing rooms or picking up batteries."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Peter was one of the Twelve Apostles of Jesus Christ, and one of the first leaders of the early Church."},
			{str = "Peter was originally going to be in a mod called ''Decadence'' by poody_blue, but it has since been morphed into Furtherance and Peter has been tweaked from what he was originally."},
		},
	},
	TaintedPeter = {
		{ -- Start Data
			{str = "Start Data", fsize = 2, clr = 3, halign = 0},
			{str = "Items:"},
			{str = "- Muddled Cross"},
			{str = "Stats:"},
			{str = "- HP: 3 Red Hearts"},
			{str = "- Speed: 1.00"},
			{str = "- Tear rate: 2.73"},
			{str = "- Damage: 3.50"},
			{str = "- Range: 6.50"},
			{str = "- Shot speed: 1.00"},
			{str = "- Luck: -1.00"},
		},
		{ -- Traits
			{str = "Traits", fsize = 2, clr = 3, halign = 0},
			{str = "Tainted Peter is unable to utilize Soul Hearts and Black Hearts as health."},
			{str = "Tainted Peter normally cannot gain items over quality 2. Instead he can use his pocket active item ''Muddled Cross'' to travel to an upside down, red tinted version of the next chapter."},
			{str = "- If he uses it on Basement, the floor will look like Caves and so on."},
			{str = "- While flipped, Tainted Peter will lose half a heart every 7 seconds."},
			{str = "- Enemies will be harder to defeat, but you gain double the items and pickups."},
			{str = "The item pool for all items while flipped is the Ultra Secret Room item pool."},
			{str = "- Items of any quality can be found while flipped."},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = "While flipped, Tainted Peter loses half a heart every 14 seconds instead of every 7."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "When entering a new floor while flipped, you will no longer be flipped."}
		},
	},
	Miriam = {
		{ -- Start Data
			{str = "Start Data", fsize = 2, clr = 3, halign = 0},
			{str = "Items:"},
			{str = "- Tambourine"},
			{str = "Stats:"},
			{str = "- HP: 2 Red Hearts, 2 Soul Hearts"},
			{str = "- Speed: 1.25"},
			{str = "- Tear rate: 1.06"},
			{str = "- Damage: 4.00"},
			{str = "- Range: 4.00"},
			{str = "- Shot speed: 1.00"},
			{str = "- Luck: 0.00"},
		},
		{ -- Traits
			{str = "Traits", fsize = 2, clr = 3, halign = 0},
			{str = "Miriam's tears are fired in an arc. Upon hitting the floor, an obstacle, or an enemy they burst into a puddle of water."},
			{str = "- The puddle of water deals 33% of Miriam's damage."},
			{str = "- The puddle of water lasts for 3 seconds."},
			{str = "Every 12 shots, the size of the puddle becomes 34% larger and begins to pull in enemies, pickups, and tears/shots from all sources for 3 seconds."},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = "Enemies hit by Miriam within 2 tiles of the puddle get knocked back significantly."},
			{str = "Miriam's Puddles become 1.25x larger."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "The Torah refers to her as ''Miriam the Prophetess'' and the Talmud names her as one of the seven major female prophets of Israel."},
			{str = "Miriam was first proposed for Team Compliance for the new content phase of the mod, but anchikai once again takes an idea she likes for her own mod instead. Thanks Soaring__Sky!"},
		},
	},
	TaintedMiriam = {
		{ -- Start Data
			{str = "Start Data", fsize = 2, clr = 3, halign = 0},
			{str = "Items:"},
			{str = "- Polarity Shift"},
			{str = "- Rune Shard"},
			{str = "Stats:"},
			{str = "- HP: 2 Bone Hearts, 4 Broken Hearts"},
			{str = "- Speed: 1.00"},
			{str = "- Tear rate: 2.73"},
			{str = "- Damage: 4.00"},
			{str = "- Range: 6.50"},
			{str = "- Shot speed: 1.00"},
			{str = "- Luck: -2.00"},
		},
		{ -- Traits
			{str = "Traits", fsize = 2, clr = 3, halign = 0},
			{str = "A cursor will appear below enemies which is controlled by firing."},
			{str = "Replaces tears with multiple thin lasers."},
			{str = "The lasers will be aimed at the cursor which home on the nearest enemy until the enemy is dead."},
			{str = "- The cursor will automatically move to the next nearest enemy."},
			{str = "Deals 0.33x Tainted Miriam's damage per tick."},
			{str = "Enemies killed have a 5% chance to heal 1/2 red heart."},
			{str = "Polarity Shift charges up with kills that would normally heal Tainted Miriam if she was not at full health."},
			{str = "- Takes 6 charges to fully charge, the equivalent of 6 healing procs (or 3 full red hearts)"},
			{str = "- It does not charge with clearing rooms or taking batteries."},
			{str = "On use, Tainted Miriam's ''Spiritual Wound'' attack is converted into Lightning bolts for the current room. Additionally, her Fire Rate is increased by 1 and her movement speed is increased by 0.4."},
			{str = "Lightning bolts deal 2x Tainted Miriam's damage on the first frame and continue to do 0.15x damage per frame over time while tethered."},
			{str = "- Lightning bolts do not heal."},
			{str = "Using Polarity Shift again while its effect is active will deactivate the effect, returning her to Spiritual Wound and resetting her Fire Rate and movement speed boosts."},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = "Your lasers now target all enemies at once."},
			{str = "- Your damage is evenly spread across all the enemies."},
			{str = "- Targeting an enemy will focus most of the damage on it."},
		},
	},
	Esther = {
		{ -- Start Data
			{str = "Start Data", fsize = 2, clr = 3, halign = 0},
			{str = "Items:"},
			{str = "- "},
			{str = "Stats:"},
			{str = "- HP: "},
			{str = "- Speed: "},
			{str = "- Tear rate: "},
			{str = "- Damage: "},
			{str = "- Range: "},
			{str = "- Shot speed: "},
			{str = "- Luck: "},
		},
		{ -- Traits
			{str = "Traits", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
	TaintedEsther = {
		{ -- Start Data
			{str = "Start Data", fsize = 2, clr = 3, halign = 0},
			{str = "Items:"},
			{str = "- "},
			{str = "Stats:"},
			{str = "- HP: "},
			{str = "- Speed: "},
			{str = "- Tear rate: "},
			{str = "- Damage: "},
			{str = "- Range: "},
			{str = "- Shot speed: "},
			{str = "- Luck: "},
		},
		{ -- Traits
			{str = "Traits", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = ""},
		},
	},
}

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_ESC_KEY,
	WikiDesc = Wiki.EscKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_TILDE_KEY,
	WikiDesc = Wiki.TildeKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_ALT_KEY,
	WikiDesc = Wiki.AltKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_SPACEBAR_KEY,
	WikiDesc = Wiki.SpacebarKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BACKSPACE_KEY,
	WikiDesc = Wiki.BackspaceKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_Q_KEY,
	WikiDesc = Wiki.QKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_E_KEY,
	WikiDesc = Wiki.EKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_C_KEY,
	WikiDesc = Wiki.CKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_CAPS_KEY,
	WikiDesc = Wiki.CapsKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_ENTER_KEY,
	WikiDesc = Wiki.EnterKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_SHIFT_KEY,
	WikiDesc = Wiki.ShiftKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_F4_KEY,
	WikiDesc = Wiki.F4Key,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_TAB_KEY,
	WikiDesc = Wiki.TabKey,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_OPHIUCHUS,
	WikiDesc = Wiki.Ophiuchus,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_CHIRON,
	WikiDesc = Wiki.Chiron,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_JUNO,
	WikiDesc = Wiki.Juno,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_PALLAS,
	WikiDesc = Wiki.Pallas,
	Pools = {
		Encyclopedia.ItemPools.POOL_PLANETARIUM,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_CERES,
	WikiDesc = Wiki.Ceres,
	Pools = {
		Encyclopedia.ItemPools.POOL_PLANETARIUM,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_VESTA,
	WikiDesc = Wiki.Vesta,
	Pools = {
		Encyclopedia.ItemPools.POOL_PLANETARIUM,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_HOLY_HEART,
	WikiDesc = Wiki.HolyHeart,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_TECH_IX,
	WikiDesc = Wiki.TechIX,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_LEAKING_TANK,
	WikiDesc = Wiki.LeakingTank,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_UNSTABLE_CORE,
	WikiDesc = Wiki.UnstableCore,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1,
	WikiDesc = Wiki.Technologyminus1,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS,
	WikiDesc = Wiki.BookOfSwiftness,
	Pools = {
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT,
	WikiDesc = Wiki.BookOfAmbit,
	Pools = {
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_NEASS,
	WikiDesc = Wiki.PlugNPlay,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_CRINGE,
	WikiDesc = Wiki.Cringe,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ,
	WikiDesc = Wiki.ZZZZoptionsZZZZ,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BRUNCH,
	WikiDesc = Wiki.Brunch,
	Pools = {
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_CRAB_LEGS,
	WikiDesc = Wiki.CrabLegs,
	Pools = {
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_OWLS_EYE,
	WikiDesc = Wiki.OwlsEye,
	Pools = {
		Encyclopedia.ItemPools.POOL_RED_CHEST,
		Encyclopedia.ItemPools.POOL_CURSE,
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_CURSE,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_SLICK_WORM,
	WikiDesc = Wiki.SlickWorm,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_HEART_RENOVATOR,
	WikiDesc = Wiki.HeartRenovator,
	Pools = {
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_SHATTERED_HEART,
	WikiDesc = Wiki.ShatteredHeart,
	Pools = {
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_PHARAOH_CAT,
	WikiDesc = Wiki.PharaohCat,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_GRASS,
	WikiDesc = Wiki.Grass,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM,
	WikiDesc = Wiki.KeysToTheKingdom,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_MUDDLED_CROSS,
	WikiDesc = Wiki.MuddledCross,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_ALABASTER_SCRAP,
	WikiDesc = Wiki.AlabasterScrap,
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_LEAHS_LOCK,
	WikiDesc = Wiki.LeahsLock,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BINDS_OF_DEVOTION,
	WikiDesc = Wiki.BindsOfDevotion,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_PARASITIC_POOFER,
	WikiDesc = Wiki.ParasiticPoofer,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BUTTERFLY,
	WikiDesc = Wiki.Butterfly,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND,
	WikiDesc = Wiki.SpiritualWound,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_CADUCEUS_STAFF,
	WikiDesc = Wiki.CaduceusStaff,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_POLYDIPSIA,
	WikiDesc = Wiki.Polydipsia,
	Pools = {
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_KARETH,
	WikiDesc = Wiki.Kareth,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_CURSE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE,
	WikiDesc = Wiki.PillarOfFire,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_PILLAR_OF_CLOUDS,
	WikiDesc = Wiki.PillarOfClouds,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_FIRSTBORN_SON,
	WikiDesc = Wiki.FirstbornSon,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_MIRIAMS_WELL,
	WikiDesc = Wiki.MiriamsWell,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_QUARANTINE,
	WikiDesc = Wiki.Quarantine,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BOOK_OF_GUIDANCE,
	WikiDesc = Wiki.BookOfGuidance,
	Pools = {
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_JAR_OF_MANNA,
	WikiDesc = Wiki.JarOfManna,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_TAMBOURINE,
	WikiDesc = Wiki.Tambourine,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_THE_DREIDEL,
	WikiDesc = Wiki.TheDreidel,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_APOCALYPSE,
	WikiDesc = Wiki.Apocalypse,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_ABYSSAL_PENNY,
	WikiDesc = Wiki.AbyssalPenny,
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_SALINE_SPRAY,
	WikiDesc = Wiki.SalineSpray,
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_ALMAGEST_SCRAP,
	WikiDesc = Wiki.AlmagestScrap,
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_WORMWOOD_LEAF,
	WikiDesc = Wiki.WormwoodLeaf,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_OLD_CAMERA,
	WikiDesc = Wiki.OldCamera,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_ALTERNATE_REALITY,
	WikiDesc = Wiki.AlternateReality,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_WINE_BOTTLE,
	WikiDesc = Wiki.WineBottle,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_HEART_EMBEDDED_COIN,
	WikiDesc = Wiki.HeartEmbeddedCoin,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_MANDRAKE,
	WikiDesc = Wiki.Mandrake,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

--[[
	Encyclopedia.AddItem({
		ModName = "Furtherance",
		Class = "Furtherance",
		ID = CollectibleType.COLLECTIBLE_LITTLE_SISTER,
		WikiDesc = Wiki.LittleSister,
		Pools = {
	
		},
	})
]]

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_FLUX,
	WikiDesc = Wiki.Flux,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_COSMIC_OMNIBUS,
	WikiDesc = Wiki.CosmicOmnibus,
	Pools = {
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_LITTLE_RAINCOAT,
	WikiDesc = Wiki.LittleRaincoat,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BLOOD_CYST,
	WikiDesc = Wiki.BloodCyst,
	Pools = {
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_POLARIS,
	WikiDesc = Wiki.Polaris,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_D9,
	WikiDesc = Wiki.D9,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_POLARITY_SHIFT,
	WikiDesc = Wiki.PolarityShift,
})

--[[
Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_LEAHS_HAIR_TIE,
	WikiDesc = Wiki.LeahsHairTie,
	Pools = {
		
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_LEAHS_TORN_HEART,
	WikiDesc = Wiki.LeahsTornHeart,
	Pools = {
		
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_PETERS_HEADBAND,
	WikiDesc = Wiki.PetersHeadband,
	Pools = {
		
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_PETERS_BLOODY_FRACTURE,
	WikiDesc = Wiki.PetersBloodyFracture,
	Pools = {
		
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_MIRIAMS_HEADBAND,
	WikiDesc = Wiki.MiriamsHeadband,
	Pools = {
		
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_MIRIAMS_PUTRID_VEIL,
	WikiDesc = Wiki.MiriamsPutridVeil,
	Pools = {
		
	},
})
]]

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BOOK_OF_BOOKS,
	WikiDesc = Wiki.BookOfBooks,
	Pools = {
		Encyclopedia.ItemPools.POOL_ULTRA_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_KERATOCONUS,
	WikiDesc = Wiki.Keratoconus,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_SERVITUDE,
	WikiDesc = Wiki.Servitude,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_CARDIOMYOPATHY,
	WikiDesc = Wiki.Cardiomyopathy,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_ALTRUISM,
	WikiDesc = Wiki.Altruism,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_SUNSCREEN,
	WikiDesc = Wiki.Sunscreen,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_SECRET_DIARY,
	WikiDesc = Wiki.SecretDiary,
	Pools = {
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_NIL_NUM,
	WikiDesc = Wiki.NilNum,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_D16,
	WikiDesc = Wiki.D16,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_IRON,
	WikiDesc = Wiki.Iron,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_ROTTEN_APPLE,
	WikiDesc = Wiki.RottenApple,
	Pools = {
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_BI_84,
	WikiDesc = Wiki.BI84,
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_GLITCHED_PENNY,
	WikiDesc = Wiki.GlitchedPenny,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BEGINNERS_LUCK,
	WikiDesc = Wiki.BeginnersLuck,
	Pools = {
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_DADS_WALLET,
	WikiDesc = Wiki.DadsWallet,
	Pools = {
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_CHI_RHO,
	WikiDesc = Wiki.ChiRho,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_LEAHS_HEART,
	WikiDesc = Wiki.LeahsHeart,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_PALLIUM,
	WikiDesc = Wiki.Pallium,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_ESCAPE_PLAN,
	WikiDesc = Wiki.EscapePlan,
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_EPITAPH,
	WikiDesc = Wiki.Epitaph,
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_LEVIATHANS_TENDRIL,
	WikiDesc = Wiki.LeviathansTendril,
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_KEY_TO_THE_PIT,
	WikiDesc = Wiki.KeyToThePit,
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_HAMMERHEAD_WORM,
	WikiDesc = Wiki.HammerheadWorm,
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_COLD_HEARTED,
	WikiDesc = Wiki.ColdHearted,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_ROTTEN_LOVE,
	WikiDesc = Wiki.RottenLove,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_BOSS,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_BOSS,
		Encyclopedia.ItemPools.POOL_ROTTEN_BEGGAR,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_RUE,
	WikiDesc = Wiki.Rue,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_RED_CHEST,
		Encyclopedia.ItemPools.POOL_CURSE,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_CURSE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_EXSANGUINATION,
	WikiDesc = Wiki.Exsanguination,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_RED_CHEST,
		Encyclopedia.ItemPools.POOL_DEMON_BEGGAR,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_PRAYER_JOURNAL,
	WikiDesc = Wiki.PrayerJournal,
	Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_BOOK_OF_LEVITICUS,
	WikiDesc = Wiki.BookOfLeviticus,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_LIBRARY,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_MOLTEN_GOLD,
	WikiDesc = Wiki.MoltenGold,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_TREPANATION,
	WikiDesc = Wiki.Trepanation,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_ASTRAGALI,
	WikiDesc = Wiki.Astragali,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_LIBERATION,
	WikiDesc = Wiki.Liberation,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_GREED_TREASURE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_SEVERED_EAR,
	WikiDesc = Wiki.SeveredEar,
	Pools = {
		Encyclopedia.ItemPools.POOL_DEVIL,
		Encyclopedia.ItemPools.POOL_RED_CHEST,
		Encyclopedia.ItemPools.POOL_CURSE,
		Encyclopedia.ItemPools.POOL_GREED_DEVIL,
		Encyclopedia.ItemPools.POOL_GREED_CURSE,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_GOLDEN_PORT,
	WikiDesc = Wiki.GoldenPort,
	Pools = {
		Encyclopedia.ItemPools.POOL_SHOP,
		Encyclopedia.ItemPools.POOL_SECRET,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_SECRET,
		Encyclopedia.ItemPools.POOL_CRANE_GAME,
	},
})

Encyclopedia.AddItem({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = CollectibleType.COLLECTIBLE_ITCHING_POWDER,
	WikiDesc = Wiki.ItchingPowder,
	Pools = {
		Encyclopedia.ItemPools.POOL_TREASURE,
		Encyclopedia.ItemPools.POOL_GOLDEN_CHEST,
		Encyclopedia.ItemPools.POOL_RED_CHEST,
		Encyclopedia.ItemPools.POOL_CURSE,
		Encyclopedia.ItemPools.POOL_GREED_SHOP,
		Encyclopedia.ItemPools.POOL_GREED_CURSE,
	},
})

Encyclopedia.AddTrinket({
	ModName = "Furtherance",
	Class = "Furtherance",
	ID = TrinketType.TRINKET_PARASOL,
	WikiDesc = Wiki.Parasol,
})

-- Pocket Items
Encyclopedia.AddSoul({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Soul of Leah"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "resources/gfx/soulofleah.anm2", "HUD", 0),
    WikiDesc = Wiki.SoulOfLeah,
	Name = "Leah's Soul",
})

Encyclopedia.AddSoul({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Soul of Peter"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "resources/gfx/soulofpeter.anm2", "HUD", 0),
    WikiDesc = Wiki.SoulOfPeter,
	Name = "Peter's Soul",
})

Encyclopedia.AddSoul({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Soul of Miriam"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "resources/gfx/soulofmiriam.anm2", "HUD", 0),
    WikiDesc = Wiki.SoulOfMiriam,
	Name = "Miriam's Soul",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Two of Shields"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Two of Shields", 0),
    WikiDesc = Wiki.TwoOfShields,
	Name = "Two of Shields",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Ace of Shields"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Ace of Shields", 0),
    WikiDesc = Wiki.AceOfShields,
	Name = "Ace of Shields",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Trap Card"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Trap Card", 0),
    WikiDesc = Wiki.TrapCard,
	Name = "Trap Card",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Key Card"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Key Card", 0),
    WikiDesc = Wiki.KeyCard,
	Name = "Key Card",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Golden Card"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Golden Card", 0),
    WikiDesc = Wiki.GoldenCard,
	Name = "Golden Card",
})

Encyclopedia.AddRune({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Essence of Love"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Essence of Love", 0),
    WikiDesc = Wiki.EssenceOfLove,
	Name = "Essence of Love",
})

Encyclopedia.AddRune({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Essence of Hate"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Essence of Hate", 0),
    WikiDesc = Wiki.EssenceOfHate,
	Name = "Essence of Hate",
})

Encyclopedia.AddRune({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Essence of Life"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Essence of Life", 0),
    WikiDesc = Wiki.EssenceOfLife,
	Name = "Essence of Life",
})

Encyclopedia.AddRune({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Essence of Death"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Essence of Death", 0),
    WikiDesc = Wiki.EssenceOfDeath,
	Name = "Essence of Death",
})

Encyclopedia.AddSoul({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Soul of Esther"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "resources/gfx/soulofesther.anm2", "HUD", 0),
    WikiDesc = Wiki.SoulOfEsther,
	Name = "Esther's Soul",
})

Encyclopedia.AddRune({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Essence of Prosperity"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Essence of Prosperity", 0),
    WikiDesc = Wiki.EssenceOfProsperity,
	Name = "Essence of Prosperity",
})

Encyclopedia.AddRune({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Essence of Drought"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Essence of Drought", 0),
    WikiDesc = Wiki.EssenceOfDrought,
	Name = "Essence of Drought",
})

Encyclopedia.AddPill({
	ModName = "Furtherance",
    Class = "Furtherance",
    ID = PILLEFFECT_HEARTACHE_UP,
    WikiDesc = Wiki.HeartacheUp,
	Color = 4,
	Description = "Negative",
})

Encyclopedia.AddPill({
	ModName = "Furtherance",
    Class = "Furtherance",
    ID = PILLEFFECT_HEARTACHE_DOWN,
    WikiDesc = Wiki.HeartacheDown,
	Color = 9,
	Description = "Positive",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Hope"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Hope", 0),
    WikiDesc = Wiki.HopeCard,
	Name = "XXIII - Hope",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("ReverseHope"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "ReverseHope", 0),
    WikiDesc = Wiki.ReverseHopeCard,
	Name = "XXIII - Hope?",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Faith"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Faith", 0),
    WikiDesc = Wiki.FaithCard,
	Name = "XXV - Faith",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("ReverseFaith"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "ReverseFaith", 0),
    WikiDesc = Wiki.ReverseFaithCard,
	Name = "XXV - Faith?",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Charity"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Charity", 0),
    WikiDesc = Wiki.CharityCard,
	Name = "XXIV - Charity",
})

Encyclopedia.AddCard({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("ReverseCharity"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "ReverseCharity", 0),
    WikiDesc = Wiki.ReverseCharityCard,
	Name = "XXIV - Charity?",
})

Encyclopedia.AddRune({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Essence of Bravery"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Essence of Bravery", 0),
    WikiDesc = Wiki.EssenceOfBravery,
	Name = "Essence of Bravery",
})

Encyclopedia.AddRune({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Essence of Cowardice"),
	Spr = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/ui_cardfronts.anm2", "Essence of Cowardice", 0),
    WikiDesc = Wiki.EssenceOfCowardice,
	Name = "Essence of Cowardice",
})

-- Characters
Encyclopedia.AddCharacter({
    ModName = "Furtherance",
    Name = "Leah",
    ID = PlayerType.PLAYER_LEAH,
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraits.anm2", "Leah", 0),
	WikiDesc = Wiki.Leah,
})

Encyclopedia.AddCharacterTainted({
    ModName = "Furtherance",
    Name = "Leah",
    Description = "The Unloved",
    ID = PlayerType.PLAYER_LEAH_B,
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraitsalt.anm2", "Leah", 0, mod.path .. "content-dlc3/gfx/charactermenu_leahb.png"),
	WikiDesc = Wiki.TaintedLeah,
})

Encyclopedia.AddCharacter({
    ModName = "Furtherance",
    Name = "Peter",
    ID = PlayerType.PLAYER_PETER,
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraits.anm2", "Peter", 0),
	WikiDesc = Wiki.Peter,
})

Encyclopedia.AddCharacterTainted({
    ModName = "Furtherance",
    Name = "Peter",
    Description = "The Martyr",
    ID = PlayerType.PLAYER_PETER_B,
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraitsalt.anm2", "Peter", 0, mod.path .. "content-dlc3/gfx/charactermenu_peterb.png"),
	WikiDesc = Wiki.TaintedPeter,
})

Encyclopedia.AddCharacter({
    ModName = "Furtherance",
    Name = "Miriam",
    ID = PlayerType.PLAYER_MIRIAM,
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraits.anm2", "Miriam", 0),
	WikiDesc = Wiki.Miriam,
})

Encyclopedia.AddCharacterTainted({
    ModName = "Furtherance",
    Name = "Miriam",
    Description = "The Forlorn",
    ID = PlayerType.PLAYER_MIRIAM_B,
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraitsalt.anm2", "Miriam", 0, mod.path .. "content-dlc3/gfx/charactermenu_miriamb.png"),
	WikiDesc = Wiki.TaintedMiriam,
})

Encyclopedia.AddCharacter({
    ModName = "Furtherance",
    Name = "Esther",
    ID = PlayerType.PLAYER_ESTHER,
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraits.anm2", "Esther", 0),
	WikiDesc = Wiki.Esther,
})

Encyclopedia.AddCharacterTainted({
    ModName = "Furtherance",
    Name = "Esther",
    Description = "The Craven",
    ID = PlayerType.PLAYER_ESTHER_B,
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraitsalt.anm2", "Esther", 0, mod.path .. "content-dlc3/gfx/charactermenu_estherb.png"),
	WikiDesc = Wiki.TaintedEsther,
})