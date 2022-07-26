-- Thank you so much for all the Spanish translations Kotry!!!
-- And now thank you so much for the Russian translations BrakeDude!!!

-- Mod Icon
EID:setModIndicatorName("Furtherance")
local iconSprite = Sprite()
iconSprite:Load("gfx/ui/eid_icon.anm2", true)
EID:addIcon("Furtherance Icon", "Furtherance icon", 0, 12, 11, 6, 6, iconSprite)
EID:setModIndicatorIcon("Furtherance Icon")

-- Birthright Icons
PlayerIconSprite = Sprite()
PlayerIconSprite:Load("gfx/ui/eid_players_icon.anm2", true)
EID:addIcon("Player"..PlayerType.PLAYER_LEAH, "Leah", 0, 12, 12, -1, 1, PlayerIconSprite)
EID:addIcon("Player"..PlayerType.PLAYER_LEAH_B, "LeahB", 0, 12, 12, -1, 1, PlayerIconSprite)
EID:addIcon("Player"..PlayerType.PLAYER_PETER, "Peter", 0, 12, 12, -1, 1, PlayerIconSprite)
EID:addIcon("Player"..PlayerType.PLAYER_PETER_B, "PeterB", 0, 12, 12, -1, 1, PlayerIconSprite)
EID:addIcon("Player"..PlayerType.PLAYER_MIRIAM, "Miriam", 0, 12, 12, -1, 1, PlayerIconSprite)
EID:addIcon("Player"..PlayerType.PLAYER_MIRIAM_B, "MiriamB", 0, 12, 12, -1, 1, PlayerIconSprite)

-- Leah
EID:addBirthright(PlayerType.PLAYER_LEAH, "↑ Heart counter now caps at 999#{{BrokenHeart}} A broken heart will be removed every 20 kills#It will grant damage half as effective as Heart Renovator", "Leah", "en_us")

-- Tainted Leah
EID:addBirthright(PlayerType.PLAYER_LEAH_B, "Tainted Leah will no longer constantly refill back to {{BrokenHeart}} 11 broken hearts#She will instead refill to only 6#She will gain 0.05 speed for every broken heart instead of lose#↑ +20% chance to charm enemies", "Tainted Leah", "en_us")
EID:addBirthright(PlayerType.PLAYER_LEAH_B, "{{BrokenHeart}} Сломанные серда Порченой Лии больше не будет постоянно пополняться до 11, вместо этого они будет пополняться только до 6#↑ {{Speed}} +0.05 к скорости за каждое разбитое сердце вместо потери#↑ +20% шанс очаровать врагов", "Порченая Лия", "ru")
EID:addBirthright(PlayerType.PLAYER_LEAH_B, "Leah contaminada ya no recibirá {{BrokenHeart}} 11 corazones rotos, en cambio sólo tendrá 6#↑ {{Speed}} Velocidad +0.05 por cada corazón roto que posea#20% de posibilidad de encantar enemigos", "Leah Contaminada", "spa")

-- Peter
EID:addBirthright(PlayerType.PLAYER_PETER, "↑ Peter's spare timer is now 15 seconds instead of 30#↑ Sparing bosses now grants 3 permanent stats instead of 2", "Peter", "en_us")

-- Tainted Peter
EID:addBirthright(PlayerType.PLAYER_PETER_B, "↑ Bleeding while flipped takes 14 seconds instead of 7", "Tainted Peter", "en_us")

-- Miriam
EID:addBirthright(PlayerType.PLAYER_MIRIAM, "↑ Miriam's pools become 25% larger#Nearby enemies hit by Miriam will be knocked back significantly", "Miriam", "en_us")

-- Tainted Miriam
EID:addBirthright(PlayerType.PLAYER_MIRIAM_B, "↑ Your lasers now target all enemies at once#{{Blank}}Your damage is evenly spread#{{Blank}}Targeting an enemy will focus most of the damage on it", "Tainted Miriam", "en_us")

