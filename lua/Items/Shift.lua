local mod = further
local game = Game()

function mod:UseShift(_, _, player)
	player:AnimateCollectible(CollectibleType.COLLECTIBLE_SHIFT_KEY, "UseItem", "PlayerPickup")
	game:ShowHallucination(30, BackdropType.NUM_BACKDROPS)
	local plty = player:GetPlayerType()
	-- Isaac
	if plty == PlayerType.PLAYER_ISAAC then
		player:ChangePlayerType(PlayerType.PLAYER_ISAAC_B)
	elseif plty == PlayerType.PLAYER_ISAAC_B then
		player:ChangePlayerType(PlayerType.PLAYER_ISAAC)
	-- Maggy
	elseif plty == PlayerType.PLAYER_MAGDALENA then
		player:ChangePlayerType(PlayerType.PLAYER_MAGDALENA_B)
	elseif plty == PlayerType.PLAYER_MAGDALENA_B then
		player:ChangePlayerType(PlayerType.PLAYER_MAGDALENA)
	-- Cain
	elseif plty == PlayerType.PLAYER_CAIN then
		player:ChangePlayerType(PlayerType.PLAYER_CAIN_B)
	elseif plty == PlayerType.PLAYER_CAIN_B then
		player:ChangePlayerType(PlayerType.PLAYER_CAIN)
	-- Judas
	elseif plty == PlayerType.PLAYER_JUDAS or plty == PlayerType.PLAYER_BLACKJUDAS then
		player:ChangePlayerType(PlayerType.PLAYER_JUDAS_B)
	elseif plty == PlayerType.PLAYER_JUDAS_B then
		player:ChangePlayerType(PlayerType.PLAYER_JUDAS)
	-- Blue Baby
	elseif plty == PlayerType.PLAYER_XXX then
		player:ChangePlayerType(PlayerType.PLAYER_XXX_B)
	elseif plty == PlayerType.PLAYER_XXX_B then
		player:ChangePlayerType(PlayerType.PLAYER_XXX)
	-- Eve
	elseif plty == PlayerType.PLAYER_EVE then
		player:ChangePlayerType(PlayerType.PLAYER_EVE_B)
	elseif plty == PlayerType.PLAYER_EVE_B then
		player:ChangePlayerType(PlayerType.PLAYER_EVE)
	-- Samson
	elseif plty == PlayerType.PLAYER_SAMSON then
		player:ChangePlayerType(PlayerType.PLAYER_SAMSON_B)
	elseif plty == PlayerType.PLAYER_SAMSON_B then
		player:ChangePlayerType(PlayerType.PLAYER_SAMSON)
	-- Azazel
	elseif plty == PlayerType.PLAYER_AZAZEL then
		player:ChangePlayerType(PlayerType.PLAYER_AZAZEL_B)
	elseif plty == PlayerType.PLAYER_AZAZEL_B then
		player:ChangePlayerType(PlayerType.PLAYER_AZAZEL)
	-- Lazarus
	elseif plty == PlayerType.PLAYER_LAZARUS or plty == PlayerType.PLAYER_LAZARUS2 then
		player:ChangePlayerType(PlayerType.PLAYER_LAZARUS_B)
	elseif plty == PlayerType.PLAYER_LAZARUS_B or plty == PlayerType.PLAYER_LAZARUS2_B then
		player:ChangePlayerType(PlayerType.PLAYER_LAZARUS)
	-- Eden
	elseif plty == PlayerType.PLAYER_EDEN then
		player:ChangePlayerType(PlayerType.PLAYER_EDEN_B)
	elseif plty == PlayerType.PLAYER_EDEN_B then
		player:ChangePlayerType(PlayerType.PLAYER_EDEN)
	-- Lost
	elseif plty == PlayerType.PLAYER_THELOST then
		player:ChangePlayerType(PlayerType.PLAYER_THELOST_B)
	elseif plty == PlayerType.PLAYER_THELOST_B then
		player:ChangePlayerType(PlayerType.PLAYER_THELOST)
	-- Lilith
	elseif plty == PlayerType.PLAYER_LILITH then
		player:ChangePlayerType(PlayerType.PLAYER_LILITH_B)
	elseif plty == PlayerType.PLAYER_LILITH_B then
		player:ChangePlayerType(PlayerType.PLAYER_LILITH)
	-- Keeper
	elseif plty == PlayerType.PLAYER_KEEPER then
		player:ChangePlayerType(PlayerType.PLAYER_KEEPER_B)
	elseif plty == PlayerType.PLAYER_KEEPER_B then
		player:ChangePlayerType(PlayerType.PLAYER_KEEPER)
	-- Apollyon
	elseif plty == PlayerType.PLAYER_APOLLYON then
		player:ChangePlayerType(PlayerType.PLAYER_APOLLYON_B)
	elseif plty == PlayerType.PLAYER_APOLLYON_B then
		player:ChangePlayerType(PlayerType.PLAYER_APOLLYON)
	-- Forgor
	elseif plty == PlayerType.PLAYER_THEFORGOTTEN or plty == PlayerType.PLAYER_THESOUL then
		player:ChangePlayerType(PlayerType.PLAYER_THEFORGOTTEN_B)
	elseif plty == PlayerType.PLAYER_THEFORGOTTEN_B or plty == PlayerType.PLAYER_THESOULB then
		player:ChangePlayerType(PlayerType.PLAYER_THEFORGOTTEN)
	-- Bethany
	elseif plty == PlayerType.PLAYER_BETHANY then
		player:ChangePlayerType(PlayerType.PLAYER_BETHANY_B)
	elseif plty == PlayerType.PLAYER_BETHANY_B then
		player:ChangePlayerType(PlayerType.PLAYER_BETHANY)
	-- Jacob
	elseif plty == PlayerType.PLAYER_JACOB then
		player:ChangePlayerType(PlayerType.PLAYER_JACOB_B)
	elseif plty == PlayerType.PLAYER_JACOB_B then
		player:ChangePlayerType(PlayerType.PLAYER_JACOB)
	-- Esau
	elseif plty == PlayerType.PLAYER_ESAU then
		print("This is currently broken, give shift to Jacob instead!")
	-- Leah
	elseif plty == normalLeah then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("LeahB", true))
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_SHATTERED_HEART, SLOT_POCKET, false)
	elseif plty == taintedLeah then
		player:ChangePlayerType(Isaac.GetPlayerTypeByName("Leah", false))
	end
	if SaltLady or Compliance then
		if plty == Isaac.GetPlayerTypeByName("Edith", false) then
			player:ChangePlayerType(Isaac.GetPlayerTypeByName("Edith", true))
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_THE_CHISEL, SLOT_POCKET, false)
		elseif plty == Isaac.GetPlayerTypeByName("Edith", true) then
			player:ChangePlayerType(Isaac.GetPlayerTypeByName("Edith", false))
		end
	end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseShift, CollectibleType.COLLECTIBLE_SHIFT_KEY)