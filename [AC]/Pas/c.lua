local active = false

local exectureFileNames = {
    "string",
}


local whiteListFunctions = {
    ["getResourceFromName"] = true;
    ["getResourceRootElement"] = true;
    ["call"] = true;
    ["getElementType"] = true;
    ["getPlayerName"] = true;
    ["engineLoadTXD"] = true;
    ["engineLoadCOL"] = true;
    ["engineLoadDFF"] = true;
    ["engineImportTXD"] = true;
    ["engineImportCOL"] = true;
    ["engineReplaceModel"] = true;
    ["toggleControl"] = true;
    ["getElementInterior"] = true;
    ["getElementDimension"] = true;
    ["setCameraMatrix"] = true;
    ["setCameraTarget"] = true;
    ["dxCreateShader"] = true;
    ["tocolor"] = true;
    ["outputDebugString"] = true;
    ["isPedInVehicle"] = true;
    ["setElementAngularVelocity"] = true;
    ["getPedOccupiedVehicle"] = true;
    ["dxSetShaderValue"] = true;
    
    
    
     
    ["setElementVelocity"] = true;
    ["getElementData"] = true;
    ["getElementModel"] = true;
    ["isElement"] = true;
    ["getUserdataType"] = true;
    ["setElementData"] = true;
    ["destroyElement"] = true;
    ["setElementAlpha"] = true;

    
     
}



local FunctionsList = {
    ["outputChatBox"] = true,
   
}


function is_illegal_string(str)
    for _, illegal_str in pairs(exectureFileNames) do
        if (string.find(tostring(str), illegal_str)) then
            return true;
        end
    end
    return false;
end

function isGuiCheatPanel(args)
    local text = string.lower(args[5]);
    if text:find("cheat") or text:find("shine") or text:find("sharingan") or text:find("AimBot") then 
        return true;
    end
    return false;
end

function cheatPanelCheck(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    if (not active) then return; end
    local args = {...};
    if (isGuiCheatPanel(args)) then
        triggerServerEvent("AntiCheat:CheatDetected", getLocalPlayer(), types[4]);
        return "skip";
    end
end

local antispam = 0;
function antispamCheck(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    if (not active) then return; end
    --Anti Spam
    antispam = antispam + 1;
    if (antispam >= 100) then
        triggerServerEvent("AntiCheat:CheatDetected", getLocalPlayer(), types[2]);
        return "skip";
    end
end

function mainAntiCheat(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    if (not active) then return; end
    local args = {...};
    local resname = sourceResource and getResourceName(sourceResource);
    
    if (whiteListFunctions[tostring(functionName)] ~= true) then
        --Cheat File
        if (is_illegal_string(luaFilename) or luaLineNumber == 0) then
            local string = "preFunction"
            .. " " .. tostring(resname)
            .. " " .. tostring(functionName)
            .. " allowed:" .. tostring(isAllowedByACL)
            .. " file:" .. tostring(luaFilename)
            .. "(" .. tostring(luaLineNumber) .. ")"
            .. " numArgs:" .. tostring(#args)
            .. " arg1:" .. tostring(args[1])

            triggerServerEvent("AntiCheat:CheatDetected", getLocalPlayer(), types[1], string);
            return "skip";
        end
    end
end

addEvent("startAntiCheat", true)
addEventHandler("startAntiCheat", root, function()
    active = true;
    setTimer(function()

        setTimer(function()
            addDebugHook("preFunction", mainAntiCheat)    
        end, 5*1000, 1)

        addDebugHook("preFunction", antispamCheck, {"triggerServerEvent"})

        --Restart AntiSpam Counts
        antispamtimer = setTimer(function()
            antispam = 0;
        end,1000,0)

        triggerServerEvent(localPlayer,"RetryAntiCheat", localPlayer)
        --Cheat panel
        addDebugHook("preFunction", cheatPanelCheck, {"guiCreateWindow"})
    end, 5000, 1)
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
    outputDebugString("Anti-cheat client resource started!")
end)

addEvent("stopAntiCheat", true);
addEventHandler("stopAntiCheat", root, function()

    active = false;
    removeDebugHook("preFunction", mainAntiCheat)
    removeDebugHook("preFunction", antispamCheck)
    removeDebugHook("preFunction", cheatPanelCheck)

    triggerServerEvent("CheckPlayer", resourceRoot)
    
    if (antispamtimer and isTimer(antispamtimer)) then
        killTimer(antispamtimer);
    end
end)