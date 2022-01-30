-- Thank you so much for all the Spanish translations Kotry!!!
-- And now thank you so much for the Russian translations BrakeDude!!!

-- Leah
local normalLeah = Isaac.GetPlayerTypeByName("Leah", false)
EID:addBirthright(normalLeah, "↓ {{BrokenHeart}} +3 broken hearts#↓ Chance of gaining a broken heart on enemy kill is now 25%#↑ A broken heart is now removed every 10 kills instead of every 20#↑ Stats gained through kills are 2x effective", "Leah", "en_us")
EID:addBirthright(normalLeah, "↓ {{BrokenHeart}} +3 сломанных сердец#↓ Шанс получить сломанное сердце при убийстве врага теперь 25%#↑ Сломанное сердце удаляется каждые 10 убийств вместо каждых 20#↑ Характеристики, полученные убийствами, 2x эффективнее", "Лия", "ru")
EID:addBirthright(normalLeah, "↓ {{BrokenHeart}} +3 Corazones rotos#La posibilidad de recibir corazones rotos al matar ahora es de 25%#Perderás un corazón roto al matar 10 enemigos en vez de 20#↑ Las estadísticas ganadas por asesinatos se duplican", "Leah", "spa")

-- Tainted Leah
local taintedLeah = Isaac.GetPlayerTypeByName("Leah", true)
EID:addBirthright(taintedLeah, "Tainted Leah will no longer constantly refill back to {{BrokenHeart}} 11 broken hearts#She will instead refill to only 6#She will gain 0.05 speed for every broken heart instead of lose#↑ +20% chance to charm enemies", "Tainted Leah", "en_us")
EID:addBirthright(taintedLeah, "{{BrokenHeart}}Сломанные серда Порченой Лии больше не будет постоянно пополняться до 11, вместо этого они будет пополняться только до 6#↑ {{Speed}} +0.05 к скорости за каждое разбитое сердце вместо потери#↑ +20% шанс очаровать врагов", "Порченая Лия", "ru")
EID:addBirthright(taintedLeah, "Leah contaminada ya no recibirá {{BrokenHeart}} 11 corazones rotos, en cambio sólo tendrá 6#↑ {{Speed}} Velocidad +0.05 por cada corazón roto que posea#20% de posibilidad de encantar enemigos", "Leah Contaminada", "spa")

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
EID:addCollectible(CollectibleType.COLLECTIBLE_C_KEY, "Teleports you to a large {{Library}} Library with 7 books", "C Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_C_KEY, "Телепортирует в большую {{Library}} Библиотеку с 7 книгами", "Клавиша C", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_C_KEY, "Te teletransporta a una {{Library}} Biblioteca grande con 7 libros", "Tecla C", "spa")

--Caps Key
EID:addCollectible(CollectibleType.COLLECTIBLE_CAPS_KEY, "Makes Isaac large for the current room#Allows Isaac to walk over obstacles to destroy them#↑ {{Damage}} +7 Damage up#↑ {{Range}} +3 Range up", "Caps Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_CAPS_KEY, "Исаак становится большим в текущей комнате#Позволяет Исааку ходить по препядствиям, уничтожая их#↑ {{Damage}} +7 к урону#↑ {{Range}} +3 к дальности", "Клавиша Caps", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_CAPS_KEY, "Vuelve a Isaac más grande durante la habitación#Permite que Isaac destruya obstáculos al caminar sobre ellos#↑ {{Damage}} Daño +7#↑ {{Range}} Alcance +3", "Tecla Bloq Mayús", "spa")

--Enter Key
EID:addCollectible(CollectibleType.COLLECTIBLE_ENTER_KEY, "Attempts to open the Boss Rush door#↑ Ignores in-game timer", "Enter Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_ENTER_KEY, "Попытается открыть дверь к Босс-Рашу#↑ Игнорирует внутреннеигровой таймер", "Клавиша Enter", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_ENTER_KEY, "Intenta abrir la entrada a la Boss Rush#↑ Ignora el cronómetro del juego", "Tecla Enter", "spa")

--Shift Key
EID:addCollectible(CollectibleType.COLLECTIBLE_SHIFT_KEY, "If player is normal, they will become tainted#Tainted will become normal", "Shift Key")
EID:addCollectible(CollectibleType.COLLECTIBLE_SHIFT_KEY, "Если персонаж обычный, он становится порченым#Порченые персонажи становятся обычными", "Клавиша Shift", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_SHIFT_KEY, "Si el jugador está en su forma regular, cambiará a su forma corrompida#La forma corrompida pasará a ser la forma regular", "Tecla Shift", "spa")


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
EID:addCollectible(CollectibleType.COLLECTIBLE_JUNO, "↑ {{SoulHeart}} +1 Soul Heart#Tears that hit an enemy have a chance to chain down the nearest enemy for 5 seconds, preventing them from acting", "Juno", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_JUNO, "↑ {{SoulHeart}} +1 синее сердце#Слезы, попавшие во врага, могут сковать в цепь ближайшего врага на 5 секунд, не позволяя ему двигаться", "Юнона", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_JUNO, "↑ {{SoulHeart}} +1 Corazón de alma#Las lágrimas quer golpeen a un enemigo tienen una posibilidad de encadenar al enemigo más cercano durante 5 segundos, evitando que actúe", "Juno", "spa")

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
--EID:addCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1, "Shoots a Technology laser opposite of the direction you are shooting", "Technology -1", "en_us")
--EID:addCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1, "Стреляет лазером Технологии в обратном направлении стрельбы", "Технология -1", "ru")
--EID:addCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1, "Shoots a Technology laser opposite of the direction you are shooting", "Tecnología -1", "spa")