--Esc Key
EID:addCollectible(CollectibleType.COLLECTIBLE_ESC_KEY, "If player has fewer than 6 hearts, heals them with combination of red and soul hearts#Teleports you out of the room", "Esc Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_ESC_KEY, "Если у персонажа меньше 6 сердец, то лечит их в комбинации {{Heart}} красных и {{SoulHeart}} синих сердец#Телепортирует из комнаты", "Клавиша Esc", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_ESC_KEY, "Si el juegador tiene menos de 6 corazones, será curado con una mezcla de {{Heart}} Corazones rojos y {{SoulHeart}} Corazones de Alma#Te teletransporta fuera de la habitación", "Tecla Esc", "spa")

--Tilde Key
EID:addCollectible(CollectibleType.COLLECTIBLE_TILDE_KEY, "Grants a random debug effect for the current room", "Tilde Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_TILDE_KEY, "Дарует еффект случайной консольной комманды для текущей комнаты", "Клавиша тильда", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_TILDE_KEY, "Otorga un efecto aleatorio de la consola de desarrollo", "Tecla Tilde", "spa")

--Alt Key
EID:addCollectible(CollectibleType.COLLECTIBLE_ALT_KEY, "Normal floors will become one of its alt variants#Alt floors will become one of its normal variants", "Alt Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_ALT_KEY, "Обычные этажи превращаются в один из альтернативных вариантов#Альтернативные варианты этажей превращаяются в обычные", "Клавиша Alt", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_ALT_KEY, "El piso normal se convierte en una de sus variantes(p.e. Sótano -> Aguacero)#Los pisos alternativos se transforman en pisos normales (p.e. Aguacero -> Sótano)", "Tecla Alt", "spa")

--Spacebar Key
EID:addCollectible(CollectibleType.COLLECTIBLE_SPACEBAR_KEY, "Teleports you to the I AM ERROR room upon use", "Spacebar Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_SPACEBAR_KEY, "Телепортирует в комнату I AM ERROR при использовании", "Клавиша пробела", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_SPACEBAR_KEY, "Te teletransporta a una habitación de I AM ERROR tras usarla", "Tecla Espacio", "spa")

--Backspace Key
EID:addCollectible(CollectibleType.COLLECTIBLE_BACKSPACE_KEY, "Opens the door you last came from", "Backspace Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_BACKSPACE_KEY, "Открывает дверь из которой вошли в комнату", "Клавиша Backspace", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_BACKSPACE_KEY, "Abre la última puerta por la que entraste", "Tecla Retroceso", "spa")

--Q Key
EID:addCollectible(CollectibleType.COLLECTIBLE_Q_KEY, "Functions as a 3 in one {{Collectible348}}Placebo, {{Collectible286}}Blank Card, and {{Collectible263}}Clear Rune#Will use your pocket active for free", "Q Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_Q_KEY, "Функционирует как 3 в одном {{Collectible348}}Плацебо, {{Collectible286}}Пустая карта, {{Collectible263}}Чистая руна#Карманный активируемый предмет будет использован без зарядов", "Клавиша Q", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_Q_KEY, "Funciona como {{Collectible348}} Placebo, {{Collectible263}} Runa Limpia y {{Collectible286}} Carta Blanca 3 en 1#También usará tu activo de bolsillo gratuitamente", "Tecla Q", "spa")

--E Key
EID:addCollectible(CollectibleType.COLLECTIBLE_E_KEY, "Spawns a Gigabomb", "E Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_E_KEY, "Создает Гигабомбу", "Клавиша E", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_E_KEY, "Genera una Gigabomba", "Tecla E", "spa")

--C Key
EID:addCollectible(CollectibleType.COLLECTIBLE_C_KEY, "Teleports you to a {{Library}} Library with 5 books", "C Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_C_KEY, "Телепортирует в большую {{Library}} Библиотеку с 5 книгами", "Клавиша C", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_C_KEY, "Te teletransporta a una {{Library}} Biblioteca grande con 5 libros", "Tecla C", "spa")

--Caps Key
EID:addCollectible(CollectibleType.COLLECTIBLE_CAPS_KEY, "Makes Isaac large for the current room#Allows Isaac to walk over obstacles to destroy them#↑ {{Damage}} +7 Damage up#↑ {{Range}} +3 Range up", "Caps Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_CAPS_KEY, "Исаак становится большим в текущей комнате#Позволяет Исааку ходить по препядствиям, уничтожая их#↑ {{Damage}} +7 к урону#↑ {{Range}} +3 к дальности", "Клавиша Caps", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_CAPS_KEY, "Vuelve a Isaac más grande durante la habitación#Permite que Isaac destruya obstáculos al caminar sobre ellos#↑ {{Damage}} Daño +7#↑ {{Range}} Alcance +3", "Tecla Bloq Mayús", "spa")

--Enter Key
EID:addCollectible(CollectibleType.COLLECTIBLE_ENTER_KEY, "Attempts to open the Boss Rush door#↑ Ignores in-game timer", "Enter Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_ENTER_KEY, "Попытается открыть дверь к Босс-Рашу#↑ Игнорирует внутреннеигровой таймер", "Клавиша Enter", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_ENTER_KEY, "Intenta abrir la entrada a la Boss Rush#↑ Ignora el cronómetro del juego", "Tecla Enter", "spa")

--Shift Key
EID:addCollectible(CollectibleType.COLLECTIBLE_SHIFT_KEY, "↑ {{Damage}} +15 Damage up#Damage up wears off over the next minute", "Shift Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_SHIFT_KEY, "↑ {{Damage}} +15 к урону#Бонусный урон уменьшается до нуля в течение минуты", "Клавиша Shift", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_SHIFT_KEY, "", "Tecla Shift", "spa")


-- Ophiuchus
EID:addCollectible(CollectibleType.COLLECTIBLE_OPHIUCHUS, "↑ {{Tears}} +0.4 Tears up#↑ {{Damage}} +0.3 Damage up#↑ {{SoulHeart}} +1 Soul Heart#Tears move in waves#Spectral tears", "Ophiuchus", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_OPHIUCHUS, "↑ {{Tears}} +0,4 к скорострельности#↑ {{Damage}} +0,3 к урону#↑ {{SoulHeart}} +1 синее сердце#Слезы движутся волнами#Спектральные слезы", "Змееносец", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_OPHIUCHUS, "↑ {{Tears}} Lágrimas +0.4#↑ {{Damage}} Daño +0.3#↑ {{SoulHeart}} +1 Corazón de alma#Las lágrimas se mueven en ondas#Lágrimas espectrales", "Ofiuco", "spa")

-- Chiron
EID:addCollectible(CollectibleType.COLLECTIBLE_CHIRON, "↑ {{Speed}} +0.2 Speed up#Entering a new floor will give a random mapping effect#Entering a boss room will trigger a book effect", "Chiron", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_CHIRON, "↑ {{Speed}} +0.2 к скорости#Переходя на новый этаж даёт случайный эффект отображения на карте#Заходя в комнату с боссом активирует эффект книги", "Хирон", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_CHIRON, "↑ {{Speed}} Velocidad +0.2#Entrar a un nuevo piso dará un efecto de mapa aleatorio#Entrar a una habitación del jefe dará un efecto de libro aleatorio", "Quirón", "spa")
EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_CHIRON, "5, 12")

-- Juno
EID:addCollectible(CollectibleType.COLLECTIBLE_JUNO, "↑ {{SoulHeart}} +2 Soul Hearts#Tears that hit an enemy have a chance to chain down the nearest enemy for 5 seconds, preventing them from acting", "Juno", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_JUNO, "↑ {{SoulHeart}} +2 синих сердца#Слезы, попавшие во врага, могут сковать в цепь ближайшего врага на 5 секунд, не позволяя ему двигаться", "Юнона", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_JUNO, "↑ {{SoulHeart}} +2 Corazón de alma#Las lágrimas que golpeen a un enemigo tienen una posibilidad de encadenar al enemigo más cercano durante 5 segundos, evitando que actúe", "Juno", "spa")

-- Pallas
EID:addCollectible(CollectibleType.COLLECTIBLE_PALLAS, "Tears bounce off the floor after floating for a short time#Tears cause splash damage on every bounce#↑ {{Tearsize}} Increases tear size by 20%", "Pallas", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_PALLAS, "Слезы отскакивают от пола после непродолжительного полёта#↑ {{Tearsize}} Слезы наносят урон по площади при каждом отскоке#Увеличивает размер слезы на 20%", "Паллас", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_PALLAS, "Las lágrimas rebotan en el suelo después de flotar por un rato#Las lágrimas provocan daño de salpicadura al rebotar#↑ {{Tearsize}} Tamaño de lágrimas + 20%", "Pallas", "spa")

-- Ceres
EID:addCollectible(CollectibleType.COLLECTIBLE_CERES, "↑ {{Damage}} +0.5 Damage up#Tears that hit an enemy have a chance to cause the player to produce green creep#Enemies that walk over that creep will be slowed and a tentacle will attack them#The tentacle will also slow the enemy", "Ceres", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_CERES, "↑ {{Damage}} +0.5 к урону#Слезы, попавшие во врага, могут вызвать появление зеленой лужы#Враги, которые проходят через эту лужу, будут замедлены, и их атакует щупальце#Щупальце также замедляет врага", "Церера", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_CERES, "↑ {{Damage}} +0.5 de daño#Las lágrimas que golpeen a los enemigos tienen una posibilidad que el jugador genere creep verde#Los enemigos que caminen sobre este creep serán ralentizados y atacados por un tentáculo#El tentáculo también ralentizará a los enemigos", "Ceres", "spa")

-- Vesta
EID:addCollectible(CollectibleType.COLLECTIBLE_VESTA, "↑ {{Damage}} +50% Damage up#Tears become extremely small#Tears become spectral and slightly transparent#Tears have a chance to split into 4 tears", "Vesta", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_VESTA, "↑ {{Damage}} +50% к урону#Слёзы становятся очень маленькими#Слёзы становятся спектральными и слегка прозрачными#У слёз есть шанс разделиться на 4 слезы", "Веста", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_VESTA, "↑ {{Damage}} Daño +50%#Las lágrimas se vuelven extremadamente pequeñas#Lágrimas espectrales y ligeramente transparentes#Las lágrimas tienen la posibilidad de dividirse en 4 lágrimas", "Vesta", "spa")


-- Holy Heart
EID:addTrinket(TrinketType.TRINKET_HOLY_HEART, "Adds a small chance to gain a shield when picking up hearts", "Holy Heart", "en_us")
EID:addTrinket(TrinketType.TRINKET_HOLY_HEART, "Даёт маленький шанс получить щит, когда подбираются сердца", "Святое сердце", "ru")
EID:addTrinket(TrinketType.TRINKET_HOLY_HEART, "Poca posibilidad de recibir un escudo al tomar un corazón", "Corazón Bendito", "spa")

-- Tech IX
EID:addCollectible(CollectibleType.COLLECTIBLE_TECH_IX, "Gain the ability to shoot small laser rings#Unlike Tech X, your shots do not need to be charged#↓ {{Tears}} -0.85 Tears down", "Tech IX", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_TECH_IX, "Появляется способность стрелять маленькими лазерными кольцами#В отличие от Технологии X, выстрелы не нужно заряжать", "Технология IX", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_TECH_IX, "Ahora disparas pequeños aros láser#A diferencia de Tech X, no necesitas cargarlos", "Tech IX", "spa")

-- Leaking Tank
EID:addCollectible(CollectibleType.COLLECTIBLE_LEAKING_TANK, "When at one heart, the player will leave a trail of green creep", "Leaking Tank", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_LEAKING_TANK, "Когда остаётся одно сердце, игрок будет оставлять следы из зелёной лужи", "Протекающий бак", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_LEAKING_TANK, "Al estar a un corazón, el jugador soltará creep verde", "Tanque con fuga", "spa")

-- Unstable Core
EID:addCollectible(CollectibleType.COLLECTIBLE_UNSTABLE_CORE, "Every time you use an active item, you create an electric shock around you#Shock burns enemies for 3 seconds", "Unstable Core", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_UNSTABLE_CORE, "Каждый раз при использовании активного предмета вокруг вас создается электрический ток#Ток жжёт врагов в течении 3 секунд", "Нестабильное ядро", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_UNSTABLE_CORE, "Al usar un objeto activo, creas un shock eléctrico alrededor tuyo#Quemas a los enemigos por 3 segundos", "Nucleo Inestable", "spa")

-- Technology -1
EID:addCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1, "Tears randomly burst into 3 Technology lasers", "Technology -1", "en_us")

-- Book of Swiftness
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS, "Slows down enemies#↑ {{Speed}} +0.5 Speed up#↓ {{Shotspeed}} -1 Shot Speed down#Effect lasts for current room", "Book of Swiftness", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS, "Замедляет врагов#↑ {{Speed}} +0.5 к скорости#↓ {{Shotspeed}} -1 скорость слезы#Эффект длится для текущей комнате", "Книга скорости", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS, "Ralentiza a  los enemigos#↑ {{Speed}} Velocidad +0.5#↓  {{Shotspeed}} Vel. de tiro -1#El efecto sólo dura en la habitación", "Libro de la agilidad", "spa")
EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS, "12") -- Bookworm

-- Book of Ambit
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT, "↑ {{Range}} +5 Range up#↑ {{Shotspeed}} +1.5 Shot Speed up#Grants piercing tears when used", "Book of Ambit", "en_us")
EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT, "12") -- Bookworm

-- Plug N' Play
EID:addCollectible(CollectibleType.COLLECTIBLE_NEASS, "Spawns a 'glitched' item#They have completely random effects", "Plug N' Play", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_NEASS, "Создает 'глючный' предмет#Все эффекты полностью случайны", "Plug N' Play", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_NEASS, "Genera un objeto 'glitcheado', con comportamiento completamente aleatorio", "Plug N' Play", "spa")

-- Cringe
EID:addTrinket(TrinketType.TRINKET_CRINGE, "All enemies in the room will be briefly frozen when you take damage#↑ Hurt sound is replaced with Bruh sound effect", "Cringe", "en_us")
EID:addTrinket(TrinketType.TRINKET_CRINGE, "Все враги в комнате на момент будут заморожены когда вы получаете урон#↑ Звук боли заменен звуковым эффектом 'Bruh'", "Кринж", "ru")
EID:addTrinket(TrinketType.TRINKET_CRINGE, "Todos los enemigos serán congelados por un corto momento al recibir un daño#↑ El efecto de sonido de ser herido será reemplazado con el efecto de sonido 'Bruh'", "Cringe", "spa")

-- ZZZZoptionsZZZZ
EID:addCollectible(CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ, "Two items now spawn in all {{TreasureRoom}}Treasure Rooms#You can choose one#One of the items will be 'glitched' and spawn in a random location of the room", "ZZZZoptionsZZZZ", "en_us")

-- Brunch
EID:addCollectible(CollectibleType.COLLECTIBLE_BRUNCH, "↑ {{Heart}} +2 Health up#↑ {{Shotspeed}} +0.16 Shot Speed up#Heals 1 Red Heart", "Brunch", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_BRUNCH, "↑ {{Heart}} +2 к здоровью#↑ {{Shotspeed}} +0.16 скорость слезы#Лечит 1 красное сердце", "Полдник", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_BRUNCH, "↑ {{Heart}} +2 corazón#↑ {{Shotspeed}} Vel. de tiro +0.16#Cura un corazón rojo", "Merienda", "spa")

-- Crab Legs
EID:addCollectible(CollectibleType.COLLECTIBLE_CRAB_LEGS, "↑ {{Heart}} +1 Health up#↑ {{Speed}} Whenever you move left or right, you get +0.2 Speed#Heals 1 Red Heart", "Crab Legs", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_CRAB_LEGS, "↑ {{Heart}} +1 к здоровью#↑ {{Speed}} +0.2 к скорости, когда двигаетесь влево или вправо#Лечит 1 красное сердце", "Ноги краба", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_CRAB_LEGS, "↑ {{Heart}} +1 corazón#↑ {{Speed}} 0.2 de velocidad siempre que te muevas a la izquierda o derecha#Cura un corazón rojo", "Patas de cangrejo", "spa")

-- Owl’s Eye
EID:addCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE, "Chance to fire a piercing and homing tear#The tear will do 2x damage", "Owl’s Eye", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE, "Шанс выстрелить пронзающей и самонаводящейся слезой#Слеза нанесёт в 2 раза больше урона", "Глаз совы", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE, "Posibilidad de lanzar una lágrima perforante y teledirigida#La lágrima hará tu daño x2", "Ojo de Buho", "spa")

-- Slick Worm
EID:addTrinket(TrinketType.TRINKET_SLICK_WORM, "Tears bounce off walls towards enemies", "Slick Worm", "en_us")
EID:addTrinket(TrinketType.TRINKET_SLICK_WORM, "Слезы отскакивают от стен на врагов", "Скользкий червяк", "ru")
EID:addTrinket(TrinketType.TRINKET_SLICK_WORM, "Las lágrimas rebotarán en las paredes hacia los enemigos", "Gusano resbaloso", "spa")

-- Shattered Heart
EID:addCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART, "{{BrokenHeart}} Removes 1 broken heart#Slowly generate up to 11 {{BrokenHeart}} broken hearts while in a room with enemies#{{BrokenHeart}} will be rapidly removed while near enemies#Occasionally shoot charming shots and produce black slowing creep", "Shattered Heart", "en_us")

-- Pharoh Cat
EID:addCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT, "↓ {{Tears}} -1.76 Tears down#Isaac shoots a pyramid formation of tears", "Pharaoh Cat", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT, "↓ {{Tears}} -1.76 к скорострельности#Исаак стреляет слезами в форме пирамиды", "Кот-фараон", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT, "↓ {{Tears}} Lágrimas -1.76#Isaac disparará lágrimas en una formación de pirámide", "Gato Faraón", "spa")

-- F4 Key
EID:addCollectible(CollectibleType.COLLECTIBLE_F4_KEY, "Teleports you to another random special room that has not been explored yet depending on what consumables you have the least of#Coins: {{ArcadeRoom}}#Bombs: {{SuperSecretRoom}}, {{IsaacsRoom}}, {{SecretRoom}}#Keys: {{Shop}}, {{TreasureRoom}}, {{DiceRoom}}, {{Library}}, {{ChestRoom}}, {{Planetarium}}", "F4 Key", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_F4_KEY, "Телепорирует в другую особую непосещённую комнату в зависимости от того, каких предметов меньше всего#Монеты: {{ArcadeRoom}}#Бобмы: {{SuperSecretRoom}}, {{IsaacsRoom}}, {{SecretRoom}}#Ключи: {{Shop}}, {{TreasureRoom}}, {{DiceRoom}}, {{Library}}, {{ChestRoom}}, {{Planetarium}}", "Клавиша F4", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_F4_KEY, "Te teletransportará a una sala especial aleatoria inexplorada, basándose en los recolectables que menos tengas#Coins: {{ArcadeRoom}}#Bombas: {{SuperSecretRoom}}, {{IsaacsRoom}}, {{SecretRoom}}#llaves: {{Shop}}, {{TreasureRoom}}, {{DiceRoom}}, {{Library}}, {{ChestRoom}}, {{Planetarium}}", "Tecla F4", "spa")

-- Tab Key
EID:addCollectible(CollectibleType.COLLECTIBLE_TAB_KEY, "Full mapping effect on use#Teleports you to the {{UltraSecretRoom}}Ultra Secret Room#Pathway back will be made of red rooms", "Tab Key", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_TAB_KEY, "Полное отображение карты при использовании#Телепортирует {{UltraSecretRoom}}Ультра секретную комнату#Путь назад будет сделан из красных комнат", "Клавиша Tab", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_TAB_KEY, "Recibes todos los efectos de mapa al usarlo#Te teletransporta a la {{UltraSecretRoom}}Sala Últra Secreta#El camino de regreso consistirá en habitaciones rojas", "Tecla Tab", "spa")

-- Heart Renovator
EID:addCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR, "{{BrokenHeart}} Removes 1 broken heart on use#↑ Grants +0.1 Damage up when removing a broken heart#Grants a counter that can be filled with red hearts#double tapping the drop button will subtract 2 from the counter and give a broken heart", "Heart Renovator", "en_us")

-- Grass
EID:addTrinket(TrinketType.TRINKET_GRASS, "Starts a 1 hour timer#The trinket will be removed when timer ends and {{Collectible210}} Gnawed Leaf will spawn#!!! The timer will reset if the trinket is dropped", "Grass", "en_us")
EID:addTrinket(TrinketType.TRINKET_GRASS, "Запускает 1 часовой таймер#При истечении таймера брелок исчезнет и появится {{Collectible210}} Обглоданный лист#!!! Таймер сбрасывается, если брелок был выброшен", "Трава", "ru")
EID:addTrinket(TrinketType.TRINKET_GRASS, "Empezará un contador de una hora#El trinket será removido y se otorgará la {{Collectible210}} Hoja roída tras acabar el tiempo#!!! Si se suelta el trinket, el contador se reiniciará", "Pasto", "spa")

-- Alabaster Scrap
EID:addTrinket(TrinketType.TRINKET_ALABASTER_SCRAP, "↑ +0.5 Damage up for each angelic item held", "Alabaster Scrap", "en_us")

-- Leah's Lock
EID:addTrinket(TrinketType.TRINKET_LEAHS_LOCK, "25% chance to fire either charm or fear tears", "Leah's Lock", "en_us")

-- Parasitic Poofer
EID:addCollectible(CollectibleType.COLLECTIBLE_PARASITIC_POOFER, "20% chance to duplicate your red hearts and gain a broken heart when taking damage#Only has a healing effect", "Parasitic Poofer", "en_us")

-- Butterfly
EID:addCollectible(CollectibleType.COLLECTIBLE_BUTTERFLY, "Taking damage will cause Isaac to fire tears in random directions for two seconds#The tears deal 50% of Isaac's damage", "Butterfly", "en_us")

-- Spiritual Wound
EID:addCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND, "Replaces tears with multiple thin lasers#A cursor will appear below enemies, and its controlled with the shoot buttons#The lasers will be aimed at the cursor which home on the nearest enemy until its dead#The cursor will automatically move to the next nearest enemy#Deals 0.33x Isaac's damage per tick#Enemies killed have a 5% chance to heal 1/2 red heart", "Spiritual Wound", "en_us")

