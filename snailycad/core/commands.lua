--[[
    snailyCAD FiveM Integration

    Commands Module

    Provides /snaily command for console control
]]

--[[ /snaily
    debugmode - old caddebug toggle
    info - dump version info, configuration
    support - dump useful data for support staff 
    verify - run hash checks to confirm all files are untampered
    plugin <name> - show info about a plugin (config)
    update - attempt to auto-update
]]

function dumpInfo()
    local version = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
    local pluginList, loadedPlugins, disabledPlugins = GetPluginLists()
    local pluginVersions = {}
    local cadVariables = { ["socket_port"] = GetConvar("socket_port", "NONE"), ["snailyListenPort"] = GetConvar("snailyListenPort", "NONE")}
    local variableList = ""
    for k, v in pairs(cadVariables) do
        variableList = ("%s%s = %s\n"):format(variableList, k, v)
    end
    for k, v in pairs(pluginList) do
        if Config.plugins[v] then
            table.insert(pluginVersions, ("%s [%s/%s]"):format(v, Config.plugins[v].version, Config.plugins[v].latestVersion))
        end
    end
    return ([[
snailyCAD
Version: %s
Available Plugins
%s
Loaded Plugins
%s
Disabled Plugins
%s
Relevant Variables
%s
    ]]):format(version, table.concat(pluginVersions, ", "), table.concat(loadedPlugins, ", "), table.concat(disabledPlugins, ", "), variableList)
end

function dumpPlugin(name)
    local pluginDetail = {}
    if not Config.plugins[name] then
        print("Bad plugin: "..name)
        return nil
    end
    for k, v in pairs(Config.plugins[name]) do
        table.insert(pluginDetail, ("%s = %s"):format(k, v))
    end
    return ([[
Plugin: %s
Version: %s
Configuration:
    %s
    ]]):format(name, Config.plugins[name].version, table.concat(pluginDetail, "\n     "))
end

local function sendSupportLogs(key)
    infoLog("Please wait, gathering required data...")
    local cadOutput = {}
    cadOutput.key = tonumber(key)
    if cadOutput.key == nil then
        errorLog("Invalid support key.")
        return
    end
    local plugins = {}
    for name, config in pairs(Config.plugins) do
        pluginData = {}
        pluginData.name = name
        pluginData.version = config.version
        pluginData.config = config
        table.insert(plugins, pluginData)
    end
    cadOutput.plugins = plugins
    cadOutput.logs = ([[
snailyCAD Support Output
---------------------------------------
Configuration Information
---
%s

---------------------------------------
Console Buffer
------
%s
    ]]):format(dumpInfo(), GetConsoleBuffer())
    Config.debugMode = false
    
end
RegisterCommand("snaily", function(source, args, rawCommand)
    if source ~= 0 then
        print("Console only command")
        return
    end
    if not args[1] then
        print("Missing command. Try \"snaily help\" for help.")
        return
    end
    if args[1] == "help" then
        print([[
snailyCAD Help
    debugmode - Toggles debugging mode
    info - dump version info, configuration
    support - dump useful data for support staff 
    plugin <name> - show info about a plugin (config)
    update - Run core updater
    pluginupdate - Run plugin updater
]])
    elseif args[1] == "debugmode" then
        Config.debugMode = not Config.debugMode
        infoLog(("Debug mode toggled to %s"):format(Config.debugMode))
    elseif args[1] == "info" then
        print(dumpInfo())
    elseif args[1] == "support" and args[2] ~= nil then
        sendSupportLogs(args[2])
    elseif args[1] == "plugin" and args[2] then
        if Config.plugins[args[2]] then
            print(dumpPlugin(args[2]))
        else
            errorLog("Invalid plugin")
        end
    elseif args[1] == "update" then --update - attempt to auto-update
        infoLog("Checking for core update...")
        RunAutoUpdater(true)
    elseif args[1] == "dumpconsole" then
        local savePath = GetResourcePath(GetCurrentResourceName()).."/buffer.log"
        local f = assert(io.open(savePath, 'wb'))
        f:write(GetConsoleBuffer())
        f:close()
        infoLog("Wrote buffer to "..savePath)
    elseif args[1] == "pluginupdate" then
        infoLog("Scanning for plugin updates...")
        for k, v in pairs(Config.plugins) do
            CheckForPluginUpdate(k)
        end
    else
        print("Missing command. Try \"snaily help\" for help.")
    end
end, true)

function GetPluginLists()
    local pluginList = {}
    local loadedPlugins = {}
    local disabledPlugins = {}
    for name, v in pairs(Config.plugins) do
        table.insert(pluginList, name)
        if v.enabled then
            table.insert(loadedPlugins, name)
        else
            table.insert(disabledPlugins, name)
        end
    end
    return pluginList, loadedPlugins, disabledPlugins
end

-- Support Push Event

AddEventHandler("snailyCAD::pushevents:SendSupportLogs", function(key)
    infoLog("Support has requested logs to be uploaded. Collecting now...")
    sendSupportLogs(key)
end)