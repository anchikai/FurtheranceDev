local mod = Furtherance
local game = Game()

function mod.SetCanShoot(player, canshoot) -- Funciton Credit: im_tem
    local oldchallenge = game.Challenge

    game.Challenge = canshoot and 0 or 6
    player:UpdateCanShoot()
    game.Challenge = oldchallenge
end

function mod:GetSpiritualWound(player, flag)
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)) or player:GetName() == "MiriamB" then
        mod.SetCanShoot(player, false)
	else
        mod.SetCanShoot(player, true)
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetSpiritualWound)

function mod:EnemyTethering(player)
	local data = player:GetData()
    local room = game:GetRoom()

	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)) or player:GetName() == "MiriamB" then
		-- Target (credit to lambchop_is_ok for the base for this)
		local b_left = Input.IsActionPressed(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
		local b_right = Input.IsActionPressed(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
		local b_up = Input.IsActionPressed(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
		local b_down = Input.IsActionPressed(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
		local isAttacking = (b_down or b_right or b_left or b_up)
		
		-- Reset data on new room
		if data.spiritualWoundTarget and not data.spiritualWoundTarget:Exists() then
			data.spiritualWoundTarget = nil
		end
		
		-- Create target
		if isAttacking and not data.spiritualWoundTarget then
			data.spiritualWoundTarget = Isaac.Spawn(1000, 7886, 0, player.Position, Vector.Zero, player):ToEffect()
			local target = data.spiritualWoundTarget

			target.Parent = player
			target.SpawnerEntity = player
			target.DepthOffset = -100
			target:GetSprite():Play("Blink", true)
			target.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
		end
		
		-- If target exists
		if data.spiritualWoundTarget and data.spiritualWoundTarget:Exists() then
			local target = data.spiritualWoundTarget
			local targetData = target:GetData()
			targetData.snapCooldown = nil 

			-- Movement
			if targetData.vector == nil then
				targetData.vector = Vector.Zero
			end
			if not (b_left or b_right) then
				targetData.vector.X = 0
			end
			if not (b_up or b_down) then
				targetData.vector.Y = 0
			end
			
			if b_left and not b_right then
				targetData.vector.X = -1
			elseif b_right then
				targetData.vector.X = 1
			end
			if b_up and not b_down then
				targetData.vector.Y = -1
			elseif b_down then
				targetData.vector.Y = 1
			end
			
			if targetData.vector ~= nil then
				-- Snap to closest enemy if player isn't moving target
				if not isAttacking then
					if targetData.cooldown <= 0 and targetData.enemyTarget and targetData.enemyTarget:GetData().spiritualWound == true then
						--target.Position = targetData.enemyTarget.Position
						if target.Position:Distance(targetData.enemyTarget.Position) > 10 then
							target.Velocity = (target.Velocity + ((targetData.enemyTarget.Position - target.Position):Normalized() * 75 - target.Velocity) * 0.25)
						else
							target.Velocity = targetData.enemyTarget.Velocity
							target.Position = targetData.enemyTarget.Position
						end
					else
						targetData.cooldown = targetData.cooldown - 1
					end
				else
					targetData.cooldown = 15
				end

				target.Velocity = (target.Velocity + (targetData.vector * (player.ShotSpeed * 6.25) - target.Velocity) * 0.5)
			end
			
			-- Damaging
			if (room:GetAliveBossesCount() + room:GetAliveEnemiesCount() > 0) then
				local ClosestEnemyDistance = 9999999999

				-- Detect which enemy is the closest to the target
				for _, entity in ipairs(Isaac.FindInRadius(target.Position, player.TearRange, EntityPartition.ENEMY)) do
					if entity:IsVulnerableEnemy() and entity.Type ~= EntityType.ENTITY_FIREPLACE and (not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_PERSISTENT)) then
						local NewDistance = entity.Position:DistanceSquared(target.Position)
						if NewDistance < ClosestEnemyDistance then
							targetData.enemyTarget = entity
							ClosestEnemyDistance = NewDistance
							entity:GetData().spiritualWound = true
						end
					end
				end

				-- Damage the closest enemy every (player fire delay) frames with 0.33x of the players damage
				if targetData.enemyTarget ~= nil and room:GetFrameCount() % player.MaxFireDelay == 0 then
					targetData.enemyTarget:TakeDamage(player.Damage*0.33, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 1)
					targetData.enemyTarget:SetColor(Color(1, 0, 0, 1, 0, 0, 0), 12, 1, false, false)
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.EnemyTethering)

function mod:SpiritualKill(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
        if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)) or player:GetName() == "MiriamB" then
            if entity.Type ~= EntityType.ENTITY_FIREPLACE and (not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_PERSISTENT)) then
                if rng:RandomInt(20) == 1 then
                    SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
                    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
                    player:AddHearts(1)
                end
            end
        end
	end
	
	if entity:GetData().spiritualWound then
		entity:GetData().spiritualWound = false
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.SpiritualKill)