-- Caduceus Staff
EID:addCollectible(CollectibleType.COLLECTIBLE_CADUCEUS_STAFF, "{{SoulHeart}} +2 Soul Hearts#Chance to negate damage and grant a shield#The chance begins at 1% and doubles for each hit", "Caduceus Staff", "en_us")

-- Polydipsia
EID:addCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA, "Isaac's tears are fired in an arc#Upon hitting the floor, an obstacle, or an enemy they burst into a puddle of water#↓ {{Tears}} roughly -100% Tears down", "Polydipsia", "en_us")

-- Kareth
EID:addCollectible(CollectibleType.COLLECTIBLE_KARETH, "All future items found in the run are replaced with 1-3 trinkets#Amount of trinkets depends on what the items quality was#All trinkets will be smelted when picked up", "Kareth", "en_us")

-- Pillar of Fire
EID:addCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE, "Chance to burst into five flames when hit, dealing damage to enemies#The flames periodically shoot red tears at enemies", "Pillar of Fire", "en_us")

-- Pillar of Clouds
EID:addCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_CLOUDS, "Walking through the door to an uncleared room will occasionally skip that room and immediately walk into the room right after it", "Pillar of Clouds", "en_us")

-- Firstborn Son
EID:addCollectible(CollectibleType.COLLECTIBLE_FIRSTBORN_SON, "A familiar that will immediately chase down and kill the enemy with the highest HP in the room", "Firstborn Son", "en_us")

