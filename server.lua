ESX = exports.es_extended:getSharedObject()

if Config.VersionCheck then
    if not lib then return end

    lib.versionCheck('ffpetrozzi/esx_carkey')
end

RegisterCommand('givekey', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(args[1])
    local xSender = ESX.GetPlayerFromId(source)
    if xPlayer then
        local metadata = {}
        metadata.plate = args[2] -- EXAMPLE: ABC123
        metadata.description = 'Owner: ' .. xPlayer.name .. '  \nPlate: ' .. metadata.plate

        xPlayer.addInventoryItem(Config.ItemName, 1, metadata)
    else
        xSender.showNotification('ID not found!')
    end
end)
