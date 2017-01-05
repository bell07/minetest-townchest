--[[ handle_schematics library
	extracted from https://github.com/Sokomine/handle_schematics
	see https://github.com/Sokomine/handle_schematics/issues/7
]]


local hsl = {}

-- temporary path assignment till the hsl is own mod
local modpath = minetest.get_modpath(minetest.get_current_modname())
modpath = modpath..'/libs/hsl/'

-- deserialize worldedit savefiles
hsl.worldedit_file = dofile(modpath.."worldedit_file.lua")

-- reads and analyzes .mts files (minetest schematics)
hsl.analyze_mts = dofile(modpath.."/analyze_mts_file.lua")

-- reads and analyzes worldedit files
hsl.analyze_we = dofile(modpath.."/analyze_we_file.lua")

-- reads and analyzes Minecraft schematic files
hsl.translate_mc = dofile(modpath.."/translate_nodenames_for_mc_schematic.lua")
hsl.analyze_mc = dofile(modpath.."/analyze_mc_schematic_file.lua")

-- handles rotation and mirroring
hsl.rotate = dofile(modpath.."/rotate.lua")

-- count nodes, take param2 into account for rotation etc.
hsl.misc = dofile(modpath.."/handle_schematics_misc.lua")

-- store and restore metadata
hsl.save_restore = dofile(modpath.."/save_restore.lua");
hsl.meta = dofile(modpath.."/handle_schematics_meta.lua");


return hsl