-- Miriam's Well
EID:addCollectible(CollectibleType.COLLECTIBLE_MIRIAMS_WELL, "An orbital that spills and spawns a pool of water upon being hit", "Miriam's Well", "en_us")

-- Quarantine
EID:addCollectible(CollectibleType.COLLECTIBLE_QUARANTINE, "Applies fear to all enemies for 6 seconds when entering a new room#Enemies near you during that period are poisoned", "Quarantine", "en_us")

-- Book of Guidance
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_GUIDANCE, "Opens all doors for the current floor", "Book of Guidance", "en_us")

-- Jar of Manna
EID:addCollectible(CollectibleType.COLLECTIBLE_JAR_OF_MANNA, "Killing an enemy spawns a Manna orb, which quickly disappears#Manna orbs can be collected by walking over them, which will charge this item#Using will give Isaac the pick up he needs the most", "Jar of Manna", "en_us")

-- Tambourine
EID:addCollectible(CollectibleType.COLLECTIBLE_TAMBOURINE, "Creates a whirlpool at your position#It has a rift-like effect that pulls in pickups and enemies and damages them", "Tambourine", "en_us")

-- The Dreidel
EID:addCollectible(CollectibleType.COLLECTIBLE_THE_DREIDEL, "Reduces 1-4 random stats and spawns 1 random item from the current rooms item pool#Its quality will depend on the amount of stats lowered", "The Dreidel", "en_us")

