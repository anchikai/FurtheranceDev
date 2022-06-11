local mod = Furtherance
local game = Game()
local rng = RNG()

local Settings = {
	MoveSpeed = 4.25,
	Range = 120,
	SlowAmount  = 0.1,
	ShakeThreshold = 10,
	NeededShakes = 10,
	StunTime = 20,
	RandomOffset = 10
}

local States = {
	Appear = 0,
	Chilling = 1,
	Chasing = 2,
	Attached = 3
}



function mod:GoonInit(entity)
	if entity.Variant == 3071 then
		local data = entity:GetData()
		local sprite = entity:GetSprite()
		local level = game:GetLevel()
		local stage = level:GetStage()

		-- Nose color / stage skins
		-- Champion
		if entity:IsChampion() then
			sprite:ReplaceSpritesheet(2, "gfx/monsters/goons/goon_nose_champion.png")

		-- Blue
		elseif stage == LevelStage.STAGE4_3 then
			sprite:ReplaceSpritesheet(0, "gfx/monsters/goons/blue_goon.png")
			sprite:ReplaceSpritesheet(1, "gfx/monsters/goons/blue_goon.png")
			sprite:ReplaceSpritesheet(2, "gfx/monsters/goons/blue_goon_nose.png")

		-- Devilish / regular
		else
			-- Devilish skin
			local goonType = ""
			if stage == LevelStage.STAGE5 and level:GetStageType() == StageType.STAGETYPE_ORIGINAL then
				sprite:ReplaceSpritesheet(0, "gfx/monsters/goons/devilish_goon.png")
				sprite:ReplaceSpritesheet(1, "gfx/monsters/goons/devilish_goon.png")
				goonType = "devilish_"
			end
			
			-- Nose color
			local noseColor = rng:RandomInt(4)
			sprite:ReplaceSpritesheet(2, "gfx/monsters/goons/" .. goonType .. "goon_nose_" .. noseColor .. ".png")
		end
		sprite:LoadGraphics()
		
		-- Multiple spawner
		if entity.SubType > 0 then
			for i = 0, entity.SubType - 1 do -- High amounts near rocks will most likely result in some of them spawning on top of the rocks!
				local getPos = Vector(math.random(-Settings.RandomOffset, Settings.RandomOffset), math.random(-Settings.RandomOffset, Settings.RandomOffset))
				Isaac.Spawn(entity.Type, entity.Variant, 0, entity.Position + getPos, Vector.Zero, nil)
			end
			entity.Position = entity.Position + Vector(math.random(-Settings.RandomOffset, Settings.RandomOffset), math.random(-Settings.RandomOffset, Settings.RandomOffset))
			entity.SubType = 0
		end
		data.state = States.Appear
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.GoonInit, 200)

