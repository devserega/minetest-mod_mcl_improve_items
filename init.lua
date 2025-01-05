local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local drop_items_chest = mcl_util.drop_items_from_meta_container("main")

--[[
minetest.override_item("mcl_chests:chest_small", {
	-- Переопределяем стандартную логику разрушения сундука
	on_dig = function(pos, node, digger)
		minetest.log("action", "serega2")
		local player_name = digger:get_player_name()

		-- Проверка на защиту зоны, например, через areas или minetest.is_protected
		if minetest.is_protected(pos, player_name) then
			-- Если зона защищена, не разрешаем уничтожение сундука
			minetest.chat_send_player(player_name, "This area is protected, you cannot destroy this chest.")
			return
		end

		-- Если зона не защищена, вызываем стандартную логику разрушения
		return minetest.node_dig(pos, node, digger)
	end,
})
]]

local function protection_check_put_take(pos, listname, index, stack, player)
	-- Возвращаем количество предметов, которые игрок может взять или положить,
	-- не проверяя защиту зоны
	return stack:get_count()  -- Разрешаем взаимодействие без проверок защиты
end


-- Переопределяем ноду сундука
minetest.override_item("mcl_chests:chest_small", {
	-- Разрешаем взаимодействие с инвентарём сундука
	allow_metadata_inventory_take = protection_check_put_take,
	allow_metadata_inventory_put = protection_check_put_take,
})

minetest.override_item("mcl_furnaces:furnace", {
	-- Разрешаем взаимодействие с инвентарём сундука
	allow_metadata_inventory_take = protection_check_put_take,
	allow_metadata_inventory_put = protection_check_put_take,
})

minetest.override_item("mcl_barrels:barrel_open", {
	-- Разрешаем взаимодействие с инвентарём сундука
	allow_metadata_inventory_take = protection_check_put_take,
	allow_metadata_inventory_put = protection_check_put_take,
})