-- Apocalypse
EID:addCollectible(CollectibleType.COLLECTIBLE_APOCALYPSE, "↓ Removes all of your passive items#↑ Increases 2 random stats for each item removed", "Apocalypse", "en_us")

-- Abyssal Penny
EID:addTrinket(TrinketType.TRINKET_ABYSSAL_PENNY, "Spawns Holy Water creep when picking up coins", "Abyssal Penny", "en_us")

-- Saline Spray
EID:addTrinket(TrinketType.TRINKET_SALINE_SPRAY, "Tears have a 5% chance to be ice tears#They slow enemies and freeze monsters they kill", "Saline Spray", "en_us")

-- Almagest Scrap
EID:addTrinket(TrinketType.TRINKET_ALMAGEST_SCRAP, "Replaces Item Rooms with Planetariums#Planetarium items now cost 1-3 broken hearts#The cost depends on the item's quality", "Almagest Scrap", "en_us")

-- Wormwood Leaf
EID:addTrinket(TrinketType.TRINKET_WORMWOOD_LEAF, "2% chance to block any damage hitting Isaac directly#You will briefly become stone and can't move", "Wormwood Leaf", "en_us")

-- Keys to the Kingdom
EID:addCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM, "When used, it has a variety of effects given the current circumstances:#Active {{Room}}: all enemies will be 'spared' and removed from the room, granting temporary stats for the floor##{{BossRoom}}: a 30 second spare timer will begin and when complete, the boss will be spared and you will gain a permanent stat increase#{{DevilRoom}}: All items become free#{{AngelRoom}}: Spawns a key piece#{{Blank}}Note: If you have {{Collectible238}}{{Collectible239}} an angel item will spawn instead#Charges are only gained through kills#", "Keys to the Kingdom", "en_us")

