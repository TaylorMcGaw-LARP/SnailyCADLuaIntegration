local pendingRestart = false

local function doUnzip(path)
    local unzipPath = GetResourcePath(GetCurrentResourceName()).."/../../"
    exports[GetCurrentResourceName()]:UnzipFile(path, unzipPath)
    infoLog("Unzipped to "..unzipPath)
    if not Config.allowUpdateWithPlayers and GetNumPlayerIndices() > 0 then
        pendingRestart = true
        infoLog("Delaying auto-update until server is empty.")
        return
    end
    warnLog("Auto-restarting...")
    local f = assert(io.open(GetResourcePath("snaily_updatehelper").."/run.lock", "w+"))
    f:write("core")
    f:close()
    Wait(5000)
    ExecuteCommand("ensure snaily_updatehelper")
end

local function doUpdate(latest)
    -- best way to do this...
    local releaseUrl = ("https://github.com/TaylorMcGaw-LARP/SnailyCADLuaIntegration/releases/download/v%s/snailycad-%s.zip"):format(latest, latest)
    print(releaseUrl)
    PerformHttpRequest(releaseUrl, function(code, data, headers)
        if code == 200 then
            local savePath = GetResourcePath(GetCurrentResourceName()).."/update.zip"
            local f = assert(io.open(savePath, 'wb'))
            f:write(data)
            f:close()
            infoLog("Saved file...")
            doUnzip(savePath)
        else
            errorLog(("Failed to download from %s: %s %s"):format(realUrl, code, data))
        end
    end, "GET")
    
end

function RunAutoUpdater(manualRun)
    if Config.updateBranch == nil then
        return
    end
    local f = LoadResourceFile(GetCurrentResourceName(), "/update.zip")
    if f ~= nil then
        -- remove the update file and stop the helper
        ExecuteCommand("stop snaily_updatehelper")
        os.remove(GetResourcePath(GetCurrentResourceName()).."/update.zip")
        os.remove(GetResourcePath("snaily_updatehelper").."/run.lock")
    end
    local versionFile = Config.autoUpdateUrl
    if versionFile == nil then
        versionFile = "https://raw.githubusercontent.com/TaylorMcGaw-LARP/SnailyCADLuaIntegration/{branch}/snailycad/version.json"
    end
    versionFile = string.gsub(versionFile, "{branch}", Config.updateBranch)
    local myVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)

    PerformHttpRequest(versionFile, function(code, data, headers)
        if code == 200 then
            local remote = json.decode(data)
            if remote == nil then
                warnLog(("Failed to get a valid response for %s. Skipping."):format(k))
                debugLog(("Raw output for %s: %s"):format(k, data))
            else
                local latestVersion = string.gsub(remote.resource, "%.","")
                local localVersion = string.gsub(myVersion, "%.", "")

                assert(localVersion ~= nil, "Failed to parse local version. "..tostring(localVersion))
                assert(latestVersion ~= nil, "Failed to parse remote version. "..tostring(latestVersion))
                if latestVersion > localVersion then
             
                    if not Config.allowAutoUpdate then
                        print("^3|==========================================================================|")
                        print("^3|                ^1SnailyCADLuaIntegration Update Available                  ^3|")
                        print("^3|                             ^8Current : " .. localVersion .. "                                ^3|")
                        print("^3|                             ^2Latest  : " .. latestVersion .. "                                ^3|")
                        print("^3| Download at: ^4https://github.com/TaylorMcGaw-LARP/SnailyCADLuaIntegration ^3|")
                        print("^3|==========================================================================|^7")
                        if Config.allowAutoUpdate == nil then
                            warnLog("You have not configured the automatic updater. Please set allowAutoUpdate in config.json to allow updates.")
                        end
                    else
                        infoLog("Running auto-update now...")
                        doUpdate(remote.resource)
                    end
                else
                    if manualRun then
                        infoLog("No updates available.")
                    end
                end
            end
        end
    end, "GET")
end


CreateThread(function()
    while true do
        if pendingRestart then
            if GetNumPlayerIndices() > 0 then
                warnLog("An update has been applied to snailyCAD but requires a resource restart. Restart delayed until server is empty.")
            else
                infoLog("Server is empty, restarting resources...")
                local f = assert(io.open(GetResourcePath("snaily_updatehelper").."/run.lock", "w+"))
                f:write("core")
                f:close()
                ExecuteCommand("ensure snaily_updatehelper")
            end
        else
            RunAutoUpdater()
        end
        Wait(60000*60)
    end
end)