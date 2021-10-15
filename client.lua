ESX = nil
CargarObjeto = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end 
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


Citizen.CreateThread(function()
    while true do 
        local _msec = 250
        if PlayerData.job and PlayerData.job.name == 'mechanic' then
            _msec = 0
            if IsControlJustPressed(0, 167) then
                ESX.ShowNotification('🙌| Menú Mecanico', "success")
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
                    title = "Menu Mecanico",
                    subtitle= "Menu LSCustom",
                    align = "right",
                    elements = {
                        {label ="Reparar", value = "repair"},
                        {label ="Limpiar", value = "limpiar"},
                        {label ="Facturar", value = "facturar"},
                    }
                }, function(data,menu)
                    local c = data.current
                    if data.current.value == "repair" then
                        TriggerEvent('mecanico:reparar')
                    elseif data.current.value == "limpiar" then
                        TriggerEvent('mecanico:limpiar')
                    elseif data.current.value == "facturar" then
                        TriggerEvent('mecanico:factura')
                    end

                end, function(data,menu)
                    menu.close()
                end)
            end
        end
        Citizen.Wait(_msec)
    end
end)



Citizen.CreateThread(function()
    while true do
        local _msec = 250
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

        for k,v in pairs(Config.Props) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y,v.z) <= 3.0 then
                _msec = 0
                if PlayerData.job and PlayerData.job.name == 'mechanic' then
                    ESX.ShowFloatingHelpNotification('~b~[E]~w~ | Props', v)
                    if IsControlJustPressed(0,38) then
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
                            title = "Menu Mecanico",
                            subtitle= "Menu props",
                            align = "right",
                            elements = {
                                {label ="Llanta", value = "llanta"},
                                {label ="Puerta", value = "puerta"},
                            }
                        }, function(data,menu)
                            local c = data.current
                            if data.current.value == "puerta" then
                                TriggerEvent('mecanico:prop', {prop = "door"})
                            elseif data.current.value == "llanta" then
                                TriggerEvent('mecanico:prop', {prop = "tire"})

                            end
        
                        end, function(data,menu)
                            menu.close()
                        end)
                    end
                end
            end
        end

        for k,v in pairs(Config.MenuGeneral) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y,v.z) <= 3.0 then
                _msec = 0
                if PlayerData.job and PlayerData.job.name == 'mechanic' then
                    ESX.ShowFloatingHelpNotification('~b~[E]~w~ | Menu General', v)
                    if IsControlJustPressed(0,38) then
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
                            title = "Menu Mecanico",
                            subtitle= "Menu General",
                            align = "right",
                            elements = {
                                {label ="Outfit de trabajo", value = "outfits"},
                                {label ="Outfits Guardados", value = "casual"},
                                {label ="Regresar a ropa civil", value = "civil"},
                                {label = '<span style="color: lightblue;">-------</span> Organizacion <span style="color: lightblue;">-------</span>'},
                                {label = "Sociedad", value ="society"},
                                {label = "Inventario", value ="inventory"},
                                {label = "Vehiculos", value = "vehicles"},

                            }
                        }, function(data,menu)
                            local c = data.current
                            if data.current.value == "outfits" then
                                TriggerEvent('mecanico:outfits', {outfits = "trabajo"})
                            elseif data.current.value == "civil" then
                                TriggerEvent('mecanico:outfits', {outfits = "normal"})
                            elseif data.current.value == "casual" then
                                TriggerEvent('mecanico:outfits', {outfits = "casual"})
                            elseif data.current.value == "society" then
                                TriggerEvent('mecanico:sociedad')
                            elseif data.current.value == "inventory" then
                                TriggerEvent('mecanico:inventario')
                                menu.close()
                            elseif data.current.value == "vehicles" then
                                menu.close()
                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu2', {
                                    title = "Menu Mecanico",
                                    subtitle = "Menu Vehiculos",
                                    align = "right",
                                    elements = {
                                        {label = "SlamVan", value = "slamvan"},
                                        {label = "Flatbed", value = "flatbed"},
                                        {label = "TowTruck", value = "towtruck"},
                                        {label = "Bison", value = "bison"},
                                    }
                                }, function(data2,menu2)
                                    if data2.current.value == "slamvan" then
                                        menu2.close()
                                        TriggerEvent('mecanico:carro', {carro = "slamvan"})
                                    elseif data2.current.value == "flatbed" then
                                        menu2.close()
                                        TriggerEvent('mecanico:carro', {carro = "flatbed"})
                                    elseif data2.current.value == "towtruck" then
                                        menu2.close()
                                        TriggerEvent('mecanico:carro', {carro = "towtruck2"})
                                    elseif data2.current.value == "bison" then
                                        menu2.close()
                                        TriggerEvent('mecanico:carro', {carro = "bison2"})
                                    end

                                end, function(data2, menu2)
                                    menu2.close()
                                end)
                            end
        
                        end, function(data,menu)
                            menu.close()
                        end)
                    end
                end
            end
        end

        for k,v in pairs(Config.BorrarVeh) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y,v.z) <= 3.0 then
                _msec = 0
                if PlayerData.job and PlayerData.job.name == 'mechanic' then
                    ESX.ShowFloatingHelpNotification('~b~[E]~w~ | Guardar Vehiculo', v)
                    if IsControlJustPressed(0,38) then
                        ESX.ShowNotification('El Vehiculo fue guardado satisfactoriamente')
                        DeleteVehicle(vehicle)
                    end
                end
            end
        end
        Citizen.Wait(_msec)
    end
