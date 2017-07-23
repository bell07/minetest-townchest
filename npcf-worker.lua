local dprint = townchest.dprint_off --debug
--local dprint = townchest.dprint

local function dummy_func() end
townchest.npc = {
	spawn_nearly = dummy_func,
	enable_build = dummy_func,
	disable_build = dummy_func,
}


if minetest.global_exists("schemlib_builder_npcf") then
	townchest.npc.supported = true

	-- TODO: Take over the buildings

	-- full control the NPC's
	schemlib_builder_npcf.max_pause_duration_bak = schemlib_builder_npcf.max_pause_duration
	schemlib_builder_npcf.max_pause_duration = 0
	schemlib_builder_npcf.architect_rarity_bak = schemlib_builder_npcf.architect_rarity
	schemlib_builder_npcf.architect_rarity = 0

	function townchest.npc.spawn_nearly(pos, chest, owner)
		local npcid = tostring(math.random(10000))
		npcf.index[npcid] = owner --owner
		local ref = {
			id = npcid,
			pos = {x=(pos.x+math.random(0,4)-4),y=(pos.y + 0.5),z=(pos.z+math.random(0,4)-4)},
			yaw = math.random(math.pi),
			name = "schemlib_builder_npcf:builder",
			owner = owner,
		}
		local npc = npcf:add_npc(ref)
		npcf:save(ref.id)
		if npc then
			npc.metadata.build_plan_id = minetest.pos_to_string(chest.pos)
			npc:update()
		end
	end

	function townchest.npc.enable_build(plan)
			schemlib_builder_npcf.plan_manager:add(plan)
	end

	function townchest.npc.disable_build(plan)
		schemlib_builder_npcf.plan_manager:set_finished(plan)
	end

	-- hook to trigger chest update each node placement
	function townchest.npc.plan_update_hook(plan, status)
		if plan.chest and plan.chest.info.npc_build then
			dprint("hook called:", plan.plan_id, status)
			if status == "finished" then
				plan.chest:set_finished()
			else
				plan.chest:update_info()
			end
		end
	end
end
