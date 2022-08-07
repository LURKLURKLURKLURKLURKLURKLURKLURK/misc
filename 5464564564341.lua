local replicated = game.GetService(game,'ReplicatedStorage')
local real_gun_config = replicated.Modules.Config;
local module_spoofer; module_spoofer = hookfunction(getrenv().require, function(self, ...)
    local args = {...}
    if self == real_gun_config then
        return getgenv().pie_solutions_env.spoofed_config
    end
    return module_spoofer(self, unpack(args))
end)
