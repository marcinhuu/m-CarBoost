local QBCore = exports[Config.Core]:GetCoreObject()

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

QBCore.Functions.CreateCallback('m-CarBoost:server:VerificarGuita', function(source, cb)
    if QBCore.Functions.GetPlayer(source).Functions.RemoveMoney(Config.Type, Config.Amount) then
        cb({
            state   = true,
        })
    else
        TriggerClientEvent('QBCore:Notify', source, Language.money, 'error', 5000)
    end
end)

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
    function(err, text, headers) end, 'POST', json.encode({username = 'm-CarBoost - Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end
