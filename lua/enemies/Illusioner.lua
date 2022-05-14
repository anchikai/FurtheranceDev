local mod = Furtherance
local game = Game()

local Settings = {
	MoveSpeed = 3.5,
	AngrySpeed = 5.5,
	Cooldown = 90,
	Range = 160,
	ShotSpeed = 11,
	FearTime = 45,
	WanderOffTimer = {60,150},
	RandomOffset = 10,
	
	VariantID = 3070,
	RealID = 0,
	UnmaskID = 1,
	CloneID = 2,
	ExtraID = 16, -- Should correspond with subtype in Basement Renovator, which should be the same as the amount of max clones they can have!
	MaxExtraClones = 16 -- Should correspond with max clones you can set in Basement Renovator (the Length value, which is 2 to the power of n)!
}

local States = {
	Appear = 0,
	Moving = 1,
	Attacking = 2,
	Unmask = 3,
	Angry = 4
}


function mod:shyGalInit(entity)
	if entity.Variant == Settings.VariantID then
		local data = entity:GetData()

		-- Properties
		entity:ToNPC()
		entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
		entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND

		data.state = States.Appear
		entity.ProjectileCooldown = math.random(Settings.Cooldown / 2, Settings.Cooldown)
		data.place = Isaac:GetRandomPosition()
		data.timer = math.random(Settings.WanderOffTimer[1], Settings.WanderOffTimer[2])
		data.wanderOff = false

		-- Subtypes
		-- Spawn clones
		if entity.SubType >= Settings.ExtraID then
			for i = 0, entity.SubType - 16 do -- High amounts near rocks will most likely result in some of them spawning on top of the rocks!
				local getPos = Vector(math.random(-Settings.RandomOffset, Settings.RandomOffset), math.random(-Settings.RandomOffset, Settings.RandomOffset))
				Isaac.Spawn(entity.Type, entity.Variant, Settings.CloneID, entity.Position + getPos, Vector.Zero, nil)
			end
			entity.Position = entity.Position + Vector(math.random(-Settings.RandomOffset, Settings.RandomOffset), math.random(-Settings.RandomOffset, Settings.RandomOffset))
			entity.SubType = Settings.RealID
		
		elseif entity.SubType == Settings.UnmaskID then
			data.state = States.Angry

		elseif entity.SubType > Settings.CloneID and entity.SubType < Settings.ExtraID then
			entity.SubType = Settings.CloneID
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.shyGalInit, 200)


