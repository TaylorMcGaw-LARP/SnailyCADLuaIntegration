Config = {
    plugins = {}
}
Plugins = {}

Config.RegisterPluginConfig = function(pluginName, configs)
    Config.plugins[pluginName] = {}
    for k, v in pairs(configs) do
        Config.plugins[pluginName][k] = v
    end 
    table.insert(Plugins, pluginName)
end
Config.GetPluginConfig = function(pluginName) 
    if Config.plugins[pluginName] ~= nil then
        if Config.plugins[pluginName].enabled == nil then
            Config.plugins[pluginName].enabled = true
        end
        return Config.plugins[pluginName]
    else
        if pluginName == "yourpluginname" then
            return { enabled = false }
        end
        return { enabled = false }
    end
end

TriggerServerEvent("snailyCAD::core:sendClientConfig")

RegisterNetEvent("snailyCAD::core:recvClientConfig")
AddEventHandler("snailyCAD::core:recvClientConfig", function(config)
    for k, v in pairs(config) do
        Config[k] = v
    end
    Config.inited = true
end)

if Config.devHiddenSwitch then
    Citizen.CreateThread(function()
        SetDiscordAppId(747991263172755528)
        SetDiscordRichPresenceAsset("cad_logo")
        SetDiscordRichPresenceAssetSmall("snaily_logo")
        while true do
            SetRichPresence("Developing snailyCAD!")
            Wait(5000)
            SetRichPresence("snailycad.com")
            Wait(5000)
        end
    end)
end

local inited = false
AddEventHandler("playerSpawned", function()
    TriggerServerEvent("snailyCAD::core:PlayerReady")
    inited = true
end)