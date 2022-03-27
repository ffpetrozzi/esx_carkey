ESX = exports.es_extended:getSharedObject()

RegisterNetEvent('ff_carkey:send')
AddEventHandler('ff_carkey:send', function(info)
    local Coords = GetEntityCoords(PlayerPedId())
    local AlrLock = false
    cars = ESX.Game.GetVehiclesInArea(Coords, 20)
    local carstrie = {}
    local cars_dist = {}
    a = 0
    if #cars ~= 0 then
        for j=1, #cars, 1 do
            local CarCoords = GetEntityCoords(cars[j])
            local distance = Vdist(CarCoords.x, CarCoords.y, CarCoords.z, CarCoords.x, CarCoords.y, CarCoords.z)
            table.insert(cars_dist, {cars[j], distance})
        end
        for k=1, #cars_dist, 1 do
            local z = -1
            local distance, car = 999
            for l=1, #cars_dist, 1 do
                if cars_dist[l][2] < distance then
                    distance = cars_dist[l][2]
                    car = cars_dist[l][1]
                    z = l
                end
            end
            if z ~= -1 then
                table.remove(cars_dist, z)
                table.insert(carstrie, car)
            end
        end
        for i=1, #carstrie, 1 do
            local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
            if plate == info.metadata.plate and AlrLock ~= true then
                local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
                vehicleLabel = GetLabelText(vehicleLabel)
                local lock = GetVehicleDoorLockStatus(carstrie[i])
                RequestAnimDict("anim@mp_player_intmenu@key_fob@")
                while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                    Citizen.Wait(100)
                end
                
                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, 2.0, -1, 50, 0, false, false, false)
                end
                if lock == 1 or lock == 0 then
                    SetVehicleDoorShut(carstrie[i], 0, false)
                    SetVehicleDoorShut(carstrie[i], 1, false)
                    SetVehicleDoorShut(carstrie[i], 2, false)
                    SetVehicleDoorShut(carstrie[i], 3, false)
                    SetVehicleDoorsLocked(carstrie[i], 2)
                    PlayVehicleDoorCloseSound(carstrie[i], 1)
                    ESX.ShowNotification('You locked '..vehicleLabel..'!')
                    SetVehicleLights(carstrie[i], 2)
                    Citizen.Wait(150)
                    SetVehicleLights(carstrie[i], 0)
                    Citizen.Wait(150)
                    SetVehicleLights(carstrie[i], 2)
                    Citizen.Wait(150)
                    SetVehicleLights(carstrie[i], 0)
                    AlrLock = true
                elseif lock == 2 then
                    SetVehicleDoorsLocked(carstrie[i], 1)
                    PlayVehicleDoorOpenSound(carstrie[i], 0)
                    ESX.ShowNotification('You unlocked '..vehicleLabel..'!')
                    SetVehicleLights(carstrie[i], 2)
                    Citizen.Wait(150)
                    SetVehicleLights(carstrie[i], 0)
                    Citizen.Wait(150)
                    SetVehicleLights(carstrie[i], 2)
                    Citizen.Wait(150)
                    SetVehicleLights(carstrie[i], 0)
                    AlrLock = true
                end
                ClearPedTasks(PlayerPedId())
            else
                a = a + 1
            end
            if a == #carstrie then
                ESX.ShowNotification('There are no cars nearby.')
            end
        end
    else
        ESX.ShowNotification('There are no cars nearby.')
    end
end)