-- Muddled Cross
EID:addCollectible(CollectibleType.COLLECTIBLE_MUDDLED_CROSS, "Vertically flips the screen and tints it red#The floor will look like the next chapter#↑ All items and pickups are doubled  while flipped#All items are from the {{UltraSecretRoom}}Ultra Secret Room pool#!!! Half a red heart is lost every 7 seconds while flipped", "Muddled Cross", "en_us")

-- Old Camera
EID:addCollectible(CollectibleType.COLLECTIBLE_OLD_CAMERA, "The current room will be 'saved'#Using it again will bring you back to the saved room to be cleared again", "Old Camera", "en_us")

-- Alternate Reality
EID:addCollectible(CollectibleType.COLLECTIBLE_ALTERNATE_REALITY, "Teleports you to a random floor#!!! Puts you inside a random room on the new floor#↑ The map will be revealed for the floor#!!! The random floor can be Blue Womb", "Alternate Reality", "en_us")

-- Wine Bottle
EID:addCollectible(CollectibleType.COLLECTIBLE_WINE_BOTTLE, "A large, high speed cork is fired every 15 shots#↑ The cork has a 2x damage multiplier", "Wine Bottle", "en_us")

-- Heart Embedded Coin
EID:addCollectible(CollectibleType.COLLECTIBLE_HEART_EMBEDDED_COIN, "If you normally can't pick up red hearts, they will grant coins instead", "Heart Embedded Coin", "en_us")

-- Mandrake
EID:addCollectible(CollectibleType.COLLECTIBLE_MANDRAKE, "{{TreasureRoom}} Two items now spawn in all Treasure Rooms#You can only choose one#The second item will always be a familiar", "Mandrake", "en_us")

-- Little Sister
EID:addCollectible(CollectibleType.COLLECTIBLE_LITTLE_SISTER, "", "Little Sister", "en_us")

-- Flux
EID:addCollectible(CollectibleType.COLLECTIBLE_FLUX, "↑ {{Range}} +9.75 Range up#Spectral tears#A tear is fired from the back of your head#Tears only move when you're moving#The tear fired from the back has opposite movement", "Flux", "en_us")

-- Cosmic Omnibus
EID:addCollectible(CollectibleType.COLLECTIBLE_COSMIC_OMNIBUS, "Randomly teleports you to a non-normal room#30% chance that room will be a newly generated Planetarium", "Cosmic Omnibus", "en_us")
EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_COSMIC_OMNIBUS, "12") -- Bookworm

-- Little Raincoat
EID:addCollectible(CollectibleType.COLLECTIBLE_LITTLE_RAINCOAT, "You get a Power Pill like effect every 6 hits#6% chance for food items to be rerolled#↑ Size down", "Little Raincoat", "en_us")

-- Blood Cyst
EID:addCollectible(CollectibleType.COLLECTIBLE_BLOOD_CYST, "Entering an uncleared room will spawn a Blood Cyst in a random area#Shooting or walking into it will make it burst into 8 tears", "Blood Cyst", "en_us")

-- Polaris
EID:addCollectible(CollectibleType.COLLECTIBLE_POLARIS, "Familiar that will change between 5 random colors every uncleared room#Depending on the color chosen, it will increase or decrease {{Damage}} Damage, {{Shotspeed}} Shot Speed, {{Tearsize}} Tear Size, {{Heart}} Health, and additional tear effects.", "Polaris", "en_us")

-- D9
EID:addCollectible(CollectibleType.COLLECTIBLE_D9, "Rerolls trinkets in current room", "D9", "en_us")

-- Leah's Hair Tie
EID:addCollectible(CollectibleType.COLLECTIBLE_LEAHS_HAIR_TIE, "{{BrokenHeart}} +1 Broken Heart#Killing enemies has less of a chance to grant a broken heart based on how many you have#↑ Removes 1 broken heart every 3 rooms#↑ Grants 2 temporary decaying stat ups every 3 rooms", "Leah's Hair Tie", "en_us")

-- Leah's Torn Heart
EID:addCollectible(CollectibleType.COLLECTIBLE_LEAHS_TORN_HEART, "{{BrokenHeart}} +1 Broken Heart#↑ Minor all stats up for every broken heart#1 broken heart is added every floor#15% chance for a machine to be a confessional", "Leah's Torn Heart", "en_us")

-- Peter's Headband
EID:addCollectible(CollectibleType.COLLECTIBLE_PETERS_HEADBAND, "↑ {{Key}} +1 Key#All enemies in the current room will be raptured every 12 rooms#↑ Rapturing grants random temporary stat increases#↑ Bosses can be raptured", "Peter's Headband", "en_us")

-- Peter's Bloody Fracture
EID:addCollectible(CollectibleType.COLLECTIBLE_PETERS_BLOODY_FRACTURE, "Activates Muddled Cross when picked up#The floor will flip every 6 rooms", "Peter's Bloody Fracture", "en_us")

-- Miriam's Headband
EID:addCollectible(CollectibleType.COLLECTIBLE_MIRIAMS_HEADBAND, "{{Tears}} +1 Tears up#Shooting will charge a Whirlwind shot#The shot is a more powerful version of Polydipsia", "Miriam's Headband", "en_us")

-- Miriam's Putrid Veil
EID:addCollectible(CollectibleType.COLLECTIBLE_MIRIAMS_PUTRID_VEIL, "{{Range}} -2 Tear Height#5% chance to regenerate a half red heart on enemy kills#Enemies will keep taking 20% of your damage for 3 seconds after being hit", "Miriam's Putrid Veil", "en_us")

-- Book of Books
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_BOOKS, "Activates every book item at once#Works with modded books", "Book of Books", "en_us")
EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_BOOK_OF_BOOKS, "12") -- Bookworm

-- Keratoconus
EID:addCollectible(CollectibleType.COLLECTIBLE_KERATOCONUS, "{{Range}} ↑ +0.2 Range#↓ {{Shotspeed}} -0.5 Shot Speed down#Chance to fire a light beam tear with a godhead-like aura that can shrink or grow non-boss enemies", "Keratoconus", "en_us")

