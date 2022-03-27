local itemname = 'carkey' -- ITEM NAME
RegisterCommand('givekey', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(args[1])
    local xSender = ESX.GetPlayerFromId(source)
    if xPlayer then
        local metadata = {}
        metadata.plate = args[2] -- EXAMPLE: ABC123
        metadata.description = 'Owner: ' .. xPlayer.name .. '  \nPlate: ' .. metadata.plate

        xPlayer.addInventoryItem(itemname, 1, metadata)
    else
        xSender.showNotification('ID not found!')
    end
end)
