local mod = Furtherance

function mod:UseKeyCard(card, player, useflags)
	Isaac.GridSpawn(GridEntityType.GRID_STAIRS, 2, player.Position, true)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseKeyCard, CARD_KEY)