-- Servitude
EID:addCollectible(CollectibleType.COLLECTIBLE_SERVITUDE, "A marker appears below the closest item pedestal#Using it makes a counter starting at 7 appear below you#The count decreases by 1 for every room you clear without being hit#↑ You will spawn a duplicate of what the nearest item was if successful#↓ You will gain a {{BrokenHeart}} broken heart and reset the counter if you take damage", "Servitude", "en_us")

-- Cardiomyopathy
EID:addCollectible(CollectibleType.COLLECTIBLE_CARDIOMYOPATHY, "↑ Temporarily gain invulnerability when refilling a red heart container#Luck% chance that picking up a {{Heart}} red heart will grant an empty red heart container#All {{BoneHeart}} bone hearts are converted into empty red heart containers", "Cardiomyopathy", "en_us")

-- Altruism
EID:addTrinket(TrinketType.TRINKET_ALTRUISM, "↑ Donating to any beggar has a chance to heal {{HalfHeart}} half a red heart or receive the resource you donated back", "Altruism", "en_us")

-- Sunscreen
EID:addCollectible(CollectibleType.COLLECTIBLE_SUNSCREEN, "↑ 25% chance to block/ignore fire damage", "Sunscreen", "en_us")

-- Secret Diary
EID:addCollectible(CollectibleType.COLLECTIBLE_SECRET_DIARY, "Gain {{Collectible619}} Birthright for the room", "Secret Diary", "en_us")

-- Nil Num
EID:addTrinket(TrinketType.TRINKET_NIL_NUM, "2% chance to spawn a duplicate of one of your items when hit#Gets destroyed afterwards", "Nil Num", "en_us")

-- D16
EID:addCollectible(CollectibleType.COLLECTIBLE_D16, "Reroll your health#{{Player14}} Keeper or {{Player33}} Tainted Keeper will drain up to 2 coin hearts and spawn that many number of random pickups", "D16", "en_us")

-- Binds of Devotion
EID:addCollectible(CollectibleType.COLLECTIBLE_BINDS_OF_DEVOTION, "{{Player19}} Spawns Jacob as a second character#When he dies, this item is completely removed#!!! He can pick up items, including Story items, removing them permanently on death", "Binds of Devotion", "en_us")

-- Iron
EID:addCollectible(CollectibleType.COLLECTIBLE_IRON, "↑ An orbital that doubles tear size and damage when shooting it#The tear will gain the effect of {{Collectible257}} Fire Mind", "Iron", "en_us")

-- BI-84
EID:addTrinket(TrinketType.TRINKET_BI_84, "25% chance for a random Technology item effect per room", "BI-84", "en_us")

-- Rotten Apple
EID:addCollectible(CollectibleType.COLLECTIBLE_ROTTEN_APPLE, "Gain a random permanent worm trinket on pickup#↑ {{Damage}} +2 Damge up", "Rotten Apple", "en_us")

-- Glitched Penny
EID:addTrinket(TrinketType.TRINKET_GLITCHED_PENNY, "25% chance to activate a random effect of an active item when picking up a coin", "Glitched Penny", "en_us")

-- Beginner's Luck
EID:addCollectible(CollectibleType.COLLECTIBLE_BEGINNERS_LUCK, "↑ {{Luck}} +10 Luck up every floor#↓ Lose {{Luck}} -1 Luck every room until you go back to default luck", "Beginner's Luck", "en_us")

-- Dad's Wallet
EID:addCollectible(CollectibleType.COLLECTIBLE_DADS_WALLET, "Spawns 2 random special cards on pickup", "Dad's Wallet", "en_us")

-- Chi Rho
EID:addCollectible(CollectibleType.COLLECTIBLE_CHI_RHO, "Lasers now home on enemies#They will stay put where they were fired, similarly to {{Collectible222}}Anti-Gravity#↓ They will only deal damage for 1 frame#!!! Will not do anything if you don't fire lasers", "Chi Rho", "en_us")

-- Escape Plan
EID:addTrinket(TrinketType.TRINKET_ESCAPE_PLAN, "10% chance to teleport to the starting room when hit", "Escape Plan", "en_us")

-- Epitaph
EID:addTrinket(TrinketType.TRINKET_EPITAPH, "Dying with this trinket will cause a tombstone to spawn on the floor you died on in the next run#Bombing it 3 times will spawn 3-5 coins, 2-3 keys, and a copy of your first and last passive item from the previous run", "Epitaph", "en_us")

-- Leviathan's Tendril
EID:addTrinket(TrinketType.TRINKET_LEVIATHANS_TENDRIL, "↑ 25% chance to deflect tears away from you#10% to fear nearby enemies#{{Blank}}#↑ +5% chance to both if you have {{Leviathan}} Leviathan transformation", "Leviathan's Tendril", "en_us")

-- Key to the Pit
EID:addTrinket(TrinketType.TRINKET_KEY_TO_THE_PIT, "↑ Allows you to walk into challenge rooms regardless of your health", "Key to the Pit", "en_us")

-- Leah's Heart
EID:addCollectible(CollectibleType.COLLECTIBLE_LEAHS_HEART, "↑ {{Damage}} +1.2x damage up#You will lose the damage up when using an active item and gain a soul heart and mantle#Going to the next floor will give the damage up back", "Leah's Heart", "en_us")

-- Pallium
EID:addCollectible(CollectibleType.COLLECTIBLE_PALLIUM, "Clearing a room grants 1-3 Minisaacs#Minisaacs from Pallium are removed each floor", "Pallium", "en_us")

-- Cold Hearted
EID:addCollectible(CollectibleType.COLLECTIBLE_COLD_HEARTED, "{{Freezing}} Freezes enemies on touch#Touching frozen enemies slide away and explode into 6 ice shards", "Cold Hearted", "en_us")

-- Rotten Love
EID:addCollectible(CollectibleType.COLLECTIBLE_ROTTEN_LOVE, "Spawns 2-3 {{RottenHeart}} Rotten Hearts and 2-3 {{BoneHeart}} Bone Hearts", "Rotten Love", "en_us")

-- Rue
EID:addCollectible(CollectibleType.COLLECTIBLE_RUE, "Fire a brimstone laser at the nearest enemy when hit#Fires in a random direction when there are no enemies", "Rue", "en_us")

