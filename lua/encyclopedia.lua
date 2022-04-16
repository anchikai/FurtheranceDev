local mod = further

local Wiki = {
	EscKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "If the player has fewer than 6 hearts, it will heal them with a combination of red and soul hearts."},
			{str = "Teleports you out of the room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The item will vanish once used."},
			{str = "If used during The Beast fight, it will do the same effects, but you will be teleported to a random position on screen."},
			{str = "If used during The Dogma fight, it will do the same effects and teleport you to Isaac's bedroom."},
		}
	},
	TildeKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, a random debug effect will be applied for the current room."},
			{str = "Possible debug effects are: Entity Positions, Grid, Infinite HP, High Damage, Show Room Info, Show Hitspheres, Show Damage Values, Infinite Item Charges, High Luck, Quick Kill, Grid Info, Player Item Info, and Show Grid Collision Points."}
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
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
			{str = "The item can only be used once per floor."},
			{str = "This item will cause new floors to be generated."},
		},
	},
	SpacebarKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, it will teleport you to the I AM ERROR room."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Once used, you will be stuck in the I AM ERROR room if you have no other means of leaving."},
			{str = "The item will have a 8% chance of deleting itself upon being used."},
		}
	},
	BackspaceKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, it will open the door you last came from."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Using the item will do nothing if the previous door is already open."},
		},
	},
	QKey = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "When used, it will copy whatever is in your pocket slot."},
			{str = "This means it functions identically to Placebo, Blank Card, and Clear Rune."}
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
			{str = "Upon use, it will teleport you to a Library room with 5 different books."},
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
			{str = "If you are a normal character, you will become the respective tainted character. If you are a tainted character, you will become the respective normal character."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Using this item as Esau will do nothing. This is because Esau causes issues."},
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
			{str = "This item will not do anything with wiggle worm."},
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
			{str = "Entering a boss room will select a random book effect from a list."},
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
			{str = "Enemies will be slowed while being attacked by the tentacle."},
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
			{str = "Once an enemy is chained, the effect will not proc again for 10 seconds Once the 10 seconds have passed, the item can chain an enemy again."},
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
			{str = "Concept by PootisTweet!"},
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
			{str = "The Inner Eye: Fires three Tech IX rings instead of one, and so on."},
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
			{str = "Shoots a Technology laser opposite of the direction you are shooting."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "This item will not replace your current tears, and will go along side them."},
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
			{str = "Grants +5 range and piercing tears for the current room."},
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
			{str = "When entering a new treasure room, a ''gitched'' item will spawn in a random area of the room along side the normal item."},
			{str = "- Similarly to TMTRAINER, the currently playing music will fade out when walking into the treasure room. The silence will remain until another music track plays."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "You can choose to take both items."},
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
			{str = "- It can be filled by picking up red hearts. When you hold the drop button, two will be subtracted from the counter and a broken heart will be added."},
			{str = "Using Heart Renovator will remove a broken heart and grant a small Damage up."},
			{str = "Enemies have a 6.25% chance to drop a scared heart when Isaac kills them."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If the player has no broken hearts to remove, it will not grant a Damage up and do nothing."},
		},
	},
	PharaohCat = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Gives the player a -1.76 Tears down."},
			{str = "When Isaac shoots, a pyramid formation of tears will be fired."},
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
			{str = "Alt Key: The floor Isaac is currently on will be ''closed''. All enemies, obstacles, walls, doors, etc. and both the Alt Key and F4 Key will be removed. This will allow the player to walk through walls as well."},
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
			{str = "If the player has the full map already, it will do nothing other than take them to the Ultra Secret Room."},
			{str = "If the player has been to the Ultra Secret Room already, they will be teleported back to it and no new item will be generated."},
		},
		{ -- Synergies
			{str = "Synergies", fsize = 2, clr = 3, halign = 0},
			{str = "Alt Key: Sends you to the title screen."},
		},
	},
	ShatteredHeart = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Upon use, a broken heart will be removed."},
			{str = "Shots have a chance to charm enemies and make the player produce black slowing creep based off how many broken hearts you have."},
			{str = "- Default chance is 25% with 0 broken hearts and goes up by 5% for each broken heart, with a maximum of 80% [11 broken hearts]."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If the player has no broken hearts to remove, it will do nothing."},
			{str = "This item will not appear in any item pools and can only be accessed by playing as Leah, using Spindown Dice, or finding it in Death Certificate."},
			{str = "Shattered Heart can only be used infinitely by Tainted Leah. If other players attempt to use it, 1 broken heart will be removed and the item will vanish."},
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
			{str = "When used, it has a variety of effects based on the room he's in."},
			{str = "- If used in a cleared room, Isaac will be granted another room clear reward."},
			{str = "- If used in a active room, light beams will strike down enemies, similarly to Crack the Sky."},
			{str = "- When used in a devil room, there is a 50% chance either all items become free for you to take with no penalty, or Krampus spawns."},
			{str = "-- If Krampus spawns, they can still drop Head of Krampus or Lump of Coal."},
			{str = "- When used in a angel room, a random key piece is spawned."},
			{str = "-- If the player already has a key piece, the other respective key piece will spawn."},
			{str = "-- If the player already has both key pieces, a random angel item will spawn instead."},
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
			{str = "While held, a broken heart will either be granted or removed when exploring a new room."},
			{str = "If the player gains a broken heart, a tears up will be granted. If the player loses a broken heart, a tears down will be granted."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The tear rate gained through this trinket is capped at 10."},
			{str = "- If the tear rate cap is reached, the next proc will always remove a broken heart and a tears up."},
			{str = "This trinket can kill you by setting you to 12 broken hearts."},
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
			{str = "Binds of Devotion: Picking up multiple copies of the item will spawn additional Jacobs that each have their own inventory."},
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
	
	-- Pocket Items
	SoulOfLeah = {
		{ -- Effect
			{str = "Effect", fsize = 2, clr = 3, halign = 0},
			{str = "Grants between 1 to 5 broken hearts."},
			{str = "All of the broken hearts you gain will give either a damage up or tears up."},
			{str = "The amount of damage or tears gained is dependent on how many broken hearts are gained."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "If the amount of broken hearts gained sets you to 12 broken hearts, it will kill you."},
			{str = "The tears cap is entirely ignored, and in some rare instances can set you to 120 tears."},
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Getting this soul stone as Leah or Tainted Leah effectively acts as a free large stat upgrade if used correctly."},
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
			{str = "For every 20th enemy she kills, one broken heart will be removed and gain a small Damage up."},
			{str = "- Damage gained through kills is half as effective as Damage through Heart Renovator."},
			{str = "Enemies have a 6.25% chance to drop a scared heart when Leah kills them."},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = "The boost in damage from enemy kills and Heart Renovator is twice as effective."},
			{str = "One broken heart will be removed for every ten kills instead of every twenty."},
			{str = "The heart counter will be capped at 999 instead of 99."},
			{str = "Grants three broken hearts."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "Leah starts with a slightly lower damage and tears stat than most characters. However, strategic use of the Heart Counter and using Heart Renovator will help combat the lower damage and tears you start with."},
			{str = "You have to find a good balance between keeping broken hearts for range and removing them for tear rate and damage."},
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
			{str = "- HP: 1 Black Heart, 11 broken hearts"},
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
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			{str = "Shattered Heart can only be used infinitely by Tainted Leah. If other players attempt to use it, 1 broken heart will be removed and the item will vanish."},
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
			{str = "- Speed: 1.10"},
			{str = "- Tear rate: 3.75"},
			{str = "- Damage: 3.00"},
			{str = "- Range: 3.75"},
			{str = "- Shot speed: 1.15"},
			{str = "- Luck: 0.00"},
		},
		{ -- Traits
			{str = "Traits", fsize = 2, clr = 3, halign = 0},
			{str = "Peter gains benefits from visiting devil or angel deals. If Peter has visited more devil deals, he will lose speed, gain damage, range, and stompy. If he has visited more angel deals, he will lose shot speed, gain speed, tear rate, and flight."},
			{str = "- If the amount of Devil and Angel deals visited are the same, Peter will not gain any of the above mentioned changes."},
			{str = "He also has two counters next to each deal percent chance to indicate how many of each deal he has visited."},
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
			{str = "Regardless of which deal he has visited more, he will always gain the benefits of both."},
			{str = "- He will only gain flight if visited angel deals is more than 0, and will only gain stompy if visited devil deals is more than 0."},
			{str = "The tear rate gained from angel deals is hard capped at 30 instead of 15."},
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			{str = "The tear rate gained from angel deals is hard capped at 15."},
			{str = "- All other stats can keep going up indefinitely, so long as you can keep entering new deals."},
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			{str = "Peter was one of the Twelve Apostles of Jesus Christ, and one of the first leaders of the early Church."},
			{str = "Peter was originally going to be in a mod called ''Decadence'' by poody_blue, but it has since been morphed into Furtherance and Peter has been reworked from what he was originally."},
		},
	},
	TaintedPeter = {
		{ -- Start Data
			{str = "Start Data", fsize = 2, clr = 3, halign = 0},
			{str = "Items:"},
			{str = "- Blood of the Martyr"},
			{str = "- Flipped Cross"},
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
			{str = "Tainted Peter cannot gain items over quality 2. Instead he can use his pocket active item ''Flipped Cross'' to travel to an upside down, red tinted version of the next chapter."},
			{str = "- If he uses it on Basement, the floor will look like Caves."},
			{str = "The flipped floor will have most of the stuff on it upside down and the enemies will be harder to defeat, but you gain double the items and pickups."},
			{str = "The item pool on this floor is the Ultra Secret Room item pool."},
			
		},
		{ -- Birthright
			{str = "Birthright", fsize = 2, clr = 3, halign = 0},
		
		},
		{ -- Notes
			{str = "Notes", fsize = 2, clr = 3, halign = 0},
			
		},
		{ -- Interactions
			{str = "Interactions", fsize = 2, clr = 3, halign = 0},
			
		},
		{ -- Trivia
			{str = "Trivia", fsize = 2, clr = 3, halign = 0},
			
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

--[[
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
]]

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

-- Pocket Items
Encyclopedia.AddSoul({
	ModName = "Furtherance",
    Class = "Furtherance",
	ID = Isaac.GetCardIdByName("Soul of Leah"),
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "resources/gfx/soulofleah.anm2", "HUD", 0),
    WikiDesc = Wiki.SoulOfLeah,
	Name = "Leah's Soul",
})

-- Characters
Encyclopedia.AddCharacter({
    ModName = "Furtherance",
    Name = "Leah",
    ID = Isaac.GetPlayerTypeByName("Leah", false),
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraits.anm2", "Leah", 0),
	WikiDesc = Wiki.Leah,
})

Encyclopedia.AddCharacterTainted({
    ModName = "Furtherance",
    Name = "Leah",
    Description = "The Unloved",
    ID = Isaac.GetPlayerTypeByName("LeahB", true),
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraitsalt.anm2", "LeahB", 0, mod.path .. "content-dlc3/gfx/charactermenu_leahb.png"),
	WikiDesc = Wiki.TaintedLeah,
})

Encyclopedia.AddCharacter({
    ModName = "Furtherance",
    Name = "Peter",
    ID = Isaac.GetPlayerTypeByName("Peter", false),
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraits.anm2", "Peter", 0),
	WikiDesc = Wiki.Peter,
})

Encyclopedia.AddCharacterTainted({
    ModName = "Furtherance",
    Name = "Peter",
    Description = "The Martyr",
    ID = Isaac.GetPlayerTypeByName("PeterB", true),
	Sprite = Encyclopedia.RegisterSprite(mod.path .. "content-dlc3/gfx/characterportraitsalt.anm2", "PeterB", 0, mod.path .. "content-dlc3/gfx/charactermenu_peterb.png"),
	WikiDesc = Wiki.TaintedPeter,
})