local mod = Furtherance
local game = Game()

local EffectVariantFocus = Isaac.GetEntityVariantByName("Spiritual Wound Target")

local FindTargets = include("lua/items/collectibles/SpiritualWound/FindTargets.lua")

local TargetType = FindTargets.TargetType

---@param player EntityPlayer
---@return EntityEffect
local function spawnFocus(player)
    local focus = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariantFocus, 0, player.Position, Vector.Zero, player):ToEffect()
    if focus == nil then
        error("Focus could not be created")
    end

    focus.Parent = player
    focus.SpawnerEntity = player
    focus.DepthOffset = -100
    focus:GetSprite():Play("Blink", true)
    focus.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS

    return focus
end

---@class FocusInputData
---@field Direction Vector
---@field IsAttacking boolean
---@field IsDropPressed boolean

---@param player EntityPlayer
---@return FocusInputData
local function getInputData(player)
    local buttonLeft = Input.GetActionValue(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
    local buttonRight = Input.GetActionValue(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
    local buttonUp = Input.GetActionValue(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
    local buttonDown = Input.GetActionValue(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
    local buttonDrop = Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex)
    local isAttacking = (buttonLeft + buttonRight + buttonUp + buttonDown) > 0

    return {
        Direction = Vector(buttonRight - buttonLeft, buttonDown - buttonUp):Normalized(),
        IsAttacking = isAttacking,
        IsDropPressed = buttonDrop
    }
end

---@param itemData SpiritualWoundItemData
---@param targetQuery TargetQuery
---@param inputs FocusInputData
local function updateFocusMovement(itemData, targetQuery, inputs)
    local player = itemData.Owner
    local focus = assert(itemData.Focus, "Focus not found")
    local snapCooldown = itemData.SnapCooldown

    if inputs.IsAttacking then
        itemData.SnapCooldown = 15
    end

    if not inputs.IsAttacking and snapCooldown <= 0 and targetQuery ~= nil and targetQuery.Type == TargetType.ENTITY then
        ---@cast targetQuery EntityTargetQuery
        local target = targetQuery.Result[1]
        if focus.Position:DistanceSquared(target.Position) > 100 then
            -- chase the target
            local intent = target.Position - focus.Position
            focus.Velocity = focus.Velocity * 0.75 + intent:Resized(player.ShotSpeed * 50) * 0.25
        else
            -- snap to the target
            focus.Velocity = target.Velocity
            focus.Position = target.Position
        end
    else
        focus.Velocity = focus.Velocity * 0.5 + inputs.Direction * (player.ShotSpeed * 10) * 0.5

        if snapCooldown > 0 then
            itemData.SnapCooldown = snapCooldown - 1
        end
    end
end

local UpdateFocus = {}
setmetatable(UpdateFocus, UpdateFocus)

---@param itemData SpiritualWoundItemData
---@param targetQuery TargetQuery
function UpdateFocus:__call(itemData, targetQuery)
    local player = itemData.Owner
    local focus = itemData.Focus

    local inputs = getInputData(player)

    if itemData.WasDropPressed ~= inputs.IsDropPressed then
        itemData.WasDropPressed = inputs.IsDropPressed
        if inputs.IsDropPressed and focus ~= nil then
            focus:Remove()
            itemData.Focus = nil
            return
        end
    end

    if itemData.WasAttacking ~= inputs.IsAttacking then
        itemData.WasAttacking = inputs.IsAttacking
        if inputs.IsAttacking and focus == nil then
            focus = spawnFocus(player)
            itemData.Focus = focus
        end
    end

    if focus ~= nil then
        updateFocusMovement(itemData, targetQuery, inputs)
    end
end

function mod:RemoveSpiritualWoundFocus()
    for p = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(p)
        local data = mod:GetData(player)
        local itemData = data.SpiritualWound ---@type SpiritualWoundItemData|nil
        if itemData == nil then return end

        local focus = itemData.Focus
        if focus == nil then return end

        focus:Remove()
        itemData.Focus = nil
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RemoveSpiritualWoundFocus)

return UpdateFocus
