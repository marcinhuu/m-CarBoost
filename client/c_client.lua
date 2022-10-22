local QBCore = exports[Config.Core]:GetCoreObject()

local peds = Config.NPC
-- Peds
CreateThread(function()
    for _, item in pairs(peds) do
        RequestModel(item.hash)
        while not HasModelLoaded(item.hash) do Wait(1) end
        peds =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
        SetBlockingOfNonTemporaryEvents(peds, true)
        SetPedDiesWhenInjured(peds, false)
        SetEntityHeading(peds, item.h)
        SetPedCanPlayAmbientAnims(peds, true)
        SetPedCanRagdollFromPlayerImpact(peds, false)
        SetEntityInvincible(peds, true)
        FreezeEntityPosition(peds, true)
    end
end)

CreateThread(function()
    for _, info in pairs(Config.Blips) do
        if info.enable then
            info.blip = AddBlipForCoord(info.x, info.y, info.z)
            SetBlipSprite(info.blip, info.sprite)
            SetBlipDisplay(info.blip, info.display)
            SetBlipScale(info.blip, info.scale)
            SetBlipAlpha(info.blip, 80)
            SetBlipColour(info.blip, info.colour)
            SetBlipAsShortRange(info.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(info.name)
            EndTextCommandSetBlipName(info.blip)
        end
    end
end)

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

CreateThread(function()
    exports[Config.Target]:AddBoxZone("CarBoost", Config.NPC[1], 1, 2.2, 
    {   name = "CarBoost", heading = 22,debugPoly=false,
        }, {
            options = {{  
            event = 'm-CarBoost:Client:ApplyUpgrades', 
            icon = "fas fa-car", 
            label = Language.target
        },
    }, 
        distance = 5.0
    })
end)

RegisterNetEvent('m-CarBoost:Client:ApplyUpgrades', function() 
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(veh)
    if Config.EnableCallCops then local Chance = math.random(1,100) if Chance <= Config.ChanceCallCops then PoliceCall() end end
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        if Config.Payment then
            QBCore.Functions.TriggerCallback("m-CarBoost:server:VerificarGuita", function(cb)
                if cb then
                    SetVehicleDoorOpen(veh, 4, false, false)
                    QBCore.Functions.Progressbar('ApplyUpgrades', Language.apply, Config.Time, false, false, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function()
                        SetVehicleModKit(veh,0)
                        SetVehicleMod(veh,11,GetVehicleMod(veh,11),false)
                        SetVehicleMod(veh,12,GetVehicleMod(veh,12),false)
                        SetVehicleMod(veh,13,GetVehicleMod(veh,13),false)
                        SetVehicleMod(veh,15,GetVehicleMod(veh,15),false)
                        SetVehicleMod(veh,16,GetVehicleMod(veh,16),false)
                        ToggleVehicleMod(veh, 18, true) -- Turbo
                        ToggleVehicleMod(veh, 22, true) -- Xenon Headlights
                        TriggerEvent("QBCore:Notify", Language.upgraded)
                        TriggerServerEvent("m-CarBoost:Server:LogServer", Language.Log.." **["..plate.."]** "..Language.Log2)
                        SetVehicleDoorShut(veh, 4, false, false)
                    end, function() 
                        QBCore.Functions.Notify(Language.canceled, 'error')
                    end)
                end
            end)
        else
            QBCore.Functions.Progressbar('ApplyUpgrades', Language.apply, Config.Time, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                SetVehicleModKit(veh,0)
                SetVehicleMod(veh,11,GetVehicleMod(veh,11),false)
                SetVehicleMod(veh,12,GetVehicleMod(veh,12),false)
                SetVehicleMod(veh,13,GetVehicleMod(veh,13),false)
                SetVehicleMod(veh,15,GetVehicleMod(veh,15),false)
                SetVehicleMod(veh,16,GetVehicleMod(veh,16),false)
                ToggleVehicleMod(veh, 18, true) -- Turbo
                ToggleVehicleMod(veh, 22, true) -- Xenon Headlights
                TriggerEvent("QBCore:Notify", Language.upgraded)
                TriggerServerEvent("m-CarBoost:Server:LogServer", Language.Log.." **["..plate.."]** "..Language.Log2)
            end, function() 
                QBCore.Functions.Notify(Language.canceled, 'error')
            end)
        end
    else
        TriggerEvent("QBCore:Notify", Language.inside)
    end
end)

