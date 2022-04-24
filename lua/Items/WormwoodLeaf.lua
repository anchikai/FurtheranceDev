local mod = Furtherance
local game = Game()

function mod:LeafDamage(player)
	player = player:ToPlayer()
	if player:HasTrinket(TrinketType.TRINKET_WORMWOOD_LEAF, false) then
		local rng = player:GetTrinketRNG(TrinketType.TRINKET_WORMWOOD_LEAF)
		local goldenbox = player:GetTrinketMultiplier(TrinketType.TRINKET_WORMWOOD_LEAF)
		local data = mod:GetData(player)
		if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) and not player:HasCollectible(CollectibleType.COLLECTIBLE_ISAACS_HEART)
		and (rng:RandomFloat() <= (0.02 * goldenbox)) then
			if data.costume == -1 then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector.Zero, player)
				player:AddCostume(Isaac.GetItemConfig():GetNullItem(4), false)
				data.costume = 45
			end
		end
		if data.costume > 0 then
			return false
		end
	end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.LeafDamage, EntityType.ENTITY_PLAYER)

function mod:StatueTimer(player)
	local data = mod:GetData(player)
	if data.costume == nil then
		data.costume = -1
	elseif data.costume > -1 then
		data.costume = data.costume - 1
	end
	if data.costume == 15 then
		player:RemoveCostume(Isaac.GetItemConfig():GetNullItem(4), false)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.StatueTimer)

function mod:CantMove(player)
	return not (player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) or player:IsCoopGhost() or player:HasCurseMistEffect())
end

function mod:NoMovement(entity, hook, button)
	if entity ~= nil and entity.Type == EntityType.ENTITY_PLAYER and not entity:IsDead() and hook == InputHook.GET_ACTION_VALUE then
		local player = entity:ToPlayer()
		if player:HasTrinket(TrinketType.TRINKET_WORMWOOD_LEAF, false) then
			local data = mod:GetData(player)
			if data.costume > 15 then
				if mod:CantMove(player) then
					--if not player:HasCurseMistEffect() then
						if button == ButtonAction.ACTION_LEFT then
							return 0
						end
						if button == ButtonAction.ACTION_RIGHT then
							return 0
						end
						if button == ButtonAction.ACTION_UP then
							return 0
						end
						if button == ButtonAction.ACTION_DOWN then
							return 0
						end
					--end
				end
			end
		end
	end

end

mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, mod.NoMovement, 2)