local mod = further
local game = Game()
local rng = RNG()
local bhb = Isaac.GetSoundIdByName("BrokenHeartbeat")

normalMiriam = Isaac.GetPlayerTypeByName("Miriam", false)
taintedMiriam = Isaac.GetPlayerTypeByName("MiriamB", true)

COSTUME_MIRIAM_A_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_003_Miriam_Hair.anm2")
COSTUME_MIRIAM_B_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_003b_Miriam_Hair.anm2")

function mod:OnInit(player)
	local data = mod:GetData(player)
	data.Init = true
	if player:GetName() == "Miriam" then -- If the player is Miriam it will apply her hair
		player:AddNullCostume(COSTUME_MIRIAM_A_HAIR)
		costumeEquipped = true
	elseif player:GetName() == "MiriamB" then -- Apply different hair for her tainted variant
		player:AddNullCostume(COSTUME_MIRIAM_B_HAIR)
		costumeEquipped = true
		player:AddBoneHearts(2)
		player:AddHearts(4)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:OnUpdate(player)
	local room = game:GetRoom()
	local data = mod:GetData(player)
	if player:GetName() == "Miriam" then
		
	elseif player:GetName() == "MiriamB" then
		
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.OnUpdate)

function mod:Hearts(entity, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
		local collider = collider:ToPlayer()
		local data = mod:GetData(collider)
		if collider:GetName() == "MiriamB" then -- Prevent Tainted Miriam from obtaining Red Health
			if entity.SubType == HeartSubType.HEART_DOUBLEPACK or entity.SubType == HeartSubType.HEART_FULL or entity.SubType == HeartSubType.HEART_HALF 
			or entity.SubType == HeartSubType.HEART_ROTTEN or entity.SubType == HeartSubType.HEART_SCARED then
				return false
			elseif entity.SubType == HeartSubType.HEART_BLENDED then
				if collider:GetSoulHearts() + collider:GetBoneHearts() * 2 < 24 then
					entity:GetSprite():Play("Collect",true)
					entity:Die()
					SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
					collider:AddSoulHearts(2)
				end
				return false
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.Hearts, PickupVariant.PICKUP_HEART)

function mod:miriamStats(player, flag)
	local data = mod:GetData(player)
	if player:GetName() == "Miriam" then -- If the player is Miriam it will apply her stats
		if flag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + 0.25
		end
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 17.39999961853
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 0.5
		end
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange - 100
		end
	elseif player:GetName() == "MiriamB" then -- If the player is Tainted Miriam it will apply her stats
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 0.5
		end
		if flag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck - 2
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.miriamStats)

function mod:ClickerFix(_, _, player)
	if player:GetName() == "Miriam" then
		player:TryRemoveNullCostume(COSTUME_MIRIAM_A_HAIR)
		player:AddNullCostume(COSTUME_MIRIAM_A_HAIR)
	elseif player:GetName() == "MiriamB" then
		player:TryRemoveNullCostume(COSTUME_MIRIAM_B_HAIR)
		player:AddNullCostume(COSTUME_MIRIAM_B_HAIR)
	end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerFix, CollectibleType.COLLECTIBLE_CLICKER)
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerFix, CollectibleType.COLLECTIBLE_SHIFT_KEY)