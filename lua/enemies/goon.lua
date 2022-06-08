local mod = Furtherance
local game = Game()
local rng = RNG()

local Settings = {
	MoveSpeed = 4,
	Range = 100,
	SlowAmount  = 0.1
}

local States = {
	Chilling = 0,
	Chasing = 1,
	Attached = 2
}



function mod:GoonInit(entity)
	local data = entity:GetData()
	data.state = States.Chilling

	data.NoseColor = "Blue"
	local randNose = rng:RandomInt(4)

	-- Devil Goon colors
	if entity.SubType == 1 then
		if randNose == 1 then
			data.NoseColor = "Red"
		elseif randNose == 2 then
			data.NoseColor = "Pink"
		elseif randNose == 3 then
			data.NoseColor = "Yellow"
		end
	-- Regular Goon colors
	else
		if randNose == 1 then
			data.NoseColor = "Orange"
		elseif randNose == 2 then
			data.NoseColor = "Purple"
		elseif randNose == 3 then
			data.NoseColor = "Green"
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.GoonInit, 199)

function mod:GoonUpdate(entity)
	local data = entity:GetData()
	local target = entity:GetPlayerTarget()
	local sprite = entity:GetSprite()


	if data.state == States.Chilling then
		entity.Velocity = Vector.Zero
		-- Start chasing
		if entity.Position:Distance(target.Position) <= Settings.Range then
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

	elseif data.state == States.Attached then
		entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
		entity.Position = entity.Parent.Position - Vector.FromAngle(entity.InitSeed) * 10
		entity.Velocity = entity.Parent.Velocity

		if 1 - (#entity.Parent:GetData().goonies * Settings.SlowAmount) > 0.1 then
			entity.Parent:AddSlowing(EntityRef(entity), 1, 1 - (#entity.Parent:GetData().goonies * Settings.SlowAmount), Color(1,1,1,1,0,0,0))
		else
			entity.Parent:AddSlowing(EntityRef(entity), 1, 0.1, Color(1,1,1,1,0,0,0))
		end
	end


	-- Animation
	entity:AnimWalkFrame("WalkRight", "WalkDown", 0.1) -- you don't need to have seperate anims for all 4 directions if their only difference is mirroring

	-- Get head direction
	local angleDegrees = entity.Velocity:GetAngleDegrees()
	if angleDegrees >= 45 and angleDegrees <= 135 then
		data.facing = "Down"
	elseif angleDegrees < -45 and angleDegrees > -135 then
		data.facing = "Up"
	else
		data.facing = "Right"
	end

	-- Head animation
	if entity.Velocity:Length() > 0.1 then
		if not sprite:IsOverlayPlaying("Head" .. data.facing  .. data.NoseColor) then
			sprite:PlayOverlay("Head" .. data.facing  .. data.NoseColor, true)
		end
	else
		sprite:SetOverlayFrame("HeadDown" .. data.NoseColor, 0)
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
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.GoonUpdate, 199)

-- Attach to player
function mod:GoonCollide(goon, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
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
				goon:GetData().state = States.Attached
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, mod.GoonCollide, 199)

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