local mod = Furtherance
local game = Game()

function mod.SetCanShoot(player, canshoot) -- Funciton Credit: im_tem
    local oldchallenge = game.Challenge

    game.Challenge = canshoot and 0 or 6
    player:UpdateCanShoot()
    game.Challenge = oldchallenge
end

function mod:GetSpiritualWound(player, flag)
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)) then
		if flag == CacheFlag.CACHE_RANGE then
			player.TearHeight = player.TearHeight + 2
		end
        mod.SetCanShoot(player, false)
	else
        mod.SetCanShoot(player, true)
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetSpiritualWound)

function mod:EnemyTethering(player)
	local data = mod:GetData(player)
    local room = game:GetRoom()
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)) then
        if (room:GetAliveBossesCount() + room:GetAliveEnemiesCount() > 0) then
            local ClosestEnemy = nil
            local ClosestEnemyDistance = 9999999999
            -- Detect which enemy is the closest to Isaac
            for _, entity in ipairs(Isaac.FindInRadius(player.Position, player.TearRange, EntityPartition.ENEMY)) do
                if entity:IsVulnerableEnemy() and entity.Type ~= EntityType.ENTITY_FIREPLACE and (not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_PERSISTENT)) then
                    local NewDistance = entity.Position:DistanceSquared(player.Position)
                    if NewDistance < ClosestEnemyDistance then
                        ClosestEnemy = entity
                        ClosestEnemyDistance = NewDistance
                    end
                end
            end
            -- Damage the closest enemy every (player fire delay) frames with 0.33x of the players damage
            if ClosestEnemy ~= nil and room:GetFrameCount()%player.MaxFireDelay == 0 then
                ClosestEnemy:TakeDamage(player.Damage*0.33, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 1)
                ClosestEnemy:SetColor(Color(1, 0, 0, 1, 0, 0, 0), 12, 1, false, false)
            end
        end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.EnemyTethering)

function mod:SpiritualKill(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
        if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)) then
            if entity.Type ~= EntityType.ENTITY_FIREPLACE and (not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_PERSISTENT)) then
                if rng:RandomInt(20) == 1 then
                    SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
                    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
                    player:AddHearts(1)
                end
            end
        end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.SpiritualKill)