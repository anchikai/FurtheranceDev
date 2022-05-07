local mod = Furtherance
local game = Game()

local DreidelStatObjs = {
	{ Name = "Damage", Flag = CacheFlag.CACHE_DAMAGE },
	{ Name = "TearRange", Flag = CacheFlag.CACHE_RANGE },
	{ Name = "ShotSpeed", Flag = CacheFlag.CACHE_SHOTSPEED },
	{ Name = "MoveSpeed", Flag = CacheFlag.CACHE_SPEED },
	{ Name = "Luck", Flag = CacheFlag.CACHE_LUCK }
}

local ALL_DREIDEL_FLAGS = 0
for _, obj in ipairs(DreidelStatObjs) do
	ALL_DREIDEL_FLAGS = ALL_DREIDEL_FLAGS | obj.Flag
end


function mod:UseDreidel(_, _, player)
    local data = mod:GetData(player)
    data.DreidelWasUsed = true
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseDreidel, CollectibleType.COLLECTIBLE_THE_DREIDEL)


function mod:DreidelQual(player)
    local data = mod:GetData(player)
	
	-- Spawn item
    if data.DreidelWasUsed == true then
        data.DreidelWasUsed = false
        Item = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
        data.DreidelRerolling = true
    end


    if data.DreidelRerolling == true then
		local itemConfig = Isaac.GetItemConfig()
		
		-- No quality 0 items
        if itemConfig:GetCollectible(Item.SubType).Quality == 0 then
            Item:ToPickup():Morph(Item.Type, Item.Variant, 0, false, true, false)
		
		-- Lower stats
        else
			local stats = data.DreidelStats
			if stats == nil then
				stats = {}
				for i = 1, #DreidelStatObjs do
					stats[i] = 0
				end
				data.DreidelStats = stats
			end
			
			-- TODO: MAKE IT SO IT CANT LOWER THE SAME STAT MULTIPLE TIMES FROM ONE ITEM
			for j = 1, itemConfig:GetCollectible(Item.SubType).Quality do
				local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_THE_DREIDEL)
				local statChoice = rng:RandomInt(#DreidelStatObjs) + 1
				stats[statChoice] = stats[statChoice] + 0.2
			end
			
			player:AddCacheFlags(ALL_DREIDEL_FLAGS)
			player:EvaluateItems()
			data.DreidelRerolling = false
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.DreidelQual)


function mod:DreidelStats(player, flag)
	local data = mod:GetData(player)
	if data.DreidelStats == nil then return end

	for i, amount in ipairs(data.DreidelStats) do
		local stat = DreidelStatObjs[i]

		if stat.Flag == flag then
			if flag == CacheFlag.CACHE_RANGE then
				player[stat.Name] = player[stat.Name] - (amount * 50)
			elseif flag == CacheFlag.CACHE_SPEED then
				player[stat.Name] = player[stat.Name] - (amount / 2)
			else
				player[stat.Name] = player[stat.Name] - amount
			end
			
			break
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.DreidelStats)