end)



-- Events --

RegisterNetEvent('mecanico:carro')
AddEventHandler('mecanico:carro', function(data)
    local carro = data.carro
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    for k,v in pairs(Config.SpawnVehiculo) do
        Citizen.Wait(0)
        if carro == 'bison2' and PlayerData.job.grade_name == 'boss' then
            DoScreenFadeOut(500)

            ESX.Game.SpawnVehicle(carro, v, 168.5, function(vehicle)
                ESX.ShowNotification('Tu vehiculo fue sacado del garage satisfactoriamente')
                ESX.Game.SetVehicleProperties(vehicle, {
                    plate = PlayerData.job.grade_name,
                })
                Citizen.Wait(2000)
                DoScreenFadeIn(2000)

                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            end)
            
        elseif carro ~= 'bison2' then
            DoScreenFadeOut(500)

            ESX.Game.SpawnVehicle(carro, v, 168.5, function(vehicle)
                ESX.ShowNotification('Tu vehiculo fue sacado del garage satisfactoriamente')
                ESX.Game.SetVehicleProperties(vehicle, {
                    plate = PlayerData.job.grade_name,
                })
                Citizen.Wait(2000)
                DoScreenFadeIn(2000)

                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            end)

        else
            ESX.ShowNotification('No eres jefe, regresa mas tarde cuando lo seas', "error")
        end
    end
end)

