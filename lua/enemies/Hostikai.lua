local mod = Furtherance
local rng = RNG()
local game = Game()

function mod:Hostikai(entity)
	if entity.SubType == 3070 then
		if entity.Variant == 0 then
			local sprite = entity:GetSprite()
			local data = entity:GetData()
			
			-- Start flying if player can't get to it
			if not entity.Pathfinder:HasPathToPos(entity:GetPlayerTarget().Position, false) then
				entity.State = NpcState.STATE_ATTACK
			end

			-- Start flying
			if sprite:IsEventTriggered("FlyStart") then
				data.moveTo = ((entity:GetPlayerTarget().Position + Vector(math.random(-40,40), math.random(-40,40))) - entity.Position):GetAngleDegrees()
				entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
			-- Land
			elseif sprite:IsEventTriggered("FlyStop") then
				data.moveTo = nil
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
				-- Stop them from teleporting if they land on grid entities
				if game:GetRoom():GetGridCollisionAtPos(entity.Position) == 0 then
					entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
				end
			end

			-- Move if in the air
			if data.moveTo then
				entity.Velocity = (entity.Velocity + ((Vector.FromAngle(data.moveTo) * 18) - entity.Velocity) * 0.25)
			end
		
		-- Stop them from behaving like Red Hosts
		elseif entity.Variant == 1 then
			entity.Variant = 0
		end
	end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.Hostikai, EntityType.ENTITY_HOST)