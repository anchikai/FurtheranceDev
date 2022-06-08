local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:GoonInit(goon)
    if goon.SubType == 0 then
        
    elseif goon.SubType == 1 then
        
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.GoonInit, 199)

function mod:GoonCollide(goon, collider)
    if collider.Type == EntityType.ENTITY_PLAYER then
        local player = collider:ToPlayer()
        player:AddSlowing(EntityRef(player), 2, 0.5, Color(1,1,1,1,0,0,0))
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, mod.GoonCollide, 199)

local NoseColor
function mod:GoonUpdate(goon)
    local data = goon:GetData()
    local target = goon:GetPlayerTarget()
    local sprite = goon:GetSprite()
    local randNose = rng:RandomInt(4)
    if goon.SubType == 0 then
        if randNose == 0 then
            NoseColor = "HeadDownBlue"
        elseif randNose == 1 then
            NoseColor = "HeadDownOrange"
        elseif randNose == 2 then
            NoseColor = "HeadDownPurple"
        elseif randNose == 3 then
            NoseColor = "HeadDownGreen"
        end
    elseif goon.SubType == 1 then
        if randNose == 0 then
            NoseColor = "HeadDownBlue"
        elseif randNose == 1 then
            NoseColor = "HeadDownRed"
        elseif randNose == 2 then
            NoseColor = "HeadDownPink"
        elseif randNose == 3 then
            NoseColor = "HeadDownYellow"
        end
    end
    if goon.FrameCount == 1 and not sprite:IsOverlayPlaying(NoseColor) then
        sprite:PlayOverlay(NoseColor, true)
    end
    for _, entity in ipairs(Isaac.FindInRadius(goon.Position, 80, EntityPartition.PLAYER)) do
        if entity.Type == target.Type then
            data.moveTo = ((target.Position + Vector(math.random(-40,40), math.random(-40,40))) - goon.Position):GetAngleDegrees()
            goon.Velocity = (goon.Velocity + ((Vector.FromAngle(data.moveTo) * 18) - goon.Velocity) * 0.25):Resized(6)
        else
            data.moveTo = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.GoonUpdate, 199)