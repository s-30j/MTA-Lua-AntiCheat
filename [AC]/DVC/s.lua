
local discordWebhookURL = ""
function sendDiscordMessage(message)sendOptions = {formFields = {content="```"..message.."```  @everyone"},}fetchRemote ( discordWebhookURL, sendOptions, WebhookCallback )end function WebhookCallback(responseData) end

pl = {}

addEvent("RetryAntiCheat", true);
addEventHandler("RetryAntiCheat", root,
function()
    if (source and isElementPlayer(source)) then
        pl[source] = false
    end
end)

addEventHandler("onPlayerJoin", root, function()
    pl[source] = true
    setTimer(
        function(source)
            if source then
                if getPlayerName(source) then
                    if getPlayerFromName(getPlayerName(source)) then
                        if pl[source] then
                            kickPlayer ( source, "Game", "AntiCheat Not Ready for you\nconnect again and enjoy" )
                            sendDiscordMessage("AntiCheat Not Ready for "..getPlayerName(source).." Serial `"..getPlayerSerial(source).."`")
                        end
                    end
                end
            end
        end,20000,1
    )
    triggerClientEvent(source, "startAntiCheat", source)
end)

addEventHandler("onResourceStart", root, function()
    pl[source] = true
    setTimer(
        function(source)
            if source then
                if getPlayerName(source) then
                    if getPlayerFromName(getPlayerName(source)) then
                        if pl[source] then
                            kickPlayer ( source, "Game", "AntiCheat Not Ready for you\nconnect again and enjoy" )
                            sendDiscordMessage("AntiCheat Not Ready for "..getPlayerName(source).." Serial `"..getPlayerSerial(source).."`")
                        end
                    end
                end
            end
        end,90000,1
    )
    triggerClientEvent(source, "startAntiCheat", source)
end)


function isElementPlayer(theElement)
    if (theElement and isElement(theElement) and getElementType(theElement) == "player") then
        return true;
    end
    return false;
end

function ban(player, cheatType)
    if (isElementPlayer(player)) then
        local reason = "Unknown";
        if (cheatType and type(cheatType) == "string") then
            reason = cheatType;
        end
        local playerName = tostring(getPlayerName(player));
        local perfix = "[🔴]";
        reason = perfix.." "..reason.." Detected: "..playerName;
        local serial = getPlayerSerial(player);
        banPlayer(player, true, true, true, "AntiCheat", '\nEstefade Az Executor\nBaraye Baresi Ban Be Poshtibani Payam Bedid', 0)
        sendDiscordMessage(reason.."\n\nSerial: \n"..serial)
    end
end


addEvent("AntiCheat:CheatDetected", true);
addEventHandler("AntiCheat:CheatDetected", root,
function(cheatType, reason)
    if (client and isElementPlayer(client)) then
        if (source == client) then
            local playerName = "[🟡] Player " .. tostring(getPlayerName(client));
            ban(client, cheatType);
            if (reason and type(reason) == "string") then
                sendDiscordMessage(playerName .. "\n\n" .. reason);
            end
        end
    end
end)




