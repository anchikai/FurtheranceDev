local mod = further
local game = Game()
local rng = RNG()

normalPeter = Isaac.GetPlayerTypeByName("Peter", false)
taintedPeter = Isaac.GetPlayerTypeByName("PeterB", true)

COSTUME_PETER_A_DRIP = Isaac.GetCostumeIdByPath("gfx/characters/Character_002_Peter_Drip.anm2")
COSTUME_PETER_B_DRIP = Isaac.GetCostumeIdByPath("gfx/characters/Character_002b_Peter_Drip.anm2")

function mod:OnInit(player)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then -- If the player is Peter it will apply his drip
		player:AddNullCostume(COSTUME_PETER_A_DRIP)
		costumeEquipped = true
		--player:AddCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR, 0, true, ActiveSlot.SLOT_PRIMARY, 0)
	elseif player:GetName() == "PeterB" then -- Apply different drip for his tainted variant
		--player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_SHATTERED_HEART, ActiveSlot.SLOT_POCKET, false)
		player:AddNullCostume(COSTUME_PETER_B_DRIP)
		costumeEquipped = true
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:OnUpdate(player)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then
		
	elseif player:GetName() == "PeterB" then
		
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.OnUpdate)

function mod:PeterStats(player, flag)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then -- If the player is Peter it will apply his stats
		if flag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay - 1
		end
		if flag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 0.5 + 1.25
		end
	elseif player:GetName() == "PeterB" then -- If the player is Tainted Peter it will apply his stats
		
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.PeterStats)