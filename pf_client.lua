--[[
I DID NOT MAKE THIS
 credits: https://github.com/yukihooked/phantom_forces/blob/main/game_client.lua
]]
local game_client = {}

do -- Client Collector
   local garbage = getgc(true)
   local loaded_modules = getloadedmodules()

   for i = 1, #garbage do
       local v = garbage[i]
       if typeof(v) == "table" then
           if rawget(v, "send") and rawget(v, "fetch") then -- Networking Module
               game_client.network = v
           elseif rawget(v, 'goingLoud') and rawget(v, 'isInSight') then -- Useful for Radar Hack or Auto Spot
               game_client.spotting_interface = v
           elseif rawget(v, 'setMinimapStyle') and rawget(v, 'setRelHeight') then -- Useful for Radar Hack
               game_client.radar_interface = v
           elseif rawget(v, "getCharacterModel") and rawget(v, 'popCharacterModel') then -- Used for Displaying other Characters
               game_client.third_person_object = v
           elseif rawget(v, "getCharacterObject") then -- Used for sending LocalPlayer Character Data to Server
               game_client.character_interface = v
           elseif rawget(v, "isSprinting") and rawget(v, "getArmModels") then -- Used for sending LocalPlayer Character Data to Server
               game_client.character_object = v
           elseif rawget(v, "updateReplication") and rawget(v, "getThirdPersonObject") then -- This represents a "Player" separate from their character
               game_client.replication_object = v
           elseif rawget(v, "setHighMs") and rawget(v, "setLowMs") then -- Same as above
               game_client.replication_interface = v
           elseif rawget(v, 'setSway') and rawget(v, "_applyLookDelta") then -- You can modify camera values with this
               game_client.main_camera_object = v
           elseif rawget(v, 'getActiveCamera') and rawget(v, "getCameraType") then -- You can modify camera values with this
               game_client.camera_interface = v
           elseif rawget(v, 'getFirerate') and rawget(v, "getFiremode") then -- Weapon Stat Hooks
               game_client.firearm_object = v
           elseif rawget(v, 'canMelee') and rawget(v, "_processMeleeStateChange") then -- Melee Stat Hooks
               game_client.melee_object = v
           elseif rawget(v, 'canCancelThrow') and rawget(v, "canThrow") then -- Grenade Stat Hooks
               game_client.grenade_object = v
           elseif rawget(v, "vote") then -- Useful for Auto Vote
               game_client.votekick_interface = v
           elseif rawget(v, "getActiveWeapon") then -- Useful for getting current weapon
               game_client.weapon_controller_object = v
           elseif rawget(v, "getController") then -- Useful for getting your current weapon
               game_client.weapon_controller_interface = v
           elseif rawget(v, "updateVersion") and rawget(v, "inMenu") then -- Useful for chat spam :)
               game_client.chat_interface = v
           elseif rawget(v, "trajectory") and rawget(v, "timehit") then -- Useful for ragebot (Note: This table is frozen, use setreadonly)
               game_client.physics = v
           elseif rawget(v, "slerp") and rawget(v, "toanglesyx") then -- Useful for angles (Note: This table is frozen, use setreadonly)
               game_client.vector = v
           end
       end
   end

   for i = 1, #loaded_modules do
       local v = loaded_modules[i]
       if v.Name == "PlayerSettingsInterface" then -- I use this for dynamic fov
           game_client.player_settings = require(v)
       elseif v.Name == "PublicSettings" then -- Get world data from here
           game_client.public_settings = require(v)
       elseif v.Name == "particle" then -- Useful for silent aim
           game_client.particle = require(v)
       elseif v.Name == "BulletCheck" then -- Wall Penetration for ragebot
           game_client.bullet_check = require(v)
       end
   end
end

function game_client:get_character(plr)
    local player  = game_client.replication_interface.getEntry(plr) 
    
    if player then 
        local tp_object = entry._thirdPersonObject 
        if tp_object then 
            return tp_object 
        end
    end
end

function game_client:get_health(plr)
    local player = game_client.replication_interface.getEntry(player)
    if player then 
        return player._healthstate.health0, player._healthstate.maxhealth 
    end
end

function game_client:check_status(plr)
    local player = game_client.replication_interface.getEntry(plr)
    
    if player then 
        return player._alive 
    end
end

function game_client:get_tool(plr)
    local player = game_client.replication_interface.getEntry(plr)
    if player then 
        local tp_object = player._thirdPersonObject 
        if tp_object then 
            return tp_object._weaponname or ''
        end
    end
end
--[[
   All PF Network Commands (No Arguments)
       aim
       breakwindow
       bullethit
       capturedogtag
       captureflag
       changeAttachment
       changeClass
       changeModeVote
       changePlayerSetting
       changeTagColor
       changeWeapon
       chatted
       debug
       equip
       falldamage
       forcereset
       getammo
       knifehit
       logmessage
       modcmd
       newbullets
       newgrenade
       perfdump
       ping
       purchaseCaseAssign
       purchaseCaseCredit
       purchaseCaseKeyCredit
       purchaseCredits
       purchaseTag
       registerfunc
       reload
       repupdate
       requestMultiRoll
       requestRoll
       requestTradeRoll
       resetAttachments
       sellSkin
       spawn
       spotplayer
       sprint
       squadspawnupdate
       stab
       stance
       suppressionassist
       swapweapon
       teleportwithdata
       togglesquadspawn
       updatesight
       votefromUI
]]