function mod:shyGalUpdate(entity)
	if entity.Variant == Settings.VariantID then
		local sprite = entity:GetSprite()
		local data = entity:GetData()
		local target = entity:GetPlayerTarget()

		
		-- Kill the clones if all real ones are dead
		if entity.SubType == Settings.CloneID then
			local count = 0
			for i,e in pairs(Isaac.GetRoomEntities()) do
				if e.Type == entity.Type and e.Variant == entity.Variant and (e.SubType == Settings.RealID or e.SubType == Settings.UnmaskID) then
					count = count + 1
				end
			end
			if count <= 0 then
				entity:Die()
			end
		end
		
		
		if data.state == States.Appear or data.state == nil then
			sprite:SetFrame("WalkDown", 0)
			sprite:SetOverlayFrame("Head", 0)
			data.state = States.Moving
			entity.Velocity = Vector.Zero
			
		elseif data.state == States.Unmask then
			if not sprite:IsOverlayPlaying("Unmask") then
				sprite:PlayOverlay("Unmask", true)
			end
			data.state = States.Angry


		else
			entity:AnimWalkFrame("WalkHori", "WalkVert", 0.1)
			local speed = Settings.MoveSpeed

			if data.state == States.Moving then
				if not sprite:IsOverlayPlaying("Head") then
					sprite:PlayOverlay("Head", true)
				end
				
				-- Attack
				if entity.ProjectileCooldown > 0 then
					entity.ProjectileCooldown = entity.ProjectileCooldown - 1
				else
					if entity.Position:Distance(target.Position) <= Settings.Range and game:GetRoom():CheckLine(entity.Position, target.Position, 3, 0, false, false) then
						data.state = States.Attacking
					end
				end
				
				-- Wander off
				if data.timer > 0 then
					data.timer = data.timer - 1
				else
					if data.wanderOff == false or not data.wanderOff then
						data.wanderOff = true
					else
						data.wanderOff = false
					end
					data.timer = math.random(Settings.WanderOffTimer[1], Settings.WanderOffTimer[2])
				end
				
			elseif data.state == States.Attacking then
				if not sprite:IsOverlayPlaying("Attack") then
					sprite:PlayOverlay("Attack", true)
				end
					
				if sprite:GetOverlayFrame() == 9 then
					entity:FireProjectiles(entity.Position, (target.Position - entity.Position):Normalized() * Settings.ShotSpeed, 0, ProjectileParams())
					entity:PlaySound(SoundEffect.SOUND_SHAKEY_KID_ROAR, 1.1, 0, false, 1.2)
					entity.ProjectileCooldown = Settings.Cooldown

				elseif sprite:GetOverlayFrame() == 20 then
					data.state = States.Moving
				end
			
			-- Real one
			elseif data.state == States.Angry then
				speed = Settings.AngrySpeed
				if not sprite:IsOverlayPlaying("HeadNoMask") then
					sprite:PlayOverlay("HeadNoMask", true)
				end
			end


			-- Movement
			if entity:HasEntityFlags(EntityFlag.FLAG_FEAR) or entity:HasEntityFlags(EntityFlag.FLAG_SHRINK) then
				speed = -speed
			end

			if entity:HasEntityFlags(EntityFlag.FLAG_CONFUSION) then
				entity.Pathfinder:MoveRandomly(false)

			else
				if entity.Pathfinder:HasPathToPos(target.Position) then
					if data.wanderOff == false then
						if game:GetRoom():CheckLine(entity.Position, target.Position, 0, 0, false, false) then
							entity.Velocity = (entity.Velocity + ((target.Position - entity.Position):Normalized() * speed - entity.Velocity) * 0.25)
						
						else
							entity.Pathfinder:FindGridPath(target.Position, speed / 6, 500, false)
						end
					
					-- Make them more unpredictable
					else
						if entity.Position:Distance(data.place) < 2 or entity.Velocity:Length() < 1 or not entity.Pathfinder:HasPathToPos(data.place, false) then
							data.place = Isaac:GetRandomPosition()
						end
						entity.Pathfinder:FindGridPath(data.place, speed / 6, 500, false)
					end
				
				else
					entity.Velocity = (entity.Velocity + (Vector.Zero - entity.Velocity) * 0.25)
				end
			end
		end
		
		-- Don't animate head if not moving
		if entity.Velocity:Length() < 0.1 and data.state ~= States.Attacking then
			sprite:SetOverlayFrame(sprite:GetOverlayAnimation(), 0)
		end


		-- Death effects
		if (entity:HasMortalDamage() or entity:IsDead()) and entity.SubType ~= Settings.UnmaskID then
			-- Don't spawn gibs
			entity:Remove()

			-- Unmask real one
			if entity.SubType == Settings.RealID then
				local real = Isaac.Spawn(entity.Type, entity.Variant, Settings.UnmaskID, entity.Position, entity.Velocity, nil)
				if entity:IsChampion() then
					real:ToNPC():MakeChampion(1, entity:GetChampionColorIdx(), true)
				end
				
				SFXManager():Play(SoundEffect.SOUND_POT_BREAK, 1.2)
				SFXManager():Play(SoundEffect.SOUND_ANIMA_BREAK, 0.9)
				
				-- Chain gibs
				for i = 0, 7 do
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CHAIN_GIB, 0, entity.Position, Vector(math.random(-4,4), math.random(-4,4)), entity)
				end
			
			-- Clone fear visuals
			elseif entity.SubType == Settings.CloneID then
				local smoke = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART, 2, entity.Position, Vector.Zero, entity):GetSprite()
				smoke.Color = Color(0.6,0.25,0.6, 1, 0.25,0.1,0.25)
				SFXManager():Stop(SoundEffect.SOUND_FART)
				
				local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, 1, entity.Position, Vector.Zero, entity):GetSprite()
				poof.Scale = Vector(0.75, 0.75)
				poof.Color = Color(0.35,0.15,0.35, 1, 0.25,0.1,0.25)
				
				SFXManager():Play(SoundEffect.SOUND_BLACK_POOF, 2)
				SFXManager():Play(SoundEffect.SOUND_DEVILROOM_DEAL, 2)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.shyGalUpdate, 200)


-- Fear effect from clones
function mod:shyGalDie(target, damageAmount, damageFlags, damageSource, damageCountdownFrames)
	if target.Variant == Settings.VariantID and target.SubType == Settings.CloneID and target.HitPoints <= damageAmount and damageSource and damageSource.Entity then
		if ((damageSource.Entity.Type < 10 and damageSource.Entity.Type ~= 1) or damageSource.Entity.Type > 999) and damageSource.Entity.SpawnerEntity then
			damageSource.Entity.SpawnerEntity:AddFear(EntityRef(target), Settings.FearTime)
		else
			damageSource.Entity:AddFear(EntityRef(target), Settings.FearTime)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.shyGalDie, 200)