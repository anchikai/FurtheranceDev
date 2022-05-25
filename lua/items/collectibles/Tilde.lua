local mod = Furtherance
local game = Game()

InfHP = false
HighDamage = 0
InfCharge = false
HighLuck = 0
QuickKill = false
function mod:UseTilde(_, _, player)
	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_TILDE_KEY)
	local randomDebug = rng:RandomInt(5)
	local hud = game:GetHUD()
	if randomDebug == 0 then
		hud:ShowFortuneText("Infinite HP")
		InfHP = true
	elseif randomDebug == 1 then
		hud:ShowFortuneText("High Damage")
		HighDamage = 40
	elseif randomDebug == 2 then
		hud:ShowFortuneText("Infinite Item Charges")
		InfCharge = true
	elseif randomDebug == 3 then
		hud:ShowFortuneText("High Luck")
		HighLuck = 50
	else
		hud:ShowFortuneText("Quick Kill")
		QuickKill = true
		for i, entity in ipairs(Isaac.GetRoomEntities()) do
			if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
				entity:Die()
			end
		end
	end
	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
	player:AddCacheFlags(CacheFlag.CACHE_LUCK)
	player:EvaluateItems()
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseTilde, CollectibleType.COLLECTIBLE_TILDE_KEY)

function mod:InfiniteHealth(entity, amount, flag)
	player = entity:ToPlayer()
	if InfHP and flag & DamageFlag.DAMAGE_FAKE ~= DamageFlag.DAMAGE_FAKE then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR, false, false, true, false, -1)
		return false
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.InfiniteHealth, EntityType.ENTITY_PLAYER)

function mod:InfiniteCharge(_, _, player)
	if InfCharge then
		ItemUsed = true
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.InfiniteCharge)

function mod:DebugStats(player, flag)
	if flag == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage + HighDamage
	end
	if flag == CacheFlag.CACHE_LUCK then
		player.Luck = player.Luck + HighLuck
	end
	if ItemUsed or (InfCharge and (player:NeedsCharge(ActiveSlot.SLOT_PRIMARY) or player:NeedsCharge(ActiveSlot.SLOT_SECONDARY) or player:NeedsCharge(ActiveSlot.SLOT_POCKET))) then
		ItemUsed = false
		player:FullCharge(ActiveSlot.SLOT_PRIMARY, true)
		player:FullCharge(ActiveSlot.SLOT_SECONDARY, true)
		player:FullCharge(ActiveSlot.SLOT_POCKET, true)
		SFXManager():Stop(SoundEffect.SOUND_BATTERYCHARGE)
		SFXManager():Stop(SoundEffect.SOUND_ITEMRECHARGE)
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.DebugStats)

function mod:ResetDebug()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		InfHP = false
		HighDamage = 0
		InfCharge = false
		HighLuck = 0
		QuickKill = false
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:AddCacheFlags(CacheFlag.CACHE_LUCK)
		player:EvaluateItems()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.ResetDebug)