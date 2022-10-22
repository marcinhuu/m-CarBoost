Config = {}

Config.Framework = "ESX" -- "QB" or "ESX"
Config.Core = "esx:getSharedObject" -- qb-core or esx:getSharedObject
Config.Webhook = "https://discord.com/api/webhooks/954483782101139456/iF74a8g1WfU58vtc6qoJq6KdHw_V2NFsZTiO4Phpg0UFir6Gn45jXDDvMWjeHELksBJ2" -- Webhook for logs
Config.Payment = true -- Pay for upgrades?
Config.Amount = 5000 -- Amount of pay
Config.Time = 5000 -- Time to apply the upgrades
Config.EnableCallCops = true -- Call cops?
Config.ChanceCallCops = 50 -- 50 %

Config.NPC = {
    [1] = {type = 4, hash= GetHashKey("s_m_y_construct_01"), x = 999.73,  y = -1490.67,  z = 30.35, h = 2.71},
}

Config.Blips = {
    [1] = {enable = true, x = 994.73, y = -1490.67, z = 30.35, sprite = 57, display = 4, scale = 2.0, colour = 7, name = "Car Boost"},
}


Language = {
   upgraded = "Vehicle upgraded!",
   apply = "Applying the upgrades...",
   target = "I need some boost!",
   canceled = "Canceled!",
   inside = "You need to be in a vehicle",
   Log = "The vehicle with plate:",
   Log2 = "was illegally upgraded.",
   money = "You dont have enought money",
}

function PoliceCall() 
    -- export your police call
end

function Notify(msg, type)
    if Config.Framework == "QB" then
        if type == "primary" then 
            QBCore.Functions.Notify(msg, "primary")
        end
        if type == "success" then
            QBCore.Functions.Notify(msg, "success")
        end
        if type == "error" then
            QBCore.Functions.Notify(msg, "error")
        end 
    elseif Config.Framework == "ESX" then
        if type == "primary" then 
            exports['mythic_notify']:DoHudText('inform', msg)
        end
        if type == "success" then
              exports['mythic_notify']:DoHudText('success', msg)
        end
        if type == "error" then
              exports['mythic_notify']:DoHudText('error', msg)
        end
    end
end