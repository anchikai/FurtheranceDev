local mod = Furtherance
local game = Game()

local WhirlpoolVariant = Isaac.GetEntityVariantByName("Miriam Whirlpool")

local APPEAR_ANIM_LENGTH = 16
local DEATH_ANIM_LENGTH = 22

---@param effect EntityEffect
function mod:WhirlpoolInit(effect)
    effect.LifeSpan = 60

    local sprite = effect:GetSprite()
    sprite:Play("Appear", true)

    mod:DelayFunction(function()
        if not effect:IsDead() then
            sprite:Play("Idle", true)
        end
    end, APPEAR_ANIM_LENGTH, nil, true)
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, mod.WhirlpoolInit, WhirlpoolVariant)

---@param effect EntityEffect
function mod:WhirlpoolUpdate(effect)
    effect.LifeSpan = effect.LifeSpan - 1

    -- detecting death by LifeSpan
    if effect.LifeSpan <= 0 and not effect:IsDead() then
        effect:Die()
        local sprite = effect:GetSprite()
        sprite:Play("Death", true)
        mod:DelayFunction(function()
            if effect:IsDead() then
                effect:Remove()
            end
        end, DEATH_ANIM_LENGTH, nil, true)
    end

    if effect.CollisionDamage > 0 and effect.FrameCount % 3 == 0 then
        for _, enemy in ipairs(Isaac.FindInRadius(effect.Position, 40, EntityPartition.ENEMY)) do
            if enemy:IsActiveEnemy(false) and enemy:IsVulnerableEnemy() then
                enemy:TakeDamage(effect.CollisionDamage, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(effect), 0)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.WhirlpoolUpdate, WhirlpoolVariant)

---@param entity Entity
function mod:WhirlpoolDied(entity)
    if entity.Variant ~= WhirlpoolVariant then return end

    local sprite = entity:GetSprite()

    if sprite:GetAnimation() == "Death" then return end
    sprite:Play("Death", true)
    mod:DelayFunction(function()
        if entity:IsDead() then
            entity:Remove()
        end
    end, DEATH_ANIM_LENGTH, nil, true)
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.WhirlpoolDied, EntityType.ENTITY_EFFECT)