function mod:GoonUpdate(entity)
	if entity.Variant == 3071 then
		local data = entity:GetData()
		local target = entity:GetPlayerTarget()
		local sprite = entity:GetSprite()


		if data.state == States.Appear then
			entity.Velocity = Vector.Zero
			data.state = States.Chilling

			if not sprite:IsPlaying("Idle") and not sprite:IsPlaying("GetUp") then
				sprite:Play("Idle", true)
			end
			if entity.Index % 2 == 1 then
				sprite.FlipX = true
			end


		elseif data.state == States.Chilling then
			entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
			sprite.Offset = Vector.Zero
			entity.Velocity = (entity.Velocity + (Vector.Zero - entity.Velocity) * 0.25)

			if not sprite:IsPlaying("Idle") and not sprite:IsPlaying("GetUp") then
				sprite:Play("Idle", true)
			end
			
			if data.timer then
				if data.timer <= 0 then
					data.timer = nil
				else
					data.timer = data.timer - 1
				end
			end

			-- Get up
			if entity.Position:Distance(target.Position) <= Settings.Range and not data.timer then
				if not sprite:IsPlaying("GetUp") then
					sprite:Play("GetUp", true)
				end
			end
			if sprite:IsPlaying("GetUp") and sprite:GetFrame() == 6 then
				data.state = States.Chasing
			end


		elseif data.state == States.Chasing then
			-- Movement
			local speed = Settings.MoveSpeed
			if entity:HasEntityFlags(EntityFlag.FLAG_FEAR) or entity:HasEntityFlags(EntityFlag.FLAG_SHRINK) then
				speed = -speed
			end

			if entity:HasEntityFlags(EntityFlag.FLAG_CONFUSION) then
				entity.Pathfinder:MoveRandomly(false)

			else
				if entity.Pathfinder:HasPathToPos(target.Position) then
					if game:GetRoom():CheckLine(entity.Position, target.Position, 0, 0, false, false) then
						entity.Velocity = (entity.Velocity + ((target.Position - entity.Position):Normalized() * speed - entity.Velocity) * 0.25)
					else
						entity.Pathfinder:FindGridPath(target.Position, speed / 6, 500, false)
					end

				else
					entity.Velocity = (entity.Velocity + (Vector.Zero - entity.Velocity) * 0.25)
				end
			end


			-- Animation
			entity:AnimWalkFrame("WalkHori", "WalkVert", 0.1)

			-- Get head direction
			local angleDegrees = entity.Velocity:GetAngleDegrees()
			if angleDegrees >= 45 and angleDegrees <= 135 then
				data.facing = "Down"
			elseif angleDegrees <= -45 and angleDegrees >= -135 then
				data.facing = "Up"
			else
				data.facing = "Hori"
			end

			-- Head animation
			if entity.Velocity:Length() > 0.1 then
				if not sprite:IsOverlayPlaying("Head" .. data.facing) then
					sprite:PlayOverlay("Head" .. data.facing, true)
				end
			else
				sprite:SetOverlayFrame("HeadDown", 0)
			end


		elseif data.state == States.Attached then
			entity.Position = entity.Parent.Position
			entity.Velocity = entity.Parent.Velocity

			sprite:RemoveOverlay()
			entity.DepthOffset = entity.Parent.DepthOffset + 10
			if not sprite:IsPlaying("Cling") then
				sprite:Play("Cling", true)
			end
			sprite.Offset = Vector(-8, -1)

			-- Slow player down
			if 1 - (#entity.Parent:GetData().goonies * Settings.SlowAmount) > 0.1 then
				entity.Parent:AddSlowing(EntityRef(entity), 1, 1 - (#entity.Parent:GetData().goonies * Settings.SlowAmount), Color(1,1,1,1,0,0,0))
			else
				entity.Parent:AddSlowing(EntityRef(entity), 1, 0.1, Color(1,1,1,1,0,0,0))
			end

			if entity.Index == entity.Parent:GetData().goonies[1] then
				-- Get random first needed direction
				if not data.needDir then
					data.needDir = 0 + (math.random(0,1) * 2)
				end

				-- Check if player is moving back and forth
				if entity.Parent:ToPlayer():GetMovementDirection() == data.needDir then
					if data.shakes then
						data.shakes = data.shakes + 1
					else
						data.shakes = 1
					end

					if data.needDir == 0 then
						data.needDir = 2
					else
						data.needDir = 0
					end
					
					data.timer = Settings.ShakeThreshold
				end

				-- Reset shake count if player is too slow
				if data.timer then 
					if data.timer <= 0 then
						data.shakes = 0
					else
						data.timer = data.timer - 1
					end
				end
				
				-- Fall off
				if data.shakes and data.shakes >= Settings.NeededShakes then
					data.shakes = 0
					table.remove(entity.Parent:GetData().goonies, 1)
					data.state = States.Chilling
					entity.Parent:ClearEntityFlags(EntityFlag.FLAG_SLOW)

					local mult = 1
					if sprite.FlipX == false then
						mult = -1
					end
					entity.Velocity = Vector(mult * 15, math.random(-10,10))

					data.timer = Settings.StunTime
					SFXManager():Play(SoundEffect.SOUND_BABY_HURT)
				end
			end
		end


		-- Remove from parent list on death
		if entity:HasMortalDamage() and entity:IsDead() and entity.Parent and entity.Parent:GetData().goonies then
			for i,g in pairs(entity.Parent:GetData().goonies) do
				if g == entity.Index then
					table.remove(entity.Parent:GetData().goonies, i)
					entity.Parent:ClearEntityFlags(EntityFlag.FLAG_SLOW)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.GoonUpdate, 200)

-- Attach to player
function mod:GoonCollide(goon, collider)
	if goon.Variant == 3071 and collider.Type == EntityType.ENTITY_PLAYER and goon:GetData().state == States.Chasing then
		if not collider:GetData().goonies then
			collider:GetData().goonies = {}
		end

		if collider:GetData().goonies then
			local add = true
			for i,g in pairs(collider:GetData().goonies) do
				if collider:GetData().goonies[i] == goon.Index then
					add = false
				end
			end

			if add == true then
				table.insert(collider:GetData().goonies, goon.Index)
				goon.Parent = collider
				goon.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
				goon:GetData().state = States.Attached
				SFXManager():Play(SoundEffect.SOUND_KISS_LIPS1, 1.2)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, mod.GoonCollide, 200)

-- Clear any goons that didn't get removed
function mod:ClearGoons()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetData().goonies then
			player:GetData().goonies = nil
			player:ClearEntityFlags(EntityFlag.FLAG_SLOW)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.ClearGoons)