RegisterNetEvent('mecanico:outfits')
AddEventHandler('mecanico:outfits', function(data)
    local outfits = data.outfits

    if outfits == "trabajo" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, {
                    sex      = 0,
                    tshirt_1 = 15,
                    tshirt_2 = 0,
                    arms     = 1,
                    torso_1  = 65,
                    torso_2  = 0,
                    shoes_1 = 24,
                    shoes_2 = 0,
                    pants_1  = 39,
                    pants_2  = 0
                })
            else
                TriggerEvent('skinchanger:loadClothes', skin, {
                    sex      = 1,
                    tshirt_1 = 0,
                    tshirt_2 = 0,
                    arms     = 1,
                    torso_1  = 59,
                    torso_2  = 0,
                    pants_1  = 39,
                    pants_2  = 0
                })
                RequestModel(model)
                while not HasModelLoaded(model) do
                    RequestModel(model)
                    Citizen.Wait(0)
                end
                SetPlayerModel(PlayerId(), model)
                SetModelAsNoLongerNeeded(model)
            end
        end)
    elseif outfits == "normal" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            local model = nil

            if skin.sex == 0  then
            model = GetHashKey("mp_m_freemode_01")
            else
            model = GetHashKey("mp_f_freemode_01")
            end

            RequestModel(model)
            while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
            end

            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)

            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerEvent('esx:restoreLoadout')
        end)
        inService = false
    elseif outfits == "casual" then
        ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
            local elements = {}
            for i=1, #dressing, 1 do
            table.insert(elements, {label = dressing[i], value = i})
            end
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
                title    = 'Tus vestimentas',
                align    = 'right',
                elements = elements,
            }, function(data, menu)
                TriggerEvent('skinchanger:getSkin', function(skin)
                ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)
                    TriggerEvent('skinchanger:loadClothes', skin, clothes)
                    TriggerEvent('esx_skin:setLastSkin', skin)
                    TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerServerEvent('esx_skin:save', skin)
                    end)
                    
                    ESX.ShowNotification('Vestimenta puesta')
                    HasLoadCloth = true
                end, data.current.value)
                end)
            end, function(data, menu)
                menu.close()
                
            end)
        end)
    end



end)

RegisterNetEvent('mecanico:inventario')
AddEventHandler('mecanico:inventario', function(data)
    exports['linden_inventory']:OpenStash({ id = 'Mecanico', slots = 70, job= 'mechanic'})
end)

RegisterNetEvent('mecanico:sociedad')
AddEventHandler('mecanico:sociedad', function()
    if PlayerData.job.grade_name == 'boss' then
        print(PlayerData.job.grade_name)
        ESX.ShowNotification('Menu Sociedad')
        TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
            menu.close()
            align    = 'bottom-right'
        end, { wash = false })
    elseif PlayerData.job.grade_name ~= 'boss' then
        ESX.ShowNotification('Lo siento no eres jefe')
    end
end)

RegisterNetEvent('mecanico:prop')
AddEventHandler('mecanico:prop', function(data)
    local prop = data.prop
    local player = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    if prop == "door" then

        CargarAnim("anim@heists@narcotics@trash")

        if not DoesEntityExist(CargarObjeto) then
            ESX.Game.SpawnObject("prop_car_door_01", {x = coords.x, y = coords.y, z = coords.z}, function(spawnObj)
                CargarObjeto = spawnObj
                ESX.ShowNotification('H | Soltar/Quitar')
                AttachEntityToEntity(CargarObjeto, player, GetPedBoneIndex(player, 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
            end)
        end

        while true do 
            Citizen.Wait(1)
            
            if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@narcotics@trash", "walk", 3) then
                TaskPlayAnim(PlayerPedId(), "anim@heists@narcotics@trash", "walk", 8.0, 8.0, -1, 50, 0, false, false, false)
            end
            
            if IsControlJustReleased(0, 74) then                           
                DetachEntity(CargarObjeto, 1, 0)
                ESX.Game.DeleteObject(CargarObjeto)
                CargarObjeto = nil
                ClearPedTasksImmediately(player)
                Citizen.Wait(100)
                TaskStartScenarioInPlace(player, "WORLD_HUMAN_WELDING", 0, true)
                ESX.ShowNotification('Instalando')
                Citizen.Wait(2000)
                ClearPedTasksImmediately(player)
                Citizen.Wait(100)
                break
            end
        end	
    elseif prop == "tire" then
        CargarAnim("anim@heists@box_carry@")

        if not DoesEntityExist(CargarObjeto) then 
            ESX.Game.SpawnObject("prop_wheel_03", {x = coords.x, y = coords.y, z = coords.z}, function(spawnObj)
                CargarObjeto = spawnObj
                ESX.ShowNotification('H | Soltar/Quitar')
        --		local boneIndex = GetPedBoneIndex(player, 28422)
                AttachEntityToEntity(CargarObjeto, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.15, 0.0, 0.23, 60.0, 100.0, 10.0, true, true, false, true, 1, true)
                TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "walk", 8.0, -8, -1, 49, 0, 0, 0, 0)
            end)
        end
        
        while true do 
            Citizen.Wait(1)
                    
            if IsControlJustReleased(0, 74) then                           
                DetachEntity(CargarObjeto, 1, 0)
                ESX.Game.DeleteObject(CargarObjeto)
                CargarObjeto = nil
                ClearPedTasksImmediately(player)
                Citizen.Wait(100)
                break
            end
        end	 
    end

end)

RegisterNetEvent('mecanico:reparar')
AddEventHandler('mecanico:reparar', function()
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    local coords    = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        ESX.ShowNotification('Estas sentado en un vehiculo')
        --ESX.ShowNotification('You're sitting in a vehicle') 
        return
    end

    if DoesEntityExist(vehicle) then
        if Config.UseProgressBar then
            SetVehicleDoorOpen(vehicle, 4, true, true)
            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true) -- Animation
            local finished = exports['fishy_taskbar']:taskBar(5000,"Reparando Vehiculo")
            ClearPedTasksImmediately(playerPed)
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)

        else
            ESX.ShowNotification('Reparando Vehiculo')
            -- ESX.ShowNotification('Repairing Vehicle')
            SetVehicleDoorOpen(vehicle, 4, true, true)

            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true) -- Animation
            Citizen.Wait(5000)
            ClearPedTasksImmediately(playerPed)

            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)
        end
    else
        ESX.ShowNotification('Ningun vehiculo enfrente')
        --ESX.ShowNotification('No vehicle infront.')
    end
