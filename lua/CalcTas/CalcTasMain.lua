local config = require ("config")
local clicker = require("clicker")

----------------------------------
-- Main
----------------------------------
clicker:init(config.filePath)

local function main()
    clicker:click()
end

emu.registerbefore(main)