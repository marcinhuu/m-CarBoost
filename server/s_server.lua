if Config.Framework == "QB" then
    local QBCore = exports[Config.Core]:GetCoreObject()
elseif Config.Framework == "ESX" then
    ESX = nil
    TriggerEvent(Config.Core, function(obj) ESX = obj end)
end
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('^4The resource ^1' .. resourceName .. ' ^4has been started.')
    print('^4Developed by: ^1 marcinhu#0001^0')
    print('^4Any problem please join in our discord: ^1discord.gg/marcinhu^0')
    print('^4Version: ^11.0.0^0')
    print('^2ALL UPDATED! Enjoy it!^0')
end)

if Config.Framework == "QB" then
    QBCore.Functions.CreateCallback('m-CarBoost:server:VerificarGuita', function(source, cb)
        if QBCore.Functions.GetPlayer(source).Functions.RemoveMoney("cash", Config.Amount) then
            cb({
                state   = true,
            })
        else
            TriggerClientEvent('m-CarBoost:Client:Notify', source, Language.money, 'error', 5000)
        end
    end)
elseif Config.Framework == "ESX" then
    ESX.RegisterServerCallback('m-CarBoost:server:VerificarGuita', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getMoney() > 0 then
            xPlayer.removeMoney(Config.Amount)
            cb({ state   = true })
        else
            TriggerClientEvent('m-CarBoost:Client:Notify', source, Language.money, 'error', 5000)
        end
    end)
end


RegisterServerEvent('m-CarBoost:Server:LogServer')
AddEventHandler('m-CarBoost:Server:LogServer', function(message)
	GangsWebhook(message)
end)

function GangsWebhook(message)
    local embed = {}
    embed = {
        {
            ["color"] = 65280, -- GREEN = 65280 --- RED = 16711680
            ["title"] = "m-CarBoost | Logs",
            ["description"] = "" .. message ..  "",
            ["footer"] = {
            	["icon_url"] = "https://media.discordapp.net/attachments/1023351803103940668/1031313924768923768/logomaior.png",
                ["text"] = 'm-CarBoost | Logs | Created By marcinhu#0001',
            },
        }
    }
    PerformHttpRequest(Config.Webhook, 
    function(err, text, headers) end, 'POST', json.encode({username = 'm-Investigation - Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end