-- Book of Swiftness
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS, "Slows down enemies#↑ {{Speed}} +0.5 Speed up#↓ {{Shotspeed}} -1 Shot Speed down#Effect lasts for current room", "Book of Swiftness", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS, "Замедляет врагов#↑ {{Speed}} +0.5 к скорости#↓ {{Shotspeed}} -1 скорость слезы#Эффект длится для текущей комнате", "Книга скорости", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS, "Ralentiza a  los enemigos#↑ {{Speed}} Velocidad +0.5#↓  {{Shotspeed}} Vel. de tiro -1#El efecto sólo dura en la habitación", "Libro de la agilidad", "spa")
EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS, "12") -- Bookworm

-- Book of Ambit
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT, "↑ {{Range}} +5 Range up when used#Grants piercing tears when used", "Book of Ambit", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT, "↑ {{Range}} +5 к дальности при использовании#Дарует cквозные слезы при использовании", "Книга предела", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT, "Al usarlo, otorga: #↑ {{Range}} Rango +5#Lágrimas penetrantes", "Libro del alcance", "spa")
EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT, "12") -- Bookworm

-- Plug N' Play
EID:addCollectible(CollectibleType.COLLECTIBLE_NEASS, "Spawns a 'glitched' item#They have completely random effects", "Plug N' Play", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_NEASS, "Создает 'глючный' предмет#Все эффекты полностью случайны", "Plug N' Play", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_NEASS, "Genera un objeto 'glitcheado', con comportamiento completamente aleatorio", "Plug N' Play", "spa")

-- Cringe
EID:addTrinket(TrinketType.TRINKET_CRINGE, "All ememies in the room will be briefly frozen when you take damage#↑ Hurt sound is replaced with Bruh sound effect", "Cringe", "en_us")
EID:addTrinket(TrinketType.TRINKET_CRINGE, "Все враги в комнате на момент будут заморожены когда вы получаете урон#↑ Звук боли заменен звуковым эффектом 'Bruh'", "Кринж", "ru")
EID:addTrinket(TrinketType.TRINKET_CRINGE, "Todos los enemigos serán congelados por un corto momento al recibir un daño#↑ El efecto de sonido de ser herido será reemplazado con el efecto de sonido 'Bruh'", "Cringe", "spa")

-- ZZZZoptionsZZZZ
EID:addCollectible(CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ, "Two items now spawn in all {{TreasureRoom}}Treasure Rooms#You can choose both#One of the items will be 'glitched' and spawn in a random location of the room", "ZZZZoptionsZZZZ", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ, "Два предмета появляются во всех {{TreasureRoom}}комнатах сокровищ#Можно взять оба предмета#Один из них будет 'глючным' и появится в случайном месте комнаты", "0nЦ(2xИ)", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ, "Ahora aparecerán dos objetos en la {{TreasureRoom}} Sala del tesoro#Puedes elegir entre los dos#Uno de esos objetos estará 'glitcheado' y aparecerá en una parte aleatoria de la sala", "OpCIoNeZ", "spa")

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
EID:addCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART, "{{BrokenHeart}} Removes 1 broken heart", "Shattered Heart", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART, "{{BrokenHeart}} Удаляет 1 сломанное сердце", "Разбитое сердце", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART, "{{BrokenHeart}} Remueve un corazón roto", "Corazón Destrozado", "spa")

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
EID:addCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR, "{{BrokenHeart}} Removes 1 broken heart#↑ Grants either +0.25 Damage up or +0.23 Tears up for the current room#!!! Passively grants 1 broken heart per room", "Heart Renovator", "en_us")
EID:addCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR, "{{BrokenHeart}} Удаляет 1 сломанное сердце#↑ Даёт либо +0.25 к урону, либо +0.23 к скорострельности в текущей комнате#!!! Пассивно даёт 1 сломанное сердце за комнату", "Сердечный восстановитель", "ru")
EID:addCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR, "{{BrokenHeart}} Remueve un corazón rojot#↑ Puede dar Daño +0.25 o Lágrimas +0.23 durante la habitación#!!! Otorga un corazón roto de forma pasiva por sala", "Renovador cardiaco", "spa")

-- Grass
EID:addTrinket(TrinketType.TRINKET_GRASS, "Starts a 1 hour timer#The trinket will be removed when timer ends and {{Collectible210}} Gnawed Leaf will spawn#!!! The timer will reset if the trinket is dropped", "Grass", "en_us")
EID:addTrinket(TrinketType.TRINKET_GRASS, "Запускает 1 часовой таймер#При истечении таймера брелок исчезнет и появится {{Collectible210}} Обглоданный лист#!!! Таймер сбрасывается, если брелок был выброшен", "Трава", "ru")
EID:addTrinket(TrinketType.TRINKET_GRASS, "Starts a 1 hour timer#The trinket will be removed when timer ends and Gnawed Leaf will spawn#!!! The timer will reset if the trinket is dropped", "Grass", "spa")