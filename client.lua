local maxSpeed = 999.0

RegisterCommand('cc', function(source, args, rawCommand)
    local player = PlayerPedId()
    if not IsPedInAnyVehicle(player) then
        exports['mythic_notify']:DoHudText('error', "Du er ikke i noget køretøj")
    else
        if args[1] then
            local vehicle = GetVehiclePedIsIn(player)
            local vehicleSpeed = GetEntitySpeed(vehicle)
            if args[1] + 0.0 >= vehicleSpeed then
                maxSpeed = ((args[1] + 0.0) / 3.6) - 0.4
                exports['mythic_notify']:DoHudText('success', "Du har sat cruise control til "..args[1].." Km/t")
            else
                exports['mythic_notify']:DoHudText('error', "Cruise control kan ikke sættes til noget under til nuværende fart")
            end
        else 
            exports['mythic_notify']:DoHudText('inform', "Ophævede cruise control")
            maxSpeed = 999.0
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player) then
            local vehicle = GetVehiclePedIsIn(player)
            SetVehicleMaxSpeed(vehicle, maxSpeed)
        end        
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(65)
        if IsControlPressed(0, 20) or IsDisabledControlPressed(0, 20) then
            local player = PlayerPedId()
            if IsPedInAnyVehicle(player) then
                local vehicle = GetVehiclePedIsIn(player)
                SetVehicleMaxSpeed(vehicle, 999.0)
                
                while IsControlPressed(0, 20) or IsDisabledControlPressed(0, 20) do
                    Citizen.Wait(1)
                
                end
            end 
        end
    end
end)
