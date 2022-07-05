local mod = Furtherance
local game = Game()

function mod:NewLevel()
    for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        data.UsedActiveItem = false
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.NewLevel)

function mod:UseActive(_, _, player)
    local data = mod:GetData(player)
    if data.UsedActiveItem ~= true and player:HasCollectible(CollectibleType.COLLECTIBLE_LEAHS_HEART) then
        data.UsedActiveItem = true
        player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
        player:AddSoulHearts(2)
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
        player:EvaluateItems()
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseActive)

function mod:HeartDamage(player)
    local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_LEAHS_HEART) and data.UsedActiveItem ~= true then
		player.Damage = player.Damage * 1.2
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.HeartDamage, CacheFlag.CACHE_DAMAGE)