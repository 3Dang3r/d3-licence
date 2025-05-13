local QBCore = exports['qb-core']:GetCoreObject()

local function hasLicense(citizenid, licenseType, cb)
    exports.oxmysql:execute('SELECT * FROM player_dlicenses WHERE citizenid = ? AND license_type = ?', { citizenid, licenseType }, function(result)
        cb(result and result[1] ~= nil)
    end)
end

local function giveLicense(citizenid, licenseType)
    exports.oxmysql:insert('INSERT IGNORE INTO player_dlicenses (citizenid, license_type) VALUES (?, ?)', { citizenid, licenseType })
end

local function removeLicense(citizenid, licenseType)
    exports.oxmysql:execute('DELETE FROM player_dlicenses WHERE citizenid = ? AND license_type = ?', { citizenid, licenseType })
end

local function giveLicenseItem(target, licenseType)
    if licenseType == "boat" then
        target.Functions.AddItem("boat_license", 1)
    elseif licenseType == "air" then
        target.Functions.AddItem("air_license", 1)
    end
end

local function removeLicenseItem(target, licenseType)
    if licenseType == "boat" then
        target.Functions.RemoveItem("boat_license", 1)
    elseif licenseType == "air" then
        target.Functions.RemoveItem("air_license", 1)
    end
end

QBCore.Commands.Add("givelicense", "Give a boat or air license", {
    { name = "id", help = "Player ID" },
    { name = "type", help = "License type: boat / air" }
}, 'god', function(source, args)
    local targetId = tonumber(args[1])
    local licenseType = tostring(args[2] or ""):lower()

    if not targetId or (licenseType ~= "boat" and licenseType ~= "air") then
        TriggerClientEvent("QBCore:Notify", source, "Usage: /givelicense [id] [boat/air]", "error")
        return
    end

    local Target = QBCore.Functions.GetPlayer(targetId)
    if not Target then
        TriggerClientEvent("QBCore:Notify", source, "Player not found.", "error")
        return
    end

    local cid = Target.PlayerData.citizenid
    giveLicense(cid, licenseType)
    giveLicenseItem(Target, licenseType)

    TriggerClientEvent("QBCore:Notify", Target.PlayerData.source, "You received your " .. licenseType .. " license!", "success")
    TriggerClientEvent("QBCore:Notify", source, "License granted successfully.", "success")
end)

QBCore.Commands.Add("removelicense", "Remove a boat or air license", {
    { name = "id", help = "Player ID" },
    { name = "type", help = "License type: boat / air" }
}, 'god', function(source, args)
    local targetId = tonumber(args[1])
    local licenseType = tostring(args[2] or ""):lower()

    if not targetId or (licenseType ~= "boat" and licenseType ~= "air") then
        TriggerClientEvent("QBCore:Notify", source, "Usage: /removelicense [id] [boat/air]", "error")
        return
    end

    local Target = QBCore.Functions.GetPlayer(targetId)
    if not Target then
        TriggerClientEvent("QBCore:Notify", source, "Player not found.", "error")
        return
    end

    local cid = Target.PlayerData.citizenid
    removeLicense(cid, licenseType)
    removeLicenseItem(Target, licenseType)

    TriggerClientEvent("QBCore:Notify", Target.PlayerData.source, "Your " .. licenseType .. " license has been removed.", "error")
    TriggerClientEvent("QBCore:Notify", source, "License removed successfully.", "success")
end)

QBCore.Functions.CreateCallback("boatairlicense:hasLicense", function(source, cb, licenseType)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return cb(false) end
    local citizenid = Player.PlayerData.citizenid
    hasLicense(citizenid, licenseType, cb)
end)
