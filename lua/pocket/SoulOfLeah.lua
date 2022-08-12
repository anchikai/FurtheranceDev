local mod = Furtherance
local game = Game()

function mod:UseSoulOfLeah(card, player, flag)
	SFXManager():Play(Isaac.GetSoundIdByName("BrokenHeartbeat"))
	mod:PlaySND(RUNE_SOUL_OF_LEAH_SFX)
	local data = mod:GetData(player)
	local level = game:GetLevel()
	local roomsList = level:GetRooms()
	for i = 0, roomsList.Size - 1 do
		local room = roomsList:Get(i)
		if room.Data.Type ~= RoomType.ROOM_SUPERSECRET and room.Data.Type ~= RoomType.ROOM_ULTRASECRET then -- based off of world card which doesn't reveal these
			if not room.Clear then
				player:AddBrokenHearts(1)
				if data.SoulOfLeahDamage == nil then
					data.SoulOfLeahDamage = 0
				end
				data.SoulOfLeahDamage = data.SoulOfLeahDamage + 0.75
			end
		end
	end
	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
	player:EvaluateItems()
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseSoulOfLeah, RUNE_SOUL_OF_LEAH)

function mod:SoulDamage(player, flag)
	local data = mod:GetData(player)
	if data.SoulOfLeahDamage then
		player.Damage = player.Damage + data.SoulOfLeahDamage
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.SoulDamage, CacheFlag.CACHE_DAMAGE)