-- Exsanguination
EID:addCollectible(CollectibleType.COLLECTIBLE_EXSANGUINATION, "{{Heart}} All hearts have a 50% smaller chance to spawn#↑ Any heart when picked up gives a permanent {{Damage}} +0.1 damage up", "Exsanguination", "en_us")

-- Prayer Journal
EID:addCollectible(CollectibleType.COLLECTIBLE_PRAYER_JOURNAL, "90% chance to grant either a {{SoulHeart}} Soul Heart or {{BlackHeart}} Black Heart or 10% chance to grant a {{BrokenHeart}} Broken Heart", "Prayer Journal", "en_us")
EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_PRAYER_JOURNAL, "12") -- Bookworm

-- Book of Leviticus
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_LEVITICUS, "Spawns 6 clusters of random rocks and obstacles#Clusters will often contain Tinted Rocks", "Book of Leviticus", "en_us")
EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_BOOK_OF_LEVITICUS, "12") -- Bookworm

-- Molten Gold
EID:addCollectible(CollectibleType.COLLECTIBLE_MOLTEN_GOLD, "Taking damage has a 25% chance to activate a random rune's effect", "Molten Gold", "en_us")

-- Trepanation
EID:addCollectible(CollectibleType.COLLECTIBLE_TREPANATION, "A {{Collectible531}} Haemolacria tear is fired every 15 shots#↑ The Haemolacria tear has a 2x damage multiplier", "Trepanation", "en_us")

-- Astragali
EID:addCollectible(CollectibleType.COLLECTIBLE_ASTRAGALI, "Rerolls chests in the current room", "Astragali", "en_us")

-- Liberation
EID:addCollectible(CollectibleType.COLLECTIBLE_LIBERATION, "Kills have a 5% chance to grant flight and open all doors in the current room", "Liberation", "en_us")



-- Soul of Leah
EID:addCard(RUNE_SOUL_OF_LEAH, "{{BrokenHeart}} Grants a broken heart for every uncleared room on the floor#↑ Each broken heart will give a +0.75 damage up#!!! If there are 12 or more uncleared rooms, it will kill you", "Soul of Leah", "en_us")

-- Soul of Peter
EID:addCard(RUNE_SOUL_OF_PETER, "↑ Generates up to 5 new random rooms connected to other random rooms#The rooms will be revealed on the map", "Soul of Peter", "en_us")

-- Soul of Miriam
EID:addCard(RUNE_SOUL_OF_MIRIAM, "It will rain in uncleared rooms, building up water until it covers the whole room#Water deals 0.33x your damage every 0.5 seconds#Effect persists for 40 seconds", "Soul of Miriam", "en_us")

-- Two of Shields
EID:addCard(CARD_TWO_OF_SHIELDS, "{{Battery}} Duplicate your active charge", "Two of Shields", "en_us")

-- Ace of Shields
EID:addCard(CARD_ACE_OF_SHIELDS, "{{Battery}} Turns all pickups, chests and non-boss enemies into micro batteries", "Ace of Shields", "en_us")

-- Trap Card
EID:addCard(CARD_TRAP, "↑ Chains down the nearest enemy for 5 seconds, preventing them from acting", "Trap Card", "en_us")

-- Key Card
EID:addCard(CARD_KEY, "{{Shop}} creates a trapdoor that leads to a second shop with a unique stock", "Key Card", "en_us")

-- Golden Card
EID:addCard(CARD_GOLDEN, "Random card effect#Destroys itself after a few uses", "Golden Card", "en_us")

-- Essence of Love
EID:addCard(OBJ_ESSENCE_OF_LOVE, "Permanently charms all enemies in the room", "Essence of Love", "en_us")

-- Essence of Hate
EID:addCard(OBJ_ESSENCE_OF_HATE, "Adds {{BrokenHeart}} broken hearts until you have 11#↑ Spawns a random pickup for each broken heart added", "Essence of Hate", "en_us")

-- Essence of Life
EID:addCard(OBJ_ESSENCE_OF_LIFE, "Spawns a Minisaac on each enemy in the room", "Essence of Life", "en_us")

-- Essence of Death
EID:addCard(OBJ_ESSENCE_OF_DEATH, "↑ Kills all non-boss enemies in the room#↑ Grants a Swarm Fly orbital for each enemy killed", "Essence of Death", "en_us")

-- Essence of Prosperity
EID:addCard(OBJ_ESSENCE_OF_PROSPERITY, "A rain drop will fall on every enemy#When they hit, they deal 0.66x your damage and slow them for 5 seconds", "Essence of Prosperity", "en_us")

-- Essence of Drought
EID:addCard(OBJ_ESSENCE_OF_DROUGHT, "All non-boss enemies will begin to bleed out#When they die, they will be frozen solid", "Essence of Drought", "en_us")

-- Heartache Up
EID:addPill(PILLEFFECT_HEARTACHE_UP, "↓ Adds one {{BrokenHeart}} Broken Heart", "Heartache Up", "en_us")

-- Heartache Down
EID:addPill(PILLEFFECT_HEARTACHE_DOWN, "↑ Removes one {{BrokenHeart}} Broken Heart", "Heartache Down", "en_us")

-- Moon Heart
EID:addEntity(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 225, "Moon Heart", "Worth 2 HP#Teleports you to the Secret Room when depleted#↓ Only 1 can be held at a time", "en_us")

-- 
EID:addCard(CARD_HOPE, "Killing enemies has a chance to spawn pickups for the room", "XXIII - Hope", "en_us")

-- 
EID:addCard(CARD_REVERSE_HOPE, "Teleports Isaac into an extra challenge room", "XXIII - Hope?", "en_us")

-- 
EID:addCard(CARD_FAITH, "Spawns a Confessional", "XXV - Faith", "en_us")

-- 
EID:addCard(CARD_REVERSE_FAITH, "Spawns two Moon Hearts", "XXV - Faith?", "en_us")

-- 
EID:addCard(CARD_CHARITY, "↑ Uses Jar of Manna 3 times, giving you the pickups you need the most#↑ If no pickups are needed, stat ups will be granted instead", "XXIV - Charity", "en_us")

-- 
EID:addCard(CARD_REVERSE_CHARITY, "Doubles all pickups in the room#The doubled pickups will cost money", "XXIV - Charity?", "en_us")