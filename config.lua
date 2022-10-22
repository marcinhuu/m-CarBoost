Config = {}

Config.Core = "qb-core" -- Your core name
Config.Target = "qb-target" -- Your qb-target name
Config.Webhook = "" -- Webhook for logs
Config.Payment = true -- Pay for upgrades?
Config.Type = "cash" -- "cash" or "bank"
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