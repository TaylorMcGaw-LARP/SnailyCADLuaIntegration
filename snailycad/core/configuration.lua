Config = {
    apiKey = nil,
    apiUrl = nil,
    postTime = nil,
    primaryIdentifier = nil,
    apiSendEnabled = nil,
    debugMode = nil,
    updateBranch = nil,
    plugins = {}
}

Config.RegisterPluginConfig = function(pluginName, configs)
    Config.plugins[pluginName] = {}
    for k, v in pairs(configs) do
        Config.plugins[pluginName][k] = v
        --debugLog(("plugin %s set %s = %s"):format(pluginName, k, v))
    end 
    table.insert(Plugins, pluginName)
end

Config.GetPluginConfig = function(pluginName) 
    if Config.plugins[pluginName] ~= nil then
        if Config.critError then
            Config.plugins[pluginName].enabled = false
        elseif Config.plugins[pluginName].enabled == nil then
            Config.plugins[pluginName].enabled = true
        end
        return Config.plugins[pluginName]
    else
        if pluginName == "yourpluginname" then
            return { enabled = false }
        end
        if not LoadResourceFile(GetCurrentResourceName(), ("plugins/%s/%s/config_%s.lua"):format(pluginName, pluginName, pluginName)) and not LoadResourceFile(GetCurrentResourceName(), ("plugins/%s/config_%s.lua"):format(pluginName, pluginName))  then
            warnLog(("Plugin %s is missing critical configuration. Please check our plugin install guide at https://cadinfo.liveactionrp.com/integration-plugins/integration-plugins/plugin-installation for steps to properly install."):format(pluginName))
        end
        Config.plugins[pluginName] = { enabled = false }
        return { enabled = false }
    end
end

local conf = LoadResourceFile(GetCurrentResourceName(), "config.json")
if conf == nil then
    errorLog("Failed to load core configuration. Ensure config.json is present.")
    Config.critError = true
    Config.apiSendEnabled = false
    return
end
local parsedConfig = json.decode(conf)
if parsedConfig == nil then
    errorLog("Failed to parse your config file. Make sure it is valid JSON.")
    Config.critError = true
    Config.apiSendEnabled = false
    return
end
for k, v in pairs(json.decode(conf)) do
    Config[k] = v
end

if Config.updateBranch == nil then
    Config.updateBranch = "master"
end

RegisterServerEvent("snailyCAD::core::getConfig")
AddEventHandler("snailyCAD::core::getConfig", function()
    local config = json.encode({
        apiUrl = Config.apiUrl,
        apiKey = Config.apiKey,
        postTime = Config.postTime,
        apiSendEnabled = Config.apiSendEnabled
    })
    TriggerEvent("snailyCAD::core:configData", config)
end)

RegisterNetEvent("snailyCAD::core:sendClientConfig")
AddEventHandler("snailyCAD::core:sendClientConfig", function()
    local config = {
        postTime = Config.postTime,
        primaryIdentifier = Config.primaryIdentifier,
        apiSendEnabled = Config.apiSendEnabled,
        debugMode = Config.debugMode
    }
    TriggerClientEvent("snailyCAD::core:recvClientConfig", source, config)
end)
