local mod = Furtherance
local game = Game()

function Shuffle(list)
	local size, shuffled  = #list, list
    for i = size, 2, -1 do
		local j = math.random(i)
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	end
    return shuffled
end

function mod:UseD16(_, _, player)
	local BoneHearts = player:GetBoneHearts()
	local BrokenHearts = player:GetBrokenHearts()
	local RedHearts = player:GetMaxHearts()
	local SoulHearts = player:GetSoulHearts()
    local playersHealth = {}
    table.insert(playersHealth, BoneHearts)
    table.insert(playersHealth, BrokenHearts)
    table.insert(playersHealth, RedHearts)
    table.insert(playersHealth, SoulHearts)
    if player:GetPlayerType() == PlayerType.PLAYER_KEEPER or player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B then
        
    else
        playersHealth = Shuffle(playersHealth)
        player:AddBoneHearts(-player:GetBoneHearts() + playersHealth[1])
        player:AddBrokenHearts(-player:GetBrokenHearts() + playersHealth[2])
        player:AddMaxHearts(-player:GetMaxHearts() + playersHealth[3])
        player:AddSoulHearts(-player:GetSoulHearts() + playersHealth[4])
        if player:GetEffectiveMaxHearts() <= 0 and player:GetSoulHearts() <= 0 then
            player:AddMaxHearts(2)
        end
        player:AddHearts(2)
    end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseD16, CollectibleType.COLLECTIBLE_D16)