local mod = further
local game = Game()

function mod:CollectPlayerItems(player)
	local data = mod:GetData(player)
	local numAngelItems = 0
	if player:HasTrinket(TrinketType.TRINKET_ALABASTER_SCRAP, false) then
		local config = Isaac.GetItemConfig()
		local max = config:GetCollectibles().Size
		local n
		-- Loop over every item ID in the game including modded items.
		for i = 1, max do
			-- For the ID "i", count how many of that item the player has.
			n = player:GetCollectibleNum(i, true)
			if n > 0 then
				-- The player has "n" of the item with ID "i".
				if config:GetCollectible(i) and config:GetCollectible(i):HasTags(ItemConfig.TAG_ANGEL) then
					-- This is a valid item with the "angel" tag.
					numAngelItems = numAngelItems + n
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.CollectPlayerItems)

function mod:AlabasterDmg(player, flag)
	local data = mod:GetData(player)
	local goldenbox = player:GetTrinketMultiplier(TrinketType.TRINKET_ALABASTER_SCRAP)
	if player:HasTrinket(TrinketType.TRINKET_ALABASTER_SCRAP, false) then
		if data.numAngelItems == nil then
			data.numAngelItems = 0
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + data.numAngelItems * goldenbox
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.AlabasterDmg)