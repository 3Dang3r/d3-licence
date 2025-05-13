local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while true do
        Wait(500)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(veh, -1) == ped then
                local class = GetVehicleClass(veh)
                local licenseType = nil

                if class == 14 then
                    licenseType = "boat"
                elseif class == 15 or class == 16 then
                    licenseType = "air"
                end

                if licenseType then
                    QBCore.Functions.TriggerCallback('boatairlicense:hasLicense', function(hasLicense)
                        if not hasLicense then
                            TaskLeaveVehicle(ped, veh, 0)
                            QBCore.Functions.Notify("You don't have a valid " .. licenseType .. " license!", "error")
                        end
                    end, licenseType)
                end
            end
        end
    end
end)
