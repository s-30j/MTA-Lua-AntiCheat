local discordWebhookURL = ""
function sendDiscordMessage(message)sendOptions = {formFields = {content="```"..message.."```  @everyone"},}fetchRemote ( discordWebhookURL, sendOptions, WebhookCallback )end function WebhookCallback(responseData) end


function player_Wasted ( ammo, attacker, weapon, bodypart )

	if weapon == 0 then
		local x1, y1, z1 = getElementPosition(source)
		local x2, y2, z2 = getElementPosition(attacker)
		if getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2) <= 8 then
			kickPlayer ( source, "Game", "headshot Without gun?" )
			banPlayer(source, true, true, true, "AntiCheat", 'Damage Without gun?', 0)
			sendDiscordMessage("headshot Without gun? "..getPlayerName(source).." Serial `"..getPlayerSerial(source).."`")
			return
		end
	end
	if bodypart == 9 then
		if weapon == 0 then
			kickPlayer ( source, "Game", "headshot Without gun?" )
			banPlayer(source, true, true, true, "AntiCheat", 'Damage Without gun?', 0)
			sendDiscordMessage("headshot Without gun? "..getPlayerName(source).." Serial `"..getPlayerSerial(source).."`")
		end
	end
end
addEventHandler ( "onPlayerWasted", root, player_Wasted )


function playerDamage_text ( attacker, weapon, bodypart, loss )
	if weapon == 0 then
		local x1, y1, z1 = getElementPosition(source)
		local x2, y2, z2 = getElementPosition(attacker)
		if getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2) <= 8 then
			kickPlayer ( source, "Game", "headshot Without gun?" )
			banPlayer(source, true, true, true, "AntiCheat", 'Damage Without gun?', 0)
			sendDiscordMessage("headshot Without gun? "..getPlayerName(source).." Serial `"..getPlayerSerial(source).."`")
			return
		end
	end
	if bodypart == 9 then
		if weapon == 0 then
			kickPlayer ( source, "Game", "headshot Without gun?" )
			banPlayer(source, true, true, true, "AntiCheat", 'Damage Without gun?', 0)
			sendDiscordMessage("headshot Without gun? "..getPlayerName(source).." Serial `"..getPlayerSerial(source).."`")
		end
	end
end
addEventHandler ( "onPlayerDamage", root, playerDamage_text )