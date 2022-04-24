local mod = Furtherance
local game = Game()

function mod:UseTambourine(_, _, player)
	local data = mod:GetData(player)
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseTambourine, CollectibleType.COLLECTIBLE_TAMBOURINE)