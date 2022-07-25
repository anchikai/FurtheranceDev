local mod = Furtherance
local rng = RNG()

local HopeActive = false
function mod:UseHope(card, player, flag)
	HopeActive = true
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseHope, CARD_HOPE)

function mod:NewRoom()
	HopeActive = false
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.NewRoom)

function mod:HopeKills(entity)
	if HopeActive then
        if rng:RandomFloat() <= 0.2 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, 0, 0, entity.Position, Vector.Zero, player)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.HopeKills)