end)

RegisterNetEvent('mecanico:limpiar')
AddEventHandler('mecanico:limpiar', function()
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    local coords    = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        ESX.ShowNotification('Estas sentado en un vehiculo')
        --ESX.ShowNotification('You're sitting in a vehicle') 
        return
    end

    if DoesEntityExist(vehicle) then
        if Config.UseProgressBar then
            ESX.ShowNotification('Limpiando Vehiculo')
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MAID_CLEAN", 0, true) -- Animation
            local finished = exports['fishy_taskbar']:taskBar(5000,"Limpiando Vehiculo")
            ClearPedTasksImmediately(playerPed)
            -- limpieza
            SetVehicleDirtLevel(vehicle, 0.0)
            ESX.ShowNotification('Vehiculo limpio')
        else
            ESX.ShowNotification('Limpiando Vehiculo')
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MAID_CLEAN", 0, true) -- Animation
            Citizen.Wait(5000)
            ClearPedTasksImmediately(playerPed)
            SetVehicleDirtLevel(vehicle, 0.0)
            ESX.ShowNotification('Vehiculo limpio')
        end

    else
        ESX.ShowNotification('Ningun vehiculo enfrente')
        --ESX.ShowNotification('No vehicle infront.')
    end
end)

RegisterNetEvent('mecanico:factura')
AddEventHandler('mecanico:factura', function()
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    local coords    = GetEntityCoords(playerPed)
--
ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
    title = 'Factura LSCustom'
}, function(data, menu)
    local amount = tonumber(data.value)

    if amount == nil or amount < 0 then
        ESX.ShowNotification('Cantidad invalida')
    else
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
            ESX.ShowNotification('Ningun jugador cerca')
        else
            menu.close()
            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic', 'Mecanico', amount)
        end
    end
end, function(data, menu)
        menu.close()
    end)
end)




function CargarAnim(animDict)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function CargarModelo(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Blips) do
		local blip = AddBlipForCoord(v)

		SetBlipSprite (blip, 446)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 35)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('LSCustom | Taller Mecanico')
		EndTextCommandSetBlipName(blip)
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        ESX.UI.Menu.CloseAll()
    end
end)
