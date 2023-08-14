Plugins = {}

CreateThread(function()
    Wait(1)
    infoLog(("Loaded community ID API URL: %s"):format(Config.apiUrl))
   
    if Config.primaryIdentifier == "steam" and GetConvar("steam_webapiKey", "none") == "none" then
        errorLog("You have set snailyCAD to Steam mode, but have not configured a Steam Web API key. Please see FXServer documentation. snailyCAD will not function in Steam mode without this set.")
        Config.critError = true
    end
end)

-- Toggles API sender.
RegisterServerEvent("cadToggleApi")
AddEventHandler("cadToggleApi", function()
    Config.apiSendEnabled = not Config.apiSendEnabled
end)

--[[
    snaily CAD API Handler - Core Wrapper
]]



function performApiRequest(payload, endpoint, type, cb)
    -- apply required headers 

    local url = ""
  
        apiUrl = Config.apiUrl
        url = apiUrl..'/'..tostring(endpoint)
  
    if Config.critError then
        return
    elseif not Config.apiSendEnabled then
        warnLog("API sending is disabled, ignoring request.")
        return
    end

        PerformHttpRequestS(url, function(statusCode, res, headers)
            debugLog(("type %s called with post data %s to url %s"):format(type, json.encode(payload), url))
            if statusCode == 200 and res ~= nil then
                debugLog("result: "..tostring(res))
                cb(res, true)
            elseif statusCode == 400 then
                warnLog("Bad request was sent to the API. Enable debug mode and retry your request. Response: "..tostring(res))
            elseif statusCode == 404 then -- handle 404 requests, like from CHECK_APIID
                debugLog("404 response found")
                cb(res, false)
            else
                errorLog(("CAD API ERROR (from %s): %s %s"):format(url, statusCode, res))
            end
          
        end, type, json.encode(payload), {["Content-Type"]="application/json",["snaily-cad-api-token"]=Config.apiKey})
  
    
end

if Config.devHiddenSwitch then
    RegisterCommand("cc", function()
        TriggerClientEvent("chat:clear", -1)
    end)
end

-- Missing identifier detection
RegisterNetEvent("snailyCAD::core:PlayerReady")
AddEventHandler("snailyCAD::core:PlayerReady", function()
    local ids = GetIdentifiers(source)
    if ids[Config.primaryIdentifier] == nil then
        warnLog(("Player %s connected, but did not have an %s ID."):format(source, Config.primaryIdentifier))
